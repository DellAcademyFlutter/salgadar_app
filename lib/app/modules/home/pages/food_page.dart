import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/modules/home/components/item_by_subcategory_widget.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            isScrollable: false,
            tabs: [
              Tab(text: 'Salgados'),
              Tab(text: 'Pizzas'),
              Tab(text: 'Sanduíches'),
            ],
          ),
        ),
        body: Consumer<ItemController>(
          builder: (context, value) {
            return TabBarView(
              children: <Widget>[
                ItemBySubCateboryWidget(
                  key: UniqueKey(),
                  subcategory: SUBCATEGORY_SAVORY,
                ),
                ItemBySubCateboryWidget(
                  key: UniqueKey(),
                  subcategory: SUBCATEGORY_PIZZA,
                ),
                ItemBySubCateboryWidget(
                  key: UniqueKey(),
                  subcategory: SUBCATEGORY_HAMBURGER,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
