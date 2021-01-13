import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/user_settings_controller.dart';
import 'package:salgadar_app/app/modules/settings/settings_module.dart';
import 'package:salgadar_app/app/modules/splash_screen/splash_screen_module.dart';

import 'app_controller.dart';
import 'app_widget.dart';

class AppModule extends MainModule {
  @override

  /// Lista de injecoes de dependencia do projeto.
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => UserSettingsController()),
      ];

  @override

  /// Root Widget.
  Widget get bootstrap => AppWidget();

  @override

  /// Modulos associados a este aplicativo.
  List<ModularRouter> get routers => [
        ModularRouter(SplashScreenModule.routeName,
            module: SplashScreenModule()),
        ModularRouter(SettingsModule.routeName, module: SettingsModule()),
      ];
}
