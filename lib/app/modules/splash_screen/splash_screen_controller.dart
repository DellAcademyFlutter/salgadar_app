import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
import 'package:salgadar_app/app/shared/utils/connectivity_utils.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/controllers/user_settings_controller.dart';
import 'package:salgadar_app/app/modules/home/home_module.dart';
import 'package:salgadar_app/app/modules/login/login_module.dart';
import 'package:salgadar_app/app/shared/utils/preconfigure_salgadar.dart';

class SplashScreenController {
  /// Carrega inicializacoes necessarias.
  Future runInitTasks(BuildContext context) async {
    final itemController = Modular.get<ItemController>();
    final userController = Modular.get<UserController>();
    final cartController = Modular.get<CartController>();
    final userSettingsController = Modular.get<UserSettingsController>();

    // Inicializacoes
    final hasInternet = await ConnectivityUtils.hasInternetConnectivity();
    if (hasInternet) {
      //await PreconfigureSalgadar.cacheAllInSQLite();
      await PreconfigureSalgadar.cacheItemsInSQLite();
    }
    await userController.loadLastLoggedUser();
    await itemController.initializeItems(context: context);
    await cartController.initializeCart();
    await userSettingsController.initializeUserSettings();

    if (userController.loggedUser != null) {
      await Modular.to.pushReplacementNamed(HomeModule.routeName);
    } else {
      await Modular.to.pushReplacementNamed(LoginModule.routeName);
    }
  }
}
