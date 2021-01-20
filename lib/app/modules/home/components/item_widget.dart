import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
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
  final cartController = Modular.get<CartController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await cartController.addItem(widget.item),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.175,
              child: FutureBuilder(
                future: itemController.getItemImage(
                    context: context, item: widget.item),
                builder: (context, snapshot) => snapshot.hasData
                    ? snapshot.data
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SingleChildScrollView(
                      padding: myTextPadding(),
                      scrollDirection: Axis.horizontal,
                      child: Text(widget.item.name)),
                  SingleChildScrollView(
                      padding: myTextPadding(),
                      scrollDirection: Axis.horizontal,
                      child: Text('R\$: ${widget.item.price}')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  EdgeInsets myTextPadding() => const EdgeInsets.fromLTRB(8, 0, 0, 0);
}
