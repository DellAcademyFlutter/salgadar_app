import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/modules/home/components/item_by_subcategory_widget.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';

class DrinkPage extends StatefulWidget {
  @override
  _DrinkPageState createState() => _DrinkPageState();
}

class _DrinkPageState extends State<DrinkPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            isScrollable: false,
            tabs: [
              Tab(text: 'Sucos'),
              Tab(text: 'Milkshakes'),
            ],
          ),
        ),
        body: Consumer<ItemController>(
          builder: (context, value) {
            return TabBarView(
              children: <Widget>[
                ItemBySubCateboryWidget(
                  key: UniqueKey(),
                  subcategory: SUBCATEGORY_JUICE,
                ),
                ItemBySubCateboryWidget(
                  key: UniqueKey(),
                  subcategory: SUBCATEGORY_SMOOTHIE,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
