import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/data/api/purchase_api_dao.dart';
import 'package:salgadar_app/app/data/local/purchase_SQLite_dao.dart';
import 'package:salgadar_app/app/models/purchase.dart';
import 'package:salgadar_app/app/models/user.dart';
import 'package:salgadar_app/app/shared/utils/math_utils.dart';

import 'cart_controller.dart';
import 'user_controller.dart';

class PurchaseController extends ChangeNotifier {
  final cartController = Modular.get<CartController>();
  final userController = Modular.get<UserController>();
  final purchaseAPIDao = Modular.get<PurchaseAPIDao>();
  final purchaseSQLiteDao = Modular.get<PurchaseSQLiteDao>();
  List<Purchase> userPurchases = [];

  /// Atribuicao inicial das [Purchases] de [User] logado.
  initializeUserPurchases() async {
    userPurchases = userController.loggedUser != null
        ? await purchaseAPIDao.getUserPurchases(
            userId: userController.loggedUser.id)
        : [];
  }

  /// Adiciona uma [Purchase].
  addPurchase() async {
    // Insere o carrinho.
    await cartController.saveCart();

    final purchase = Purchase(
      userId: userController.loggedUser.id,
      cartId: cartController.userCart.id,
      date: getCurrentDate(),
      totalValue:
          MathUtils.round(number: cartController.totalValue, decimalPlaces: 2),
      isDeleted: false,
    );

    await purchaseAPIDao.postPurchase(purchase);
    await purchaseSQLiteDao.insertPurchase(purchase);
    userPurchases.add(purchase);
    cartController.reinitializeCart();
    await cartController.cacheUserCurrCart();

    notifyListeners();
  }

  /// Adiciona uma [Purchase].
  removePurchase(Purchase purchase) async {
    purchase.isDeleted = true;

    await purchaseAPIDao.putPurchase(purchase);
    await purchaseSQLiteDao.updatePurchase(purchase);
    userPurchases.remove(purchase);

    notifyListeners();
  }

  /// Retorna a data de hoje no formato dd-mm-yyyy
  getCurrentDate() {
    final now = new DateTime.now();
    return "${now.day}/${now.month}/${now.year}";
  }
}
