import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
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

  AutovalidateMode signUpIsValidating;

  /// Atribuicoes iniciais da [SignUpPage
  initializeSignUpPage() {
    usernameController.text = '';
    passwordController.text = '';
    password2Controller.text = '';
    nameController..text = '';
    birthdayController..text = '';
    emailController..text = '';
    signUpIsValidating = AutovalidateMode.disabled;
  }

  /// Muda o modo de [signUpIsValidating].
  changeAutoValidateMode(AutovalidateMode mode) => signUpIsValidating = mode;

  /// Salva um [User] cadastrado.
  saveUser(
      {String username,
      String password,
      String name,
      String birthday,
      String email}) async {
    final user = User(
      username: StringUtils.trimLowerCase(username),
      password: password,
      name: name,
      birthday: birthday,
      email: email,
    );
    await userController.addUser(user);
  }

  /// Verifica se [User] ja esta cadastrado.
  Future<bool> containsUser({String username}) async {
    bool result = await userController.containsUser(username: username);
    return result;
  }

  /// Registra [User], retornando a flag de sucesso do processo.
  Future<bool> registerUser({@required BuildContext context}) async {
    changeAutoValidateMode(AutovalidateMode.always);
    bool contains =
        await userController.containsUser(username: usernameController.text);
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
        );
        return true;
      }
    }

    return false;
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

  /// Verifica [User] ja cadastrado.
  Future<bool> checksAlreadyRegisteredUser({String username}) async {
    return await userController.containsUser(
        username: StringUtils.trimLowerCase(username));
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
