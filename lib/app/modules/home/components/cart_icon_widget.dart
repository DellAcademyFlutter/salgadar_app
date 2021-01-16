import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
import 'package:salgadar_app/app/modules/home/pages/cart_page.dart';

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
              badgeColor: Theme.of(context).buttonColor,
              badgeContent: Text('${controller.totalItems}'),
              child: Icon(Icons.shopping_cart),
              position: BadgePosition.topStart(
                  start: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.03 * -1),
              animationType: BadgeAnimationType.slide,
            );
          },
        ),
        onPressed: () => Modular.link.pushNamed(CartPage.routeName));
  }
}
