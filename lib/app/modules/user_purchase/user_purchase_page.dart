import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/purchase_controller.dart';
import 'package:salgadar_app/app/modules/user_purchase/components/purchase_widget.dart';

class UserPurchasePage extends StatefulWidget {
  @override
  _UserPurchasePageState createState() => _UserPurchasePageState();
}

class _UserPurchasePageState extends State<UserPurchasePage> {
  final purchaseController = Modular.get<PurchaseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas compras'),
        centerTitle: true,
      ),
      body: Consumer<PurchaseController>(
        builder: (context, value) {
          return ListView.builder(
            itemCount: purchaseController.userPurchases.length,
            itemBuilder: (context, index) {
              return PurchaseWidget(key: UniqueKey(), index: index);
            },
          );
        },
      ),
    );
  }
}
