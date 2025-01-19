import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunflower_tools/modules/shared/config/controllers_initialized_config.dart';
import 'package:sunflower_tools/modules/shared/config/farm_service.dart';
import 'package:sunflower_tools/modules/shared/config/local_secure_data.dart';
import 'package:sunflower_tools/modules/shared/config/notification_service.dart';
import 'package:sunflower_tools/modules/shared/routes/routes.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (await LocalSecureData.isLogged()) {
      NotificationService.showInstantNotification('Sunflower Tools',
          'A tarefa de fundo está sendo executada. Aguarde um momento.');
      final int farmID =
          int.parse(await LocalSecureData.readSecureData('farm'));
      FarmService().startBackgroundTask(
          farmID); // Use await para garantir que a tarefa termine antes de continuar.
    }
    log("Background task is running");
    return Future.value(true); // Sempre retorne um Future<bool>
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  await NotificationService.init();
  tz.initializeTimeZones();
  ControllersInitializedConfig();

  // Registra a tarefa periódica
  Workmanager().registerPeriodicTask(
    'farmBackgroundTask', // Nome único da tarefa
    'farmTask', // Nome usado no callbackDispatcher
    frequency: const Duration(
        minutes: 15), // Intervalo de execução (mínimo 15 minutos)
    initialDelay: const Duration(seconds: 10), // Delay inicial (opcional)
    constraints: Constraints(
      networkType: NetworkType.connected, // Executa apenas com conexão ativa
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
