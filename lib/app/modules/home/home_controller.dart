import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/purchase_controller.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/controllers/user_settings_controller.dart';
import 'package:salgadar_app/app/modules/login/login_module.dart';
import 'package:salgadar_app/app/shared/utils/alert_dialog_utils.dart';
import 'package:salgadar_app/app/shared/utils/connectivity_utils.dart';

class HomeController implements Disposable {
  final userController = Modular.get<UserController>();
  final userSettingsController = Modular.get<UserSettingsController>();
  final purchaseController = Modular.get<PurchaseController>();
  final pageViewController = PageController();

  @override
  void dispose() {
    pageViewController.dispose();
  }

  /// Realiza logout de [User].
  Logout() {
    userController.loggedUser.username = null;
    userController.cacheLastLoggedUser(
        username: userController.loggedUser.username);
    userSettingsController.setDefaultSettings();
    Modular.to.pushReplacementNamed(LoginModule.routeName);
  }

  /// Funcao finalizar compra.
  finalizePurchase({@required BuildContext context}) async {
    try {
      // Verificacao de internet
      final hasInternet = await ConnectivityUtils.hasInternetConnectivity();
      if (!hasInternet) {
        ConnectivityUtils.noConnectionMessage(context: context);
        return;
      }

      showAConfirmationDialog(
          context: context,
          title: 'Confirmação',
          message: 'Deseja finalizar sua compra?',
          yesFunction: yesFunction,
          noFunction: noFunction);

    } catch (e) {
      ConnectivityUtils.loadErrorMessage(
          context: context); // mensagem alert dialog
    }
  }

  /// Funcao de confirmacao de compra.
  yesFunction() async {
    await purchaseController.addPurchase();
    Modular.to.pop();
    Modular.to.pop();
  }

  /// Funcao de cancelamento de compra.
  noFunction() {
    Modular.to.pop();
  }
}
