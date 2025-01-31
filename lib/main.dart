import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunflower_tools/modules/shared/config/controllers_initialized_config.dart';
import 'package:sunflower_tools/modules/shared/config/local_secure_data.dart';
import 'package:sunflower_tools/modules/shared/services/notification_service.dart';
import 'package:sunflower_tools/modules/shared/routes/routes.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await SharedData.init();
  tz.initializeTimeZones();
  ControllersInitializedConfig();

  runApp(const MyApp());
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
