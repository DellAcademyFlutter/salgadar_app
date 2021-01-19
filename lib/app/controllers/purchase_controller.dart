import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/data/api/purchase_api_dao.dart';
import 'package:salgadar_app/app/data/local/purchase_SQLite_dao.dart';
import 'package:salgadar_app/app/models/purchase.dart';
import 'package:salgadar_app/app/models/user.dart';
import 'package:salgadar_app/app/shared/utils/math_utils.dart';

import 'cart_controller.dart';
import '../shared/utils/connectivity_utils.dart';
import 'user_controller.dart';

class PurchaseController extends ChangeNotifier {
  final cartController = Modular.get<CartController>();
  final userController = Modular.get<UserController>();
  final purchaseAPIDao = Modular.get<PurchaseAPIDao>();
  final purchaseSQLiteDao = Modular.get<PurchaseSQLiteDao>();

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
      totalQtt: cartController.totalItems,
      isDeleted: false,
    );

    await purchaseAPIDao
        .postPurchase(purchase)
        .then((value) => purchase.id = value);
    await purchaseSQLiteDao.insertPurchase(purchase);
    cartController.reinitializeCart();
    await cartController.cacheUserCurrCart();

    notifyListeners();
  }

  /// Adiciona uma [Purchase].
  removePurchase(Purchase purchase) async {
    purchase.isDeleted = true;

    await purchaseAPIDao.putPurchase(purchase);
    await purchaseSQLiteDao.updatePurchase(purchase);

    notifyListeners();
  }

  /// Retorna uma lista de [Purchase]s de [User].
  Future<List<Purchase>> getUserPurchases({int userId, BuildContext context}) async {
    try {
      final hasInternet = await ConnectivityUtils.hasInternetConnectivity();

      return hasInternet
          ? await purchaseAPIDao.getUserPurchases(
              userId: userId, getDeleted: false)
          : await purchaseSQLiteDao.getPurchasesByUser(userId: userId);
    } catch (e) {
      ConnectivityUtils.loadErrorMessage(context: context);
      return null;
    }
  }

  /// Retorna a data de hoje no formato dd-mm-yyyy
  getCurrentDate() {
    final now = new DateTime.now();
    return "${now.day}/${now.month}/${now.year}";
  }
}
