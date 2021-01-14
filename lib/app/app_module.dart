import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/user_settings_controller.dart';
import 'package:salgadar_app/app/data/api/cart_api_dao.dart';
import 'package:salgadar_app/app/data/api/item_api_dao.dart';
import 'package:salgadar_app/app/data/api/purchase_api_dao.dart';
import 'package:salgadar_app/app/data/local/cart_SQLite_dao.dart';
import 'package:salgadar_app/app/data/local/item_SQLite_dao.dart';
import 'package:salgadar_app/app/data/local/item_cart_SQLite_dao.dart';
import 'package:salgadar_app/app/data/local/purchase_SQLite_dao.dart';
import 'package:salgadar_app/app/modules/settings/settings_module.dart';
import 'package:salgadar_app/app/modules/splash_screen/splash_screen_module.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'controllers/cart_controller.dart';
import 'controllers/item_controller.dart';
import 'controllers/purchase_controller.dart';
import 'controllers/user_controller.dart';
import 'data/api/user_api_dao.dart';
import 'data/local/user_SQLite_dao.dart';
import 'modules/home/home_module.dart';

class AppModule extends MainModule {
  @override

  /// Lista de injecoes de dependencia do projeto.
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => UserSettingsController()),
        Bind((i) => UserController()),
        Bind((i) => ItemController()),
        Bind((i) => CartController()),
        Bind((i) => PurchaseController()),
        Bind((i) => UserAPIDao()),
        Bind((i) => ItemAPIDao()),
        Bind((i) => CartAPIDao()),
        Bind((i) => ItemCartSQLiteDao()),
        Bind((i) => PurchaseSQLiteDao()),
        Bind((i) => UserSQLiteDao()),
        Bind((i) => ItemSQLiteDao()),
        Bind((i) => CartSQLiteDao()),
        Bind((i) => PurchaseAPIDao()),
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
        ModularRouter(HomeModule.routeName, module: HomeModule()),
      ];
}
