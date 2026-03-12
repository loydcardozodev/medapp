import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:medapp/config/app_config.dart';
import 'package:medapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medapp/main.dart';
import 'package:medapp/providers/providers.dart';
import 'package:provider/provider.dart';

Future<void> bootstrap(AppConfig config) async {
  Logger.root.level = config.logLevel;
  Logger.root.onRecord.listen((record) {
    debugPrint(
      '[${record.level.name}] ${record.loggerName}: ${record.message}',
    );
  });

  WidgetsFlutterBinding.ensureInitialized();

  if (config.flavor == AppFlavor.firebase) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: buildProviders(config),
      child: MainApp(config: config),
    ),
  );
}
