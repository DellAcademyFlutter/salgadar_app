import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/modules/splash_screen/splash_screen_page.dart';

import 'splash_screen_controller.dart';

class SplashScreenModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashScreenController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => SplashScreenPage(),
          transition: TransitionType.leftToRightWithFade,
        ),
      ];

  static Inject get to => Inject<SplashScreenModule>.of();
  static const routeName = Modular.initialRoute;
}
