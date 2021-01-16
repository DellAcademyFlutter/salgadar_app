import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/modules/home/pages/cart_page.dart';

import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => HomePage(),
        ),
        ModularRouter(
          CartPage.routeName,
          child: (_, args) => CartPage(),
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
  static const routeName = '/home';
}
