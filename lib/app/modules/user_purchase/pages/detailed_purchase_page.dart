import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
import 'package:salgadar_app/app/models/item_cart.dart';
import 'package:salgadar_app/app/models/purchase.dart';
import 'package:salgadar_app/app/modules/user_purchase/components/purchase_item_widget.dart';

class DetailedPurchasePageArguments {
  DetailedPurchasePageArguments({this.purchase, this.key});

  final Purchase purchase;
  final Key key;
}

class DetailedPurchasePage extends StatefulWidget {
  static const routeName = '/detailedPurchase';
  const DetailedPurchasePage({Key key, this.purchase}) : super(key: key);

  final Purchase purchase;

  @override
  _DetailedPurchasePageState createState() => _DetailedPurchasePageState();
}

class _DetailedPurchasePageState extends State<DetailedPurchasePage> {
  final cartController = Modular.get<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da compra'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text('Preço total: '),
            ),
            trailing: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text('${widget.purchase.totalValue}'),
            ),
          ),
          ListTile(
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text('Data: '),
            ),
            trailing: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(widget.purchase.date),
            ),
          ),
          ListTile(
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text('Items: '),
            ),
            trailing: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text('${widget.purchase.totalQtt}'),
            ),
          ),
          FutureBuilder(
            future: cartController.getItemsCart(cartId: widget.purchase.cartId),
            builder:
                (BuildContext context, AsyncSnapshot<List<ItemCart>> snapshot) {
              return snapshot.hasData
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return PurchaseItemWidget(
                                key: UniqueKey(),
                                itemCart: snapshot.data[index]);
                          }),
                    )
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
