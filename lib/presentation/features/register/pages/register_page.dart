import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/widgets/buttons/app_buttons.dart';
import 'package:bid_for_cars/presentation/common/widgets/checkboxes/app_checkbox.dart';
import 'package:bid_for_cars/presentation/common/widgets/fields/app_fields.dart';
import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/common/widgets/snackbars/snackbar.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/features/register/bloc/register_cubit.dart';
import 'package:bid_for_cars/presentation/features/register/widgets/already_have_account_link.dart';
import 'package:bid_for_cars/presentation/routes/router.gr.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:bid_for_cars/presentation/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _firstNameTec;
  late final TextEditingController _lastNameTec;
  late final TextEditingController _emailTec;
  late final TextEditingController _passwordTec;
  late final TextEditingController _passwordConfirmTec;

  late final FocusNode _firstNameNode;
  late final FocusNode _lastNameNode;
  late final FocusNode _emailNode;
  late final FocusNode _passwordNode;
  late final FocusNode _passwordConfirmNode;

  @override
  void initState() {
    _firstNameTec = TextEditingController();
    _lastNameTec = TextEditingController();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
    _passwordConfirmTec = TextEditingController();

    _firstNameNode = FocusNode();
    _lastNameNode = FocusNode();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _passwordConfirmNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameTec.dispose();
    _lastNameTec.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
    _passwordConfirmTec.dispose();

    _firstNameNode.dispose();
    _lastNameNode.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    _passwordConfirmNode.dispose();

    super.dispose();
  }

  void _submit(BuildContext context) {
    context.scaffoldMessenger.clearSnacks();
    context.read<RegisterCubit>().registerUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: Builder(builder: (context) {
        final cubit = context.read<RegisterCubit>();

        return Scaffold(
          body: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (ctx, state) {
              if (state.result.isSome()) {
                if (state.result.asSome().isRight()) {
                  /// navigate to register success
                  context.router.replaceAll([const LoginRoute(), const RegistrationSuccessRoute()]);
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
                                  t.auth.register.title,
                                  style: context.theme.textTheme.headlineMedium,
                                ),
                                const HSB(10),
                                Text(
                                  t.auth.register.subtitle,
                                  style: context.theme.textTheme.titleLarge?.copyWith(
                                    color: AppColors.kTextSub,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                ),
                                const HSB(40),
                                AppTextField(
                                  keyboardType: TextInputType.name,
                                  label: t.auth.register.fields.labels.firstName,
                                  hint: t.auth.register.fields.hints.firstName,
                                  controller: _firstNameTec,
                                  focusNode: _firstNameNode,
                                  onChanged: (v) => cubit.firstNameChanged(v),
                                  validator: (_) => cubit.state.firstName.value.fold(
                                    (f) {
                                      return f.maybeMap(
                                          invalidFirstName: ((fv) {
                                            return Utils.validateFieldError(
                                              fv,
                                              showErrors: cubit.state.showErrors,
                                              errorMessage: t.auth.register.fields.errors.firstName,
                                            );
                                          }),
                                          orElse: () => null);
                                    },
                                    (s) => null,
                                  ),
                                  onSubmitted: (_) => _lastNameNode.requestFocus(),
                                ),
                                const HSB(20),
                                AppTextField(
                                  keyboardType: TextInputType.name,
                                  label: t.auth.register.fields.labels.lastName,
                                  hint: t.auth.register.fields.hints.lastName,
                                  controller: _lastNameTec,
                                  focusNode: _lastNameNode,
                                  onChanged: (v) => cubit.lastNameChanged(v),
                                  validator: (_) => cubit.state.lastName.value.fold(
                                    (f) {
                                      return f.maybeMap(
                                          invalidLastName: ((fv) {
                                            return Utils.validateFieldError(
                                              fv,
                                              showErrors: cubit.state.showErrors,
                                              errorMessage: t.auth.register.fields.errors.lastName,
                                            );
                                          }),
                                          orElse: () => null);
                                    },
                                    (s) => null,
                                  ),
                                  onSubmitted: (_) => _emailNode.requestFocus(),
                                ),
                                const HSB(20),
                                AppTextField(
                                  label: t.auth.register.fields.labels.email,
                                  hint: t.auth.register.fields.hints.email,
                                  keyboardType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
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
                                              errorMessage: t.auth.register.fields.errors.email,
                                            );
                                          }),
                                          orElse: () => null);
                                    },
                                    (s) => null,
                                  ),
                                  onSubmitted: (_) => _passwordNode.requestFocus(),
                                ),
                                const HSB(20),
                                AppTextField(
                                  label: t.auth.register.fields.labels.password,
                                  hint: t.auth.register.fields.hints.password,
                                  obscureText: true,
                                  textCapitalization: TextCapitalization.none,
                                  controller: _passwordTec,
                                  focusNode: _passwordNode,
                                  onChanged: (v) => cubit.passwordChanged(v),
                                  validator: (_) => cubit.state.password.value.fold(
                                    (f) => f.maybeMap(
                                        invalidPassword: ((fv) {
                                          return Utils.validateFieldError(
                                            fv,
                                            showErrors: cubit.state.showErrors,
                                            errorMessage: t.auth.register.fields.errors.password,
                                          );
                                        }),
                                        orElse: () => null),
                                    (s) => null,
                                  ),
                                  onSubmitted: (_) => _passwordConfirmNode.requestFocus(),
                                ),
                                const HSB(20),
                                AppTextField(
                                  label: t.auth.register.fields.labels.confirmPassword,
                                  hint: t.auth.register.fields.hints.confirmPassword,
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
                                                t.auth.register.fields.errors.confirmPassword,
                                          );
                                        }),
                                        orElse: () => null),
                                    (s) => null,
                                  ),
                                  onSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                                ),
                                const HSB(30),
                                AppCheckbox(
                                  labelSections: [
                                    AppCheckboxTextSection(text: t.auth.register.agreement.part1),
                                    AppCheckboxTextSection(
                                      text: t.auth.register.agreement.part2,
                                      onTap: TapGestureRecognizer()
                                        ..onTap = () async {
                                          //   TODO
                                        },
                                    ),
                                    AppCheckboxTextSection(text: t.auth.register.agreement.part3),
                                    AppCheckboxTextSection(
                                      text: t.auth.register.agreement.part4,
                                      onTap: TapGestureRecognizer()
                                        ..onTap = () async {
                                          //   TODO
                                        },
                                    ),
                                  ],
                                  onChanged: (v) => cubit.agreementChanged(v),
                                  value: cubit.state.isAgree,
                                ),
                                const HSB(30),
                                AppElevatedButton(
                                  label: t.auth.register.actions.register,
                                  disabled: !cubit.state.isValid,
                                  loading: cubit.state.processing,
                                  onPressed: () => _submit(context),
                                ),
                                const HSB(30),
                                const AlreadyHaveAccountLink(),
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
