import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/modules/home/pages/cart_page.dart';
import 'package:salgadar_app/app/modules/login/pages/sign_up_page.dart';
import 'package:salgadar_app/app/modules/splash_screen/splash_screen_page.dart';
import 'package:salgadar_app/app/modules/user_purchase/pages/detailed_purchase_page.dart';

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
        ModularRouter(
          SignUpPage.routeName,
          child: (_, args) => SignUpPage(user: args.data.user),
          transition: TransitionType.leftToRightWithFade,
        ),
        ModularRouter(
          CartPage.routeName,
          child: (_, args) => CartPage(),
          transition: TransitionType.leftToRightWithFade,
        ),
        ModularRouter(
          DetailedPurchasePage.routeName,
          child: (_, args) => DetailedPurchasePage(
            purchase: args.data.purchase,
            key: args.data.key,
          ),
          transition: TransitionType.leftToRightWithFade,
        ),
      ];

  static Inject get to => Inject<SplashScreenModule>.of();
  static const routeName = '/splash';
}
