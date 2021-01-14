import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/models/item.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({Key key, this.item}) : super(key: key);
  final Item item;

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  final itemController = Modular.get<ItemController>();

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(children: [
          Container(
            child: itemController.getItemImage(
                item: widget.item, context: context),
          ),
        ]),
        TableRow(
          children: [
            Padding(
              padding: myTextPadding(),
              child: Text('${widget.item.name}'),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: myTextPadding(),
              child: Text('R\$: ${widget.item.price}'),
            ),
          ],
        ),
      ],
    );
  }

  EdgeInsets myTextPadding() => const EdgeInsets.fromLTRB(8, 0, 0, 0);
}
