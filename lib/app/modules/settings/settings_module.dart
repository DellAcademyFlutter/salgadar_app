import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/modules/login/controllers/sign_up_page_controller.dart';
import 'package:salgadar_app/app/modules/login/pages/sign_up_page.dart';

import 'settings_controller.dart';
import 'settings_page.dart';

class SettingsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SettingsController()),
        Bind((i) => SignUpPageController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => SettingsPage(),
        ),
        ModularRouter(
          SignUpPage.routeName,
          child: (_, args) => SignUpPage(user: args.data.user),
          transition: TransitionType.leftToRightWithFade,
        ),
      ];

  static Inject get to => Inject<SettingsModule>.of();
  static const routeName = '/settings';
}
