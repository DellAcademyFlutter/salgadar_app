import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/models/item.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget({this.index});

  final index;

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  final itemController = Modular.get<ItemController>();
  final cartController = Modular.get<CartController>();
  Item item;

  @override
  void initState() {
    super.initState();
    item = itemController
        .getItemById(cartController.cart.items[widget.index].itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: itemController.getItemImage(context: context, item: item),
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: Text('${item.name}')),
      ),
    );
  }
}
