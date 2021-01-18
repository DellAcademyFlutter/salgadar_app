import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/controllers/purchase_controller.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/controllers/user_settings_controller.dart';
import 'package:salgadar_app/app/modules/home/home_module.dart';
import 'package:salgadar_app/app/modules/login/login_module.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      runInitTasks(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Container(
          child: Center(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Icon(
                  Icons.fastfood,
                  size: MediaQuery.of(context).size.width * 0.5,
                ),
                Center(child: Text('Bem vindo ao Salgadar App!')),
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    backgroundColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Carrega inicializacoes necessarias.
  Future runInitTasks(BuildContext context) async {
    final itemController = Modular.get<ItemController>();
    final userController = Modular.get<UserController>();
    final cartController = Modular.get<CartController>();
    final purchaseController = Modular.get<PurchaseController>();
    final userSettingsController = Modular.get<UserSettingsController>();

    // Inicializacoes
    await userController.loadLastLoggedUser();
    await itemController.initializeItems();
    await cartController.initializeCart();
    await purchaseController.initializeUserPurchases();
    await userSettingsController.initializeUserSettings();

    if(userController.loggedUser != null) {
      Modular.to.pushReplacementNamed(HomeModule.routeName);
    }else{
         Modular.to.pushReplacementNamed(LoginModule.routeName);
    }
  }
}
