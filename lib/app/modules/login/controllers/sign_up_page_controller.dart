import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'file:///C:/Users/Jack/AndroidStudioProjects/salgadar_app/lib/app/shared/utils/connectivity_utils.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/models/user.dart';
import 'package:salgadar_app/app/shared/utils/alert_dialog_utils.dart';
import 'package:salgadar_app/app/shared/utils/string_utils.dart';
import 'package:salgadar_app/app/shared/utils/validator.dart';

class SignUpPageController implements Disposable {
  final userController = Modular.get<UserController>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final nameController = TextEditingController();
  final birthdayController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isActionSuccess = ValueNotifier(false);

  AutovalidateMode signUpIsValidating;

  /// Atribuicoes iniciais da [SignUpPage
  initializeSignUpPage({@required User user}) {
    if (user == null) {
      usernameController.text = '';
      passwordController.text = '';
      password2Controller.text = '';
      nameController..text = '';
      birthdayController..text = '';
      emailController..text = '';
    } else {
      usernameController.text = user.username;
      passwordController.text = user.password;
      password2Controller.text = user.password;
      nameController..text = user.name;
      birthdayController..text = user.birthday;
      emailController.text = user.email;
    }
    signUpIsValidating = AutovalidateMode.disabled;
    isActionSuccess.value = false;
  }

  /// Salva um [User] cadastrado.
  saveUser(
      {String username,
      String password,
      String name,
      String birthday,
      String email,
      User user,
      BuildContext context}) async {
    final newUser = User(
      id: user?.id,
      username: StringUtils.trimLowerCase(username),
      password: password,
      name: name,
      birthday: birthday,
      email: email,
    );

    // Adicao ou edicao
    if (user == null) {
      await userController.addUser(newUser);
    } else {
      await userController.updateUser(newUser);
      await userController.cacheLastLoggedUser(
          username: newUser.username, context: context);
    }

    isActionSuccess.value = true;
  }

  /// Registra [User], retornando a flag de sucesso do processo.
  Future<bool> registerUser(
      {@required BuildContext context, @required User userEditing}) async {
    try {
      // Verificacao de internet
      final hasInternet = await ConnectivityUtils.hasInternetConnectivity();
      if (!hasInternet) {
        ConnectivityUtils.noConnectionMessage(context: context);
        return false;
      }

      signUpIsValidating = AutovalidateMode.always;
      bool contains = await userController.containsUser(
          username: usernameController.text, userEditing: userEditing);
      if (contains) {
        showAlertDialog(
            context: context,
            title: 'Atenção!',
            message: 'Usuario já cadastrado. Por favor, escolha outro username',
            buttonConfirmationLabel: 'Ok');
      } else {
        if (formKey.currentState.validate()) {
          await saveUser(
              username: usernameController.text,
              password: passwordController.text,
              name: nameController.text,
              email: emailController.text,
              birthday: birthdayController.text,
              user: userEditing,
              context: context);
          return true;
        }
      }

      return false;
    } catch (e) {
      ConnectivityUtils.loadErrorMessage(context: context);
    }
  }

  /// Validator username.
  validatorUsername({String username}) =>
      username.isEmpty ? 'Seu username não pode ser vazio!' : null;

  /// Validator password.
  validatorPassword({String password}) =>
      password.isEmpty ? 'Sua senha não pode ser vazia!' : null;

  /// Validator nome.
  validatorName({String name}) =>
      name.isEmpty ? 'Seu nome não pode ser vazio!' : null;

  /// Validator data de nascimento.
  validatorBirthday({String birthday}) {
    final dateValidator = Validator.validateDate(birthday);
    return (!dateValidator) ? 'Data inválida!' : null;
  }

  /// Validator email.
  validatorEmail({String email}) {
    final emailValidator = Validator.validateEmail(email);
    return !emailValidator ? 'Email inválido!' : null;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    nameController.dispose();
    birthdayController.dispose();
    emailController.dispose();
  }
}
