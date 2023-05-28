import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/widgets/buttons/app_buttons.dart';
import 'package:bid_for_cars/presentation/common/widgets/fields/app_fields.dart';
import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/common/widgets/snackbars/snackbar.dart';
import 'package:bid_for_cars/presentation/common/widgets/ui_blocks/auth/return_to_login_link.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/features/forgot_password/bloc/request/forgot_password_cubit.dart';
import 'package:bid_for_cars/presentation/routes/router.gr.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:bid_for_cars/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RequestResetPasswordPage extends StatefulWidget {
  const RequestResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<RequestResetPasswordPage> createState() => _RequestResetPasswordPageState();
}

class _RequestResetPasswordPageState extends State<RequestResetPasswordPage> {
  late final TextEditingController _emailTec;

  late final FocusNode _emailNode;

  @override
  void initState() {
    _emailTec = TextEditingController();

    _emailNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailTec.dispose();

    _emailNode.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    context.scaffoldMessenger.clearSnacks();
    context.read<ForgotPasswordCubit>().requestPasswordReset();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgotPasswordCubit>(),
      child: Builder(builder: (context) {
        final cubit = context.read<ForgotPasswordCubit>();

        return Scaffold(
          body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (ctx, state) {
              if (state.result.isSome()) {
                if (state.result.asSome().isRight()) {
                  /// navigate to previous page
                  context.router.push(ResetPasswordRoute(email: state.email));
                } else {
                  /// show error message on failure
                  final error = state.result.asSome().asLeft();
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
                                  t.auth.forgotPass.title,
                                  style: context.theme.textTheme.headlineMedium,
                                ),
                                const HSB(10),
                                Text(
                                  t.auth.forgotPass.subtitle,
                                  style: context.theme.textTheme.titleLarge?.copyWith(
                                    color: AppColors.kTextSub,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                ),
                                const HSB(40),
                                AppTextField(
                                  label: t.auth.forgotPass.fields.labels.email,
                                  hint: t.auth.forgotPass.fields.hints.email,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailTec,
                                  focusNode: _emailNode,
                                  onChanged: (v) => cubit.emailChanged(v),
                                  validator: (_) => cubit.state.email.value.fold(
                                    (f) {
                                      return f.maybeMap(
                                          invalidEmail: ((fv) {
                                            return Utils.validateFieldError(
                                              fv,
                                              showErrors: cubit.state.showErrors,
                                              errorMessage: t.auth.forgotPass.fields.errors.email,
                                            );
                                          }),
                                          orElse: () => null);
                                    },
                                    (s) => null,
                                  ),
                                  onSubmitted: (_) => _submit(context),
                                ),
                                const HSB(30),
                                AppElevatedButton(
                                  label: t.auth.forgotPass.actions.resetPass,
                                  disabled: !cubit.state.isValid,
                                  loading: cubit.state.processing,
                                  onPressed: () => _submit(context),
                                ),
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
