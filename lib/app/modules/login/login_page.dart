import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/modules/login/login_controller.dart';
import 'package:salgadar_app/app/modules/login/pages/sign_up_page.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  void initState() {
    controller.initializeLoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo!'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: controller.formKey,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  Container(
                    child: ListTile(
                      title: TextFormField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Insira seu $USER_USERNAME',
                        ),
                        validator: (String submittedValue) {
                          if (submittedValue.isEmpty) {
                            return 'Este campo não pode estar vazio!';
                          }
                          return null;
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.person),
                        onPressed: null,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller.hidePassword,
                    builder: (context, value, child) {
                      return Container(
                          child: ListTile(
                              title: TextFormField(
                                obscureText: controller.hidePassword.value,
                                enableSuggestions: false,
                                autocorrect: false,
                                controller: controller.passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Insira seu $USER_PASSWORD',
                                ),
                                validator: (String submittedValue) {
                                  if (submittedValue.isEmpty) {
                                    return 'Este campo não pode estar vazio!';
                                  }
                                  return null;
                                },
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                color: controller.hidePassword.value
                                    ? Theme.of(context)
                                        .buttonColor
                                        .withBlue(255)
                                    : null,
                                onPressed: () =>
                                    controller.toggleHidePassword(),
                              )));
                    },
                  ),
                  Container(
                    child: ListTile(
                      title: RaisedButton(
                        textColor: Colors.black,
                        child: Text('Entrar'),
                        onPressed: () async {
                          if (controller.formKey.currentState.validate()) {
                            await controller.login(
                                username:
                                    controller.nameController.text,
                                password:
                                    controller.passwordController.text,
                                context: context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Container(
            child: Center(
              child: FlatButton(
                onPressed: () {
                  Modular.link.pushNamed(SignUpPage.routeName);
                },
                child: Text('Não é cadastrado? Cadastre-se aqui!'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
