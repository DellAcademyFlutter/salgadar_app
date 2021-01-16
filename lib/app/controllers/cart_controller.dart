import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/models/cart.dart';
import 'package:salgadar_app/app/models/item.dart';
import 'package:salgadar_app/app/models/item_cart.dart';
import 'package:salgadar_app/app/models/user.dart';
import 'package:salgadar_app/app/repositories/local/database/shared_prefs.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';

class CartController extends ChangeNotifier {
  final userController = Modular.get<UserController>();
  Cart cart;
  int totalItems;
  double totalValue;

  /// Inicializa os [ItemCart] de [Cart].
  initializeCart() {
    cart = Cart();
    cart.items = [];
    totalItems = 0;
    totalValue = 0;
  }

  /// Adiciona uma unidade a um [ItemCart].
  addItem(Item item) async {
    if (containsItem(itemId: item.id)) {
      incrementItem(itemId: item.id);
    } else {
      cart.items.add(ItemCart(
          itemId: item.id, cartId: null, qtt: 1, itemPrice: item.price));
    }

    // Cache em Local Storage
    await SharedPrefs.save(getUserCurrCartKey(user: userController.loggedUser),
        jsonEncode(cart.toJson()));

    totalValue += item.price;
    totalItems++;
    notifyListeners();
  }

  /// Remove uma unidade de um [ItemCart].
  removeItem(Item item) async {
    await decrementItem(itemId: item.id);

    // Cache em Local Storage
    await SharedPrefs.save(getUserCurrCartKey(user: userController.loggedUser),
        jsonEncode(cart.toJson()));

    totalValue -= item.price;
    totalItems--;
    notifyListeners();
  }

  /// Incrementa uma unidade de [ItemCart].
  incrementItem({int itemId}) {
    for (var i = 0; i < cart.items.length; i++) {
      if (cart.items[i].itemId == itemId) {
        cart.items[i].qtt++;
      }
    }
  }

  /// Decrementa uma unidade de [ItemCart].
  decrementItem({int itemId}) async {
    for (var i = 0; i < cart.items.length; i++) {
      if (cart.items[i].itemId == itemId) {
        cart.items[i].qtt--;

        // Remove caso tenha 0
        if (cart.items[i].qtt == 0) {
          cart.items.removeAt(i);
        }
      }
    }
  }

  /// Verifica se contem um dado [Item].
  bool containsItem({@required int itemId}) {
    for (var i = 0; i < cart.items.length; i++) {
      if (cart.items[i].itemId == itemId) {
        return true;
      }
    }
    return false;
  }

  /// Key para [Cart] atual de [User].
  getUserCurrCartKey({User user}) => '$CURR_CART/${user.id}';
}
