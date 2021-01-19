import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/modules/login/pages/sign_up_page.dart';
import 'package:salgadar_app/app/modules/settings/pages/system_settings_page.dart';
import 'package:salgadar_app/app/modules/settings/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState
    extends ModularState<SettingsPage, SettingsController> {
  final userController = Modular.get<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
            animation: controller.pageViewController,
            builder: (context, snapshot) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text('Configurações' +
                    '${controller.pageViewController.page == controller.pageViewController.initialPage ? ' de sistema' : ' de usuário'}'),
              );
            }),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller.pageViewController,
        scrollDirection: Axis.horizontal,
        children: [
          SystemSettingsPage(),
          SignUpPage(user: userController.loggedUser),
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: controller.pageViewController,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            currentIndex: controller.pageViewController?.page?.round() ?? 0,
            selectedItemColor: Theme.of(context).primaryColor.withBlue(255),
            onTap: (index) => controller.pageViewController.jumpToPage(index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Sistema',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Usuário'),
            ],
          );
        },
      ),
    );
  }
}
