import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:salgadar_app/app/controllers/purchase_controller.dart';
import 'package:salgadar_app/app/models/purchase.dart';
import 'package:salgadar_app/app/modules/user_purchase/pages/detailed_purchase_page.dart';
import 'package:salgadar_app/app/shared/utils/alert_dialog_utils.dart';
import 'package:salgadar_app/app/shared/utils/connectivity_utils.dart';
import 'package:salgadar_app/app/shared/utils/math_utils.dart';

class PurchaseWidget extends StatefulWidget {
  const PurchaseWidget({Key key, this.purchase}) : super(key: key);

  final Purchase purchase;

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
                    purchase: widget.purchase, key: UniqueKey())),
            title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text('Salgadada (#cod${widget.purchase.id})')),
            subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text('Data: ${widget.purchase.date}')),
            trailing: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                  'R\$: ${MathUtils.round(number: widget.purchase.totalValue, decimalPlaces: 2)}'),
            )),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Excluir',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            await _confirmateDelete(context: context);
          },
        ),
      ],
    );
  }

  _confirmateDelete({BuildContext context}) async {
    try {
      // Verificacao de internet
      final hasInternet = await ConnectivityUtils.hasInternetConnectivity();
      if (!hasInternet) {
        ConnectivityUtils.noConnectionMessage(context: context);
        return;
      }

      showAConfirmationDialog(
        context: context,
        title: 'Atenção!',
        message: 'Deseja remover Salgadada (#cod${widget.purchase.id})?',
        yesFunction: yesFunction,
        noFunction: noFunction,
      );
    } catch (e) {
      ConnectivityUtils.loadErrorMessage(
          context: context); // mensagem alert dialog
    }
  }

  /// Funcao de confirmacao.
  yesFunction() async {
    await purchaseController.removePurchase(widget.purchase);
    Modular.to.pop();
  }

  /// Funcao de cancelamento.
  noFunction() {
    Modular.to.pop();
  }
}
