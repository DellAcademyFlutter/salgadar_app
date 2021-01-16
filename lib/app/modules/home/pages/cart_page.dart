import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
import 'package:salgadar_app/app/modules/home/components/cart_icon_widget.dart';
import 'package:salgadar_app/app/modules/home/components/cart_item_widget.dart';
import 'package:salgadar_app/app/shared/utils/math_utils.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cartPage';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Modular.get<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartController>(
        builder: (context, value) {
          return Column(
            children: [
              ListTile(
                title: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text('Items escolhidos para Salgadar:'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: cartController.cart.items.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(key: UniqueKey(), index: index);
                    }),
              ),
              ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Valor total do carrinho:'),
                    Spacer(),
                    Text(
                        'R\$ ${MathUtils.round(number: cartController.totalValue, decimalPlaces: 2)}'),
                  ],
                ),
              ),
              ListTile(
                  title: RaisedButton(
                child: Text("Finalizar compra!"),
                onPressed: null,
              )),
            ],
          );
        },
      ),
    );
  }
}
