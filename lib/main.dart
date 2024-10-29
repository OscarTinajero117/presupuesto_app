import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/dependencies/deps_injection.dart';
import 'app/core/sys_config/preferences/get_preferences.dart';
import 'app/core/sys_config/screen_config.dart';
import 'app/core/themes/dark_theme.dart';
import 'app/core/themes/light_theme.dart';
import 'app/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  screenConfig();

  ///Get dependens
  DependencyInjection.init();

  final isDarkMode = await GetPreferences.getPreference(
        parameter: Preferences.isDarkMode,
        value: '1',
      ) ==
      '1';

  runApp(MyApp(themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light));
}

class MyApp extends StatelessWidget {
  final ThemeMode themeMode;
  const MyApp({super.key, this.themeMode = ThemeMode.system});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Presupuestos',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'MX'),
        Locale('en', 'US'),
      ],
      initialRoute: Routes.HOME,
      getPages: AppPages.pages,
    );
  }
}
