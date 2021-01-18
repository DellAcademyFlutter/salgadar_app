import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/models/item.dart';

import 'item_widget.dart';

class ItemBySubCateboryWidget extends StatefulWidget {
  const ItemBySubCateboryWidget({Key key, this.subcategory}) : super(key: key);

  final String subcategory;

  @override
  _ItemBySubCateboryWidgetState createState() =>
      _ItemBySubCateboryWidgetState();
}

class _ItemBySubCateboryWidgetState extends State<ItemBySubCateboryWidget> {
  final itemController = Modular.get<ItemController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          itemController.getItemsBySubCategory(subCategory: widget.subcategory),
      builder: (context, snapshot) {
        return snapshot.data != null
            ? GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                mainAxisSpacing: 4,
                crossAxisSpacing: 8,
                children: snapshot.data
                    .map<ItemWidget>(
                        (Item item) => ItemWidget(key: UniqueKey(), item: item))
                    .toList(),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
