import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/modules/home/home_module.dart';
import 'package:salgadar_app/app/shared/utils/preconfigure_salgadar.dart';

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
        alignment: Alignment.center,
        child: Container(
          child: Center(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                SizedBox(
                  height: 20,
                ),
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
    //await PreconfigureSalgadar.initializeSalgadarItems();
    await itemController.initializeItems();

    Future.delayed(const Duration(seconds: 5),
        () => Modular.to.pushReplacementNamed(HomeModule.routeName));
  }
}
