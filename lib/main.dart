import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:salgadar_app/app/shared/utils/local_notification/local_notification_utils.dart';

import 'app/app_module.dart';

main() async {
  await Stetho.initialize();
  await LocalNotificationUtils.initializeSettings();
  runApp(ModularApp(module: AppModule()));
}
