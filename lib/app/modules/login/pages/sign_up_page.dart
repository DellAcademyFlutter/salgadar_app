import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/models/user.dart';
import 'package:salgadar_app/app/modules/login/controllers/sign_up_page_controller.dart';
import 'package:salgadar_app/app/shared/utils/focus_utils.dart';
import 'package:salgadar_app/app/shared/utils/validator.dart';

class SignUpPageArguments {
  const SignUpPageArguments({this.user});

  final User user;
}

class SignUpPage extends StatefulWidget {
  static const routeName = '/signUp';

  const SignUpPage({this.user});

  final User user;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = Modular.get<SignUpPageController>();

  @override
  void initState() {
    super.initState();

    controller.initializeSignUpPage(user: widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.isActionSuccess,
      builder: (context, value, child) {
        return Scaffold(
          appBar: widget.user == null
              ? AppBar(
            title: Text('Cadastro de usuário'),
            centerTitle: true,
          )
              : null,
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                bottom: MediaQuery.of(context).size.height / 2,
                child: AnimatedOpacity(
                  curve: Curves.linear,
                  opacity: controller.isActionSuccess.value ? 1 : 0,
                  duration: Duration(milliseconds: 1000),
                  child: animatedFeedbackWidget(),
                ),
              ),
              AnimatedOpacity(
                curve: Curves.bounceIn,
                opacity: controller.isActionSuccess.value ? 0 : 1,
                duration: Duration(milliseconds: 0),
                child: formWidget(),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Widget principal - Formulario.
  formWidget() {
    return Form(
        key: controller.formKey,
        autovalidateMode: controller.signUpIsValidating,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
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
                  await controller
                      .registerUser(context: context, userEditing: widget.user)
                      .then((value) {
                    if (value) {
                      // Remove o foco do textEdit, para realizar dismiss no keyboard.
                      FocusUtils.removeFocus(context: context);

                      // Fecha a pagina depois de alguns milisegundos.
                      Future.delayed(Duration(milliseconds: 1500), () {
                        Modular.to.pop();
                      });
                    }
                  });
                },
              ),
            ),
          ],
        ),
      );
  }

  /// Widget de feedback animado.
  animatedFeedbackWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.done_outline,
            color: Colors.green,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(widget.user == null
                ? ' Cadastro realizado com sucesso!'
                : ' Modificações realizadas com sucesso!'),
          )
        ],
      ),
    );
  }
}
