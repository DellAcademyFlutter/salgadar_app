import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/data/api/cart_api_dao.dart';
import 'package:salgadar_app/app/models/cart.dart';
import 'package:salgadar_app/app/models/item_cart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RaisedButton(
          child: Text('Click me now!'),
          onPressed: () async => await postTest(),
        ),
      ),
    );
  }
}

/// Post - adiciona um [Cart] e retorna [id] gerado.
Future<int> postTest() async {
  final cartAPIDao = Modular.get<CartAPIDao>();

  final itemCart1 = ItemCart(
    cartId: 1,
    itemId: 2,
    itemPrice: 2.0,
    qtt: 1,
  );

  final itemCart2 = ItemCart(
    cartId: 1,
    itemId: 2,
    itemPrice: 2.0,
    qtt: 1,
  );

  final listItems = [itemCart1, itemCart2];

  final cart = Cart(
    id: 1,
    items: listItems,
  );

  await cartAPIDao.postCart(cart: cart).then((value) => print('$value'));
}
