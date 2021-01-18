import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/models/item.dart';
import 'package:salgadar_app/app/models/item_cart.dart';
import 'package:salgadar_app/app/shared/utils/math_utils.dart';

class PurchaseItemWidget extends StatefulWidget {
  const PurchaseItemWidget({Key key, this.itemCart}) : super(key: key);

  final ItemCart itemCart;

  @override
  _PurchaseItemWidgetState createState() => _PurchaseItemWidgetState();
}

class _PurchaseItemWidgetState extends State<PurchaseItemWidget> {
  final itemController = Modular.get<ItemController>();
  Item item;

  @override
  void initState() {
    super.initState();
    item = itemController.getItemById(widget.itemCart.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: itemController.getItemImage(context: context, item: item),
        subtitle: Text('${widget.itemCart.qtt} x R\$ ${item.price}'),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text('${item.name}'),
        ),
        trailing: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
              '${MathUtils.round(number: item.price * widget.itemCart.qtt, decimalPlaces: 2)}'),
        ),
      ),
    );
  }
}
