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
  List<Purchase> userPurchases = [];

  /// Atribuicao inicial das [Purchases] de [User] logado.
  initializeUserPurchases({BuildContext context}) async {
    try {
      final hasInternet = await ConnectivityUtils.hasInternetConnectivity();


      print('ola');
      userPurchases = userController.loggedUser != null
          ? hasInternet
              ? await purchaseAPIDao.getUserPurchases(
                  userId: userController.loggedUser.id, getDeleted: false)
              : await purchaseSQLiteDao.getPurchasesByUser(
                  userId: userController.loggedUser.id)
          : [];
      print(userController.loggedUser != null);
      print(hasInternet);
      print(userPurchases);
    } catch (e) {
      ConnectivityUtils.loadErrorMessage(context: context);
    }
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
      totalQtt: cartController.totalItems,
      isDeleted: false,
    );

    await purchaseAPIDao
        .postPurchase(purchase)
        .then((value) => purchase.id = value);
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
