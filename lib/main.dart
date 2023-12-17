import 'package:doggo_dec_17/config/app_config.dart';
import 'package:doggo_dec_17/screens/doggo_screen.dart';
import 'package:doggo_dec_17/services/doggo_service/doggo_service.dart';
import 'package:flutter/material.dart';
import 'package:doggo_dec_17/utils/service_locator.dart' as srv_loc;

void main() {
  srv_loc.setupServiceLocator();

  const bool ciRun = bool.fromEnvironment('CI', defaultValue: false);

  AppConfig appConfig = ciRun ? IntegrationTestConfig() : DefaultAppConfig();

  runApp(MyApp(appConfig: appConfig));
}

class MyApp extends StatelessWidget {
  final AppConfig appConfig;

  const MyApp({super.key, required this.appConfig});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doggo display app made on December 17 2023',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: DoggoScreen(
          doggoService:
              DoggoService(baseDoggoApiUrl: appConfig.doggoBaseApiUrl)),
    );
  }
}
