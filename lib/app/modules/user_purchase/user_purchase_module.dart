import 'package:flutter_modular/flutter_modular.dart';

import 'pages/detailed_purchase_page.dart';
import 'user_purchase_controller.dart';
import 'user_purchase_page.dart';

class UserPurchaseModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => UserPurchaseController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => UserPurchasePage(),
          transition: TransitionType.leftToRightWithFade,
        ),
        ModularRouter(
          DetailedPurchasePage.routeName,
          child: (_, args) => DetailedPurchasePage(
            purchase: args.data.purchase,
            key: args.data.key,
          ),
          transition: TransitionType.leftToRightWithFade,
        ),
      ];

  static Inject get to => Inject<UserPurchaseModule>.of();
  static const routeName = '/purchase';
}
