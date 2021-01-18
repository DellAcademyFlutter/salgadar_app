import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/modules/home/pages/food_page.dart';

import 'components/cart_icon_widget.dart';
import 'components/side_menu_widget.dart';
import 'home_controller.dart';
import 'pages/drink_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final itemController = Modular.get<ItemController>();
  final cartController = Modular.get<CartController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller.pageViewController,
        scrollDirection: Axis.horizontal,
        children: [
          FoodPage(),
          DrinkPage(),
        ],
      ),
      drawer: SideMenuWidget(),
      floatingActionButton: CartIconWidget(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: AnimatedBuilder(
        animation: controller.pageViewController,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            currentIndex: controller.pageViewController?.page?.round() ?? 0,
            selectedItemColor: Theme.of(context).primaryColor.withBlue(255),
            onTap: (index) => controller.pageViewController.jumpToPage(index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.fastfood_outlined), label: 'comidas'),
              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_food_beverage_outlined),
                label: 'bebidas',
              )
            ],
          );
        },
      ),
    );
  }
}
