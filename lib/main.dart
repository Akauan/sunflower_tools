import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunflower_tools/modules/shared/config/controllers_initialized_config.dart';
import 'package:sunflower_tools/modules/shared/services/farm_service.dart';
import 'package:sunflower_tools/modules/shared/config/local_secure_data.dart';
import 'package:sunflower_tools/modules/shared/services/notification_service.dart';
import 'package:sunflower_tools/modules/shared/routes/routes.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await NotificationService.init();
      tz.initializeTimeZones();
      ControllersInitializedConfig(); // Certifique-se de que essa função está definida corretamente
      String? farmData = await LocalSecureData.readSecureData('farm');
      if (farmData != null) {
        final int farmID = int.parse(farmData);
        FarmService().startWokmanagerTask(farmID);
      }
      log("Background task is running");
    } catch (e) {
      log("Error: ${e.toString()}");
    }
    return Future.value(true); // Always return a Future<bool>
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  tz.initializeTimeZones();
  ControllersInitializedConfig();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // Registra a tarefa periódica
  Workmanager().registerPeriodicTask(
    'farmBackgroundTask', // Nome único da tarefa
    'farmTask', // Nome usado no callbackDispatcher
    frequency: const Duration(
        minutes: 15), // Intervalo de execução (mínimo 15 minutos)
    initialDelay: const Duration(seconds: 10), // Delay inicial (opcional)
    constraints: Constraints(
      networkType: NetworkType.connected, // Executa apenas com conexão ativa
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresDeviceIdle: false,
      requiresStorageNotLow: false,
    ),
  );

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
