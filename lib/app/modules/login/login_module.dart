import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/modules/login/pages/sign_up_page.dart';

import 'controllers/sign_up_page_controller.dart';
import 'login_controller.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController()),
        Bind((i) => SignUpPageController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => LoginPage(),
        ),
        ModularRouter(
          SignUpPage.routeName,
          child: (_, args) => SignUpPage(user: args.data.user),
          transition: TransitionType.leftToRightWithFade,
        ),
      ];

  static Inject get to => Inject<LoginModule>.of();
  static const routeName = '/login';
}
