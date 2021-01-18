import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
import 'package:salgadar_app/app/controllers/purchase_controller.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/controllers/user_settings_controller.dart';
import 'package:salgadar_app/app/modules/home/home_module.dart';
import 'package:salgadar_app/app/shared/utils/alert_dialog_utils.dart';
import 'package:salgadar_app/app/shared/utils/string_utils.dart';

class LoginController implements Disposable {
  final userController = Modular.get<UserController>();
  final cartController = Modular.get<CartController>();
  final purchaseController = Modular.get<PurchaseController>();
  final userSettingsController = Modular.get<UserSettingsController>();

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final hidePassword = ValueNotifier<bool>(true);
  final formKey = GlobalKey<FormState>();

  /// Atribuicoes iniciais da [LoginPage].
  initializeLoginPage() {
    nameController.text = '';
    passwordController.text = '';
    hidePassword.value = true;
  }

  /// Inicializa o carrinho do [User] logado.
  initializeHomePage() async{
    await cartController.initializeCart();
  }

  /// Alterna entre true e false o valor de [hidePassword]
  toggleHidePassword() => hidePassword.value = !hidePassword.value;

  /// Verifica o login do [User]
  login({String username, String password, BuildContext context}) async {
    username = StringUtils.trimLowerCase(username);

    await userController
        .isUserCredentials(username: username, password: password)
        .then((value) async {
      if (value) {
        await userController.cacheLastLoggedUser(username: username);
        await cartController.initializeCart();
        await userSettingsController.initializeUserSettings();
        await purchaseController.initializeUserPurchases();

        Modular.to.pushReplacementNamed(HomeModule.routeName);
      } else {
        showAlertDialog(
            context: context,
            title: 'Atenção!',
            message: 'Usuario ou senha incorretos',
            buttonConfirmationLabel: 'Ok');
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
  }
}
