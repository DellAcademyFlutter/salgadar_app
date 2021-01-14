import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';

class CartIconWidget extends StatefulWidget {
  @override
  _CartIconWidgetState createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {
  final controller = Modular.get<CartController>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Consumer<CartController>(
          builder: (context, value) {
            return Badge(
              badgeContent: Text('${controller.numItems}'),
              child: Icon(Icons.shopping_cart),
              position: BadgePosition.topStart(
                  start: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.03 * -1),
              animationType: BadgeAnimationType.slide,
            );
          },
        ),
        onPressed: () => null);
  }
}
