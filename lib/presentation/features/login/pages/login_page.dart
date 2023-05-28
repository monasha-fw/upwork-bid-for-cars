import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/widgets/buttons/app_buttons.dart';
import 'package:bid_for_cars/presentation/common/widgets/fields/app_fields.dart';
import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/common/widgets/snackbars/snackbar.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/features/login/bloc/login_cubit.dart';
import 'package:bid_for_cars/presentation/features/login/widgets/forgot_pass_link.dart';
import 'package:bid_for_cars/presentation/features/login/widgets/get_started_link.dart';
import 'package:bid_for_cars/presentation/routes/router.gr.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:bid_for_cars/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailTec;
  late final TextEditingController _passwordTec;

  late final FocusNode _emailNode;
  late final FocusNode _passwordNode;

  @override
  void initState() {
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();

    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailTec.dispose();
    _passwordTec.dispose();

    _emailNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    context.scaffoldMessenger.clearSnacks();
    context.read<LoginCubit>().loginEmailUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Builder(builder: (context) {
        final cubit = context.read<LoginCubit>();

        return Scaffold(
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (ctx, state) {
              if (state.result.isSome()) {
                if (state.result.asSome().isRight()) {
                  /// navigate to Home Page on success
                  context.router.replace(const HomeRoute());
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                t.auth.login.title,
                                style: context.theme.textTheme.headlineMedium,
                              ),
                              const HSB(10),
                              Text(
                                t.auth.login.subtitle,
                                style: context.theme.textTheme.titleLarge?.copyWith(
                                  color: AppColors.kTextSub,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                ),
                              ),
                              const HSB(40),
                              AppTextField(
                                label: t.auth.login.fields.labels.email,
                                hint: t.auth.login.fields.hints.email,
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
                                            errorMessage: t.auth.login.fields.errors.email,
                                          );
                                        }),
                                        orElse: () => null);
                                  },
                                  (s) => null,
                                ),
                                onSubmitted: (_) => _passwordNode.requestFocus(),
                              ),
                              const HSB(30),
                              AppTextField(
                                label: t.auth.login.fields.labels.password,
                                hint: t.auth.login.fields.hints.password,
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
                                          errorMessage: t.auth.login.fields.errors.password,
                                        );
                                      }),
                                      orElse: () => null),
                                  (s) => null,
                                ),
                                onSubmitted: (_) => _submit(context),
                              ),
                              const HSB(30),
                              const ForgotPassLink(),
                              const HSB(30),
                              AppElevatedButton(
                                label: t.auth.login.actions.login,
                                disabled: !cubit.state.isValid,
                                loading: cubit.state.processing,
                                onPressed: () => _submit(context),
                              ),
                              const HSB(30),
                              const GetStartedLink(),
                              const HSB(30),
                            ],
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
