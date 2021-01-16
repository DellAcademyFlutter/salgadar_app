import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/modules/login/controllers/sign_up_page_controller.dart';
import 'package:salgadar_app/app/shared/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/signUp';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpPageController> {
  @override
  void initState() {
    super.initState();

    controller.initializeSignUpPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de usuário'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        autovalidateMode: controller.signUpIsValidating,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              child: TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Insira seu username (usado para logar)',
                ),
                validator: (String submittedValue) =>
                    controller.validatorUsername(username: submittedValue),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Insira sua senha',
                ),
                validator: (String submittedValue) =>
                    controller.validatorPassword(password: submittedValue),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Insira seu nome',
                ),
                validator: (String submittedValue) =>
                    controller.validatorName(name: submittedValue),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextFormField(
                controller: controller.birthdayController,
                inputFormatters: [Validator.dateMaskFormatter],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Insira sua data de nascimento',
                ),
                validator: (String submittedValue) =>
                    controller.validatorBirthday(birthday: submittedValue),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite seu email',
                ),
                validator: (String submittedValue) =>
                    controller.validatorEmail(email: submittedValue),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: RaisedButton(
                child: Text('Finalizar cadastro'),
                onPressed: () async {
                  await controller.registerUser(context: context).then((value) {
                    if (value) {
                      Modular.to.pop();
                      // TODO: ANIMATION
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
