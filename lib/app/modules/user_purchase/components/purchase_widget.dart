import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:salgadar_app/app/controllers/purchase_controller.dart';
import 'package:salgadar_app/app/modules/user_purchase/pages/detailed_purchase_page.dart';
import 'package:salgadar_app/app/shared/utils/alert_dialog_utils.dart';
import 'package:salgadar_app/app/shared/utils/math_utils.dart';

class PurchaseWidget extends StatefulWidget {
  const PurchaseWidget({Key key, this.index}) : super(key: key);

  final int index;

  @override
  _PurchaseWidgetState createState() => _PurchaseWidgetState();
}

class _PurchaseWidgetState extends State<PurchaseWidget> {
  final purchaseController = Modular.get<PurchaseController>();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        child: ListTile(
            onTap: () => Modular.link.pushNamed(DetailedPurchasePage.routeName,
                arguments: DetailedPurchasePageArguments(
                    purchase: purchaseController.userPurchases[widget.index],
                    key: UniqueKey())),
            title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                    'Salgadada (#cod${purchaseController.userPurchases[widget.index].id})')),
            subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                    'Data: ${purchaseController.userPurchases[widget.index].date}')),
            trailing: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                  'R\$: ${MathUtils.round(number: purchaseController.userPurchases[widget.index].totalValue, decimalPlaces: 2)}'),
            )),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Excluir',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            showAConfirmationDialog(
              context: context,
              title: 'Atenção!',
              message:
                  'Deseja remover Salgadada (#cod${purchaseController.userPurchases[widget.index].id})?',
              yesFunction: _yesFunction,
              noFunction: _noFunction,
            );
          },
        ),
      ],
    );
  }

  /// Funcao de confirmacao.
  _yesFunction() async {
    await purchaseController
        .removePurchase(purchaseController.userPurchases[widget.index]);
    Modular.to.pop();
  }

  /// Funcao de cancelamento.
  _noFunction() {
    Modular.to.pop();
  }
}
