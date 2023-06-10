import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/widgets/buttons/app_buttons.dart';
import 'package:bid_for_cars/presentation/common/widgets/fields/app_fields.dart';
import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/common/widgets/snackbars/snackbar.dart';
import 'package:bid_for_cars/presentation/common/widgets/ui_blocks/auth/return_to_login_link.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/features/forgot_password/bloc/actions/forgot_password_actions_cubit.dart';
import 'package:bid_for_cars/presentation/features/forgot_password/bloc/reset/reset_password_cubit.dart';
import 'package:bid_for_cars/presentation/features/forgot_password/widgets/resend_code_link.dart';
import 'package:bid_for_cars/presentation/routes/router.gr.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:bid_for_cars/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key, required this.email}) : super(key: key);

  final EmailAddress email;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final TextEditingController _emailTec;
  late final TextEditingController _codeTec;
  late final TextEditingController _passwordTec;
  late final TextEditingController _passwordConfirmTec;

  late final FocusNode _codeNode;
  late final FocusNode _passwordNode;
  late final FocusNode _passwordConfirmNode;

  @override
  void initState() {
    _emailTec = TextEditingController(
      text: widget.email.isValid() ? widget.email.getOrCrash() : "",
    );
    _codeTec = TextEditingController();
    _passwordTec = TextEditingController();
    _passwordConfirmTec = TextEditingController();

    _codeNode = FocusNode();
    _passwordNode = FocusNode();
    _passwordConfirmNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailTec.dispose();
    _passwordTec.dispose();
    _passwordConfirmTec.dispose();

    _passwordNode.dispose();
    _passwordConfirmNode.dispose();

    /// will be disposed from the library
    /// _codeTec.dispose();
    /// _codeNode.dispose();

    super.dispose();
  }

  void _submit(BuildContext context) {
    context.scaffoldMessenger.clearSnacks();
    context.read<ResetPasswordCubit>().resetPassword();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ResetPasswordCubit>()
            ..emailChanged(widget.email.isValid() ? widget.email.getOrCrash() : ""),
        ),
        BlocProvider(create: (context) => getIt<ForgotPasswordActionsCubit>()),
      ],
      child: Builder(builder: (context) {
        final cubit = context.read<ResetPasswordCubit>();

        return Scaffold(
          body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (ctx, state) {
              if (state.result.isSome()) {
                if (state.result.asSome.isRight()) {
                  ///  show a success snack
                  context.scaffoldMessenger.showSnack(
                    t.auth.resetPassword.responses.submitSuccess,
                    SnackbarType.success,
                  );

                  /// and navigate to login page
                  context.router.popUntilRouteWithName(LoginRoute.name);
                } else {
                  /// show error message on failure
                  final error = state.result.asSome.asLeft;
                  context.scaffoldMessenger.showSnack(error, SnackbarType.error);
                }
              }
            },
            builder: (context, state) {
              return Listener(
                /// unfocus when tapped outside
                behavior: HitTestBehavior.opaque,
                onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                child: SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                          child: Form(
                            autovalidateMode: cubit.state.showErrors
                                ? AutovalidateMode.always
                                : AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  t.auth.resetPassword.title,
                                  style: context.theme.textTheme.headlineMedium,
                                ),
                                const HSB(10),
                                Text(
                                  t.auth.resetPassword.subtitle,
                                  textAlign: TextAlign.center,
                                  style: context.theme.textTheme.titleLarge?.copyWith(
                                    color: AppColors.kTextSub,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                ),
                                const HSB(40),
                                AppTextField(
                                  disabled: true,
                                  label: t.auth.resetPassword.fields.labels.email,
                                  hint: t.auth.resetPassword.fields.hints.email,
                                  controller: _emailTec,
                                ),
                                const HSB(30),
                                AppCodeField(
                                  controller: _codeTec,
                                  onCompleted: (String value) => _passwordNode.requestFocus(),
                                  focusNode: _codeNode,
                                  onChanged: (v) => cubit.codeChanged(v),
                                ),
                                const HSB(10),
                                AppTextField(
                                  label: t.auth.resetPassword.fields.labels.password,
                                  hint: t.auth.resetPassword.fields.hints.password,
                                  obscureText: true,
                                  controller: _passwordTec,
                                  focusNode: _passwordNode,
                                  onChanged: (v) => cubit.passwordChanged(v),
                                  validator: (_) => cubit.state.password.value.fold(
                                    (f) => f.maybeMap(
                                        invalidPassword: ((fv) {
                                          return Utils.validateFieldError(
                                            fv,
                                            showErrors: cubit.state.showErrors,
                                            errorMessage:
                                                t.auth.resetPassword.fields.errors.password,
                                          );
                                        }),
                                        orElse: () => null),
                                    (s) => null,
                                  ),
                                  onSubmitted: (_) => _passwordConfirmNode.requestFocus(),
                                ),
                                const HSB(30),
                                AppTextField(
                                  label: t.auth.resetPassword.fields.labels.confirmPassword,
                                  hint: t.auth.resetPassword.fields.hints.confirmPassword,
                                  obscureText: true,
                                  controller: _passwordConfirmTec,
                                  focusNode: _passwordConfirmNode,
                                  onChanged: (v) => cubit.confirmPasswordChanged(v),
                                  validator: (_) => cubit.state.confirmPassword.value.fold(
                                    (f) => f.maybeMap(
                                        invalidConfirmPassword: ((fv) {
                                          return Utils.validateFieldError(
                                            fv,
                                            showErrors: cubit.state.showErrors,
                                            errorMessage:
                                                t.auth.resetPassword.fields.errors.confirmPassword,
                                          );
                                        }),
                                        orElse: () => null),
                                    (s) => null,
                                  ),
                                  onSubmitted: (_) => _submit(context),
                                ),
                                const HSB(30),
                                AppElevatedButton(
                                  label: t.auth.resetPassword.actions.updatePass,
                                  disabled: !cubit.state.isValid,
                                  loading: cubit.state.processing,
                                  onPressed: () => _submit(context),
                                ),
                                const HSB(30),
                                ResendCodeLink(cubit.state.email),
                                const HSB(30),
                                const ReturnToLoginLink(),
                                const HSB(30),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
