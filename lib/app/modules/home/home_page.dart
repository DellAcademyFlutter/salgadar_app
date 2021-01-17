import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/models/item.dart';

import 'components/cart_icon_widget.dart';
import 'components/item_widget.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final itemController = Modular.get<ItemController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
      ),
      body: Consumer<ItemController>(
        builder: (context, value) {
          return GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            mainAxisSpacing: 0,
            crossAxisSpacing: 8,
            children: itemController.items
                .map<ItemWidget>(
                    (Item item) => ItemWidget(key: UniqueKey(), item: item))
                .toList(),
          );
        },
      ),
      floatingActionButton: CartIconWidget(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: controller.selectedIndex,
        builder: (context, value, child) {
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.fastfood_outlined), label: 'comidas'),
              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_food_beverage_outlined),
                label: 'bebidas',
              )
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Theme.of(context).primaryColor.withBlue(255),
            onTap: (index) => controller.changeSelectedIndex(index),
          );
        },
      ),
    );
  }
}
