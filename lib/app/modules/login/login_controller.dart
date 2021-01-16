import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/modules/home/home_module.dart';
import 'package:salgadar_app/app/shared/utils/alert_dialog_utils.dart';
import 'package:salgadar_app/app/shared/utils/string_utils.dart';

class LoginController implements Disposable {
  final userController = Modular.get<UserController>();
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

  /// Alterna entre true e false o valor de [hidePassword]
  toggleHidePassword() => hidePassword.value = !hidePassword.value;

  /// Verifica o login do [User]
  login({String username, String password, BuildContext context}) async {
    username = StringUtils.trimLowerCase(username);

    await userController
        .isUserCredentials(username: username, password: password)
        .then((value) async {
      if (value) {
        await userController.rememberLastLoggedUser(username: username);
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
