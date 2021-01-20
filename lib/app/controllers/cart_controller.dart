import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/data/api/cart_api_dao.dart';
import 'package:salgadar_app/app/data/local/cart_SQLite_dao.dart';
import 'package:salgadar_app/app/data/local/item_cart_SQLite_dao.dart';
import 'package:salgadar_app/app/models/cart.dart';
import 'package:salgadar_app/app/models/item.dart';
import 'package:salgadar_app/app/models/item_cart.dart';
import 'package:salgadar_app/app/models/user.dart';
import 'package:salgadar_app/app/repositories/local/database/shared_prefs.dart';
import 'package:salgadar_app/app/shared/utils/connectivity_utils.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';

class CartController extends ChangeNotifier {
  final userController = Modular.get<UserController>();
  final cartAPIDao = Modular.get<CartAPIDao>();
  final cartSQLiteDao = Modular.get<CartSQLiteDao>();
  final itemCartSQLiteDao = Modular.get<ItemCartSQLiteDao>();

  Cart userCart;
  int totalItems;
  double totalValue;

  /// Inicializa os [ItemCart] de [Cart].
  initializeCart() async {
    await loadUserCurrCart();
  }

  /// Adiciona uma unidade a um [ItemCart].
  addItem(Item item) async {
    if (containsItem(itemId: item.id)) {
      incrementItem(itemId: item.id);
    } else {
      userCart.items.add(ItemCart(
          itemId: item.id, cartId: null, qtt: 1, itemPrice: item.price));
    }

    // Cache em Local Storage
    await cacheUserCurrCart();

    totalValue += item.price;
    totalItems++;
    notifyListeners();
  }

  /// Remove uma unidade de um [ItemCart].
  removeItem(Item item) async {
    await decrementItem(itemId: item.id);

    // Cache em Local Storage
    await cacheUserCurrCart();

    totalValue -= item.price;
    totalItems--;
    notifyListeners();
  }

  /// Incrementa uma unidade de [ItemCart].
  incrementItem({int itemId}) {
    for (var i = 0; i < userCart.items.length; i++) {
      if (userCart.items[i].itemId == itemId) {
        userCart.items[i].qtt++;
      }
    }
  }

  /// Decrementa uma unidade de [ItemCart].
  decrementItem({int itemId}) async {
    for (var i = 0; i < userCart.items.length; i++) {
      if (userCart.items[i].itemId == itemId) {
        userCart.items[i].qtt--;

        // Remove caso tenha 0
        if (userCart.items[i].qtt == 0) {
          userCart.items.removeAt(i);
        }
      }
    }
  }

  /// Verifica se contem um dado [Item].
  bool containsItem({@required int itemId}) {
    for (var i = 0; i < userCart.items.length; i++) {
      if (userCart.items[i].itemId == itemId) {
        return true;
      }
    }
    return false;
  }

  /// Retorna um [Cart].
  Future<Cart> getCart({int cartId}) async {
    return cartAPIDao.getCart(id: cartId);
  }

  /// Retorna um [Cart].
  Future<List<ItemCart>> getItemsCart({int cartId}) async {
    final hasInternet = await ConnectivityUtils.hasInternetConnectivity();

    Cart cart;
    if (hasInternet) {
      cart = await cartAPIDao.getCart(id: cartId);
    } else {
      cart = await cartSQLiteDao.getCart(cartId: cartId);
      cart.items = await itemCartSQLiteDao.getItemCartsByCart(cartId);
    }

    return cart.items;
  }

  /// Salva um [Cart].
  saveCart() async {
    // TODO: IF HAS CONNECTION
    // Insere no server, resgatando id.
    await cartAPIDao.postCart(userCart).then((value) async {
      userCart.id = value;
    });
    for (var i = 0; i < userCart.items.length; i++) {
      userCart.items[i].cartId = userCart.id;
    }
    await cartAPIDao.putCart(userCart);

    // Insere no banco, resgatando relacional.
    final cartMap = userCart.toJson();
    cartMap.remove(CART_ITEMS);
    await cartSQLiteDao.insertCart(cartMap: cartMap);
    for (var i = 0; i < userCart.items.length; i++) {
      await itemCartSQLiteDao.insertItemCart(userCart.items[i]);
    }
  }

  /// Armazena o [Cart] atual de [User] logado em Local Storage.
  cacheUserCurrCart() async {
    await SharedPrefs.save(getUserCurrCartKey(), jsonEncode(userCart.toJson()));
  }

  /// Carrega o [Cart] atual de [User] logado.
  loadUserCurrCart() async {
    final cartKey = getUserCurrCartKey();
    await SharedPrefs.contains(cartKey).then((value) async {
      if (value) {
        await SharedPrefs.read(cartKey).then((value) {
          userCart = Cart.fromJson(json: jsonDecode(value));
          totalItems = getCartTotalItems();
          totalValue = getCartTotalValue();
        });
      } else {
        reinitializeCart();
      }
    });
  }

  /// Key para [Cart] atual de [User].
  getUserCurrCartKey() => '$CURR_CART/${userController?.loggedUser?.id ?? -1}';

  /// Calcula e retorna a quantidade de [Item]s de [Cart].
  getCartTotalItems() {
    var sum = 0;

    for (var i = 0; i < userCart.items.length; i++) {
      sum += userCart.items[i].qtt;
    }

    return sum;
  }

  /// Calcula e retorna o valor total de [Item]s de [Cart].
  getCartTotalValue() {
    var sum = 0.0;

    for (var i = 0; i < userCart.items.length; i++) {
      sum += userCart.items[i].itemPrice;
    }

    return sum;
  }

  /// Esvazia o [Cart].
  reinitializeCart() {
    userCart = Cart(
      id: null,
      items: <ItemCart>[],
    );
    totalItems = 0;
    totalValue = 0;

    notifyListeners();
  }
}
