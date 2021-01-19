import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/modules/settings/settings_module.dart';
import 'package:salgadar_app/app/modules/user_purchase/user_purchase_module.dart';

import '../home_controller.dart';

class SideMenuWidget extends StatefulWidget {
  @override
  _SideMenuWidgetState createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  final homeController = Modular.get<HomeController>();
  final userController = Modular.get<UserController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fastfood,
                  size: MediaQuery.of(context).size.width * 0.2,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(child: Text('Bem vindo ao Salgadar App,')),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                      child: Text('${userController.loggedUser?.name ?? ''}!')),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('configurações'),
              onTap: () {
                Modular.to.pop();
                Modular.to.pushNamed(SettingsModule.routeName);
              }),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Minhas compras'),
            onTap: () {
              Modular.to.pop();
              Modular.to.pushNamed(UserPurchaseModule.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Modular.to.pop();
              homeController.Logout();
            },
          )
        ],
      ),
    );
  }
}
