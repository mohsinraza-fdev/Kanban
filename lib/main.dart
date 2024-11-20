import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanban_app/app/router/router_config.router.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/network/api_client_kanban.dart';
import 'package:kanban_app/services/preference_service.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  setupServiceLocator();
  await initialiseServices();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('de')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

initialiseServices() async {
  await ThemeManager.initialise();
  await locator<PreferenceService>().initialise();
  locator<ApiClientKanban>().initialise();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      lightTheme: AppTheme.light,
      darkTheme: AppTheme.dark,
      builder: (context, regularTheme, darkTheme, themeMode) {
        switch (themeMode) {
          case ThemeMode.light:
            AppTheme.darkenStatusBar();
            break;
          default:
            AppTheme.brightenStatusBar();
        }
        return MaterialApp(
          title: 'Kanban',
          theme: regularTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,

          // Routing Configs
          navigatorObservers: [StackedService.routeObserver],
          navigatorKey: StackedService.navigatorKey,
          initialRoute: Routes.splashView,
          onGenerateRoute: StackedRouter().onGenerateRoute,

          // Localization Configs
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
