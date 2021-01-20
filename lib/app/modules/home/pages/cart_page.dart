import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
import 'package:salgadar_app/app/modules/home/components/cart_item_widget.dart';
import 'package:salgadar_app/app/shared/utils/math_utils.dart';

import '../home_controller.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cartPage';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final homeController = Modular.get<HomeController>();
  final cartController = Modular.get<CartController>();

  @override
  void initState() {
    super.initState();

    homeController.initializeActionSucess();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: homeController.isActionSuccess,
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Meu carrinho'),
            centerTitle: true,
          ),
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                bottom: MediaQuery.of(context).size.height / 2,
                child: AnimatedOpacity(
                  curve: Curves.linear,
                  opacity: homeController.isActionSuccess.value ? 1 : 0,
                  duration: Duration(milliseconds: 1000),
                  child: animatedFeedbackWidget(),
                ),
              ),
              AnimatedOpacity(
                curve: Curves.bounceIn,
                opacity: homeController.isActionSuccess.value ? 0 : 1,
                duration: Duration(milliseconds: 0),
                child: cartWidget(),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Widget do [Cart].
  cartWidget() {
    return Consumer<CartController>(
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
                  itemCount: cartController.userCart.items.length,
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
                    onPressed: cartController.userCart.items.isNotEmpty
                        ? () async {
                            await homeController.finalizePurchase(
                                context: context);
                          }
                        : null)),
          ],
        );
      },
    );
  }

  /// Widget de feedback animado.
  animatedFeedbackWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.done_outline,
            color: Colors.green,
          ),
          Text('Compra realizada com sucesso!'),
        ],
      ),
    );
  }
}
