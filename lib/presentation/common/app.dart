import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/auth/auth_cubit.dart';
import 'routes/router.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),

      /// Translations wrapper
      child: TranslationProvider(
        child: Builder(builder: (context) {
          /// Material app initialization
          return MaterialApp.router(
            title: 'Bid For Cars',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.dark,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            routerConfig: getIt<AppRouter>().config(),
            locale: TranslationProvider.of(context).flutterLocale,
            // use provider
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
          );
        }),
      ),
    );
  }
}
