import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:get/get.dart';
import 'package:sunflower_tools/modules/shared/config/controllers_initialized_config.dart';
import 'package:sunflower_tools/modules/shared/config/notification_service.dart';
import 'package:sunflower_tools/modules/shared/routes/routes.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Background Task Example",
    notificationText: "Running in the background",
    notificationImportance: AndroidNotificationImportance.max,
    enableWifiLock: true,
  );
  bool hasPermissions =
      await FlutterBackground.initialize(androidConfig: androidConfig);
  await NotificationService.init();
  tz.initializeTimeZones();
  ControllersInitializedConfig();

  if (hasPermissions) {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sunflower Tools',
      theme: ThemeColor.globalTheme,
      routes: Routes().routes,
      initialRoute: Routes().initialRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}
