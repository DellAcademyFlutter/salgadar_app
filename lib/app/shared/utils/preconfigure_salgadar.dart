import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/data/api/cart_api_dao.dart';
import 'package:salgadar_app/app/data/api/item_api_dao.dart';
import 'package:salgadar_app/app/data/api/purchase_api_dao.dart';
import 'package:salgadar_app/app/data/api/user_api_dao.dart';
import 'package:salgadar_app/app/data/local/cart_SQLite_dao.dart';
import 'package:salgadar_app/app/data/local/item_SQLite_dao.dart';
import 'package:salgadar_app/app/data/local/item_cart_SQLite_dao.dart';
import 'package:salgadar_app/app/data/local/purchase_SQLite_dao.dart';
import 'package:salgadar_app/app/data/local/user_SQLite_dao.dart';
import 'package:salgadar_app/app/models/item.dart';
import 'package:salgadar_app/app/repositories/local/database/dbHelper.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';
import 'package:salgadar_app/app/shared/utils/url_images.dart';
import 'package:http/http.dart' as http;

class PreconfigureSalgadar {
  /// Cache no Banco SQLite.
  static cacheItemsInSQLite() async {
    // Reinicia as tabelas, se existirem.
    await DBHelper.reinitializeTable(
        tableName: TABLE_ITEM_NAME,
        scriptCreateTable: DBHelper.SCRIPT_CREATE_TABLE_ITEM_SQL);

    // Items.
    final itemAPIDao = Modular.get<ItemAPIDao>();
    final itemSQLiteDao = Modular.get<ItemSQLiteDao>();

    final items = await itemAPIDao.getItems();
    for (var i = 0; i < items.length; i++) {
      items[i].image = await imageUrlTobase64(items[i].image);
      await itemSQLiteDao.insertItem(items[i]);
    }
  }

  /// Cache de tudo no Banco SQLite.
  static cacheAllInSQLite() async {
    // Reinicia as tabelas, se existirem.
    await DBHelper.reinitializeTables();

    // Items.
    final itemAPIDao = Modular.get<ItemAPIDao>();
    final itemSQLiteDao = Modular.get<ItemSQLiteDao>();

    final items = await itemAPIDao.getItems();
    for (var i = 0; i < items.length; i++) {
      items[i].image = await imageUrlTobase64(items[i].image);
      await itemSQLiteDao.insertItem(items[i]);
    }

    // Users.
    final userAPIDao = Modular.get<UserAPIDao>();
    final userSQLiteDao = Modular.get<UserSQLiteDao>();

    final users = await userAPIDao.getUsers();
    for (var i = 0; i < users.length; i++) {
      await userSQLiteDao.insertUser(users[i]);
    }

    // Carts e ItemCarts.
    final cartAPIDao = Modular.get<CartAPIDao>();
    final cartSQLiteDao = Modular.get<CartSQLiteDao>();
    final itemCartSQLiteDao = Modular.get<ItemCartSQLiteDao>();

    final carts = await cartAPIDao.getCarts();
    for (var i = 0; i < carts.length; i++) {
      // Insere Cart
      Map<String, dynamic> cartMap = carts[i].toJson();
      cartMap.remove(CART_ITEMS);
      await cartSQLiteDao.insertCart(cartMap: cartMap);

      // Insere todos ItemCart
      for (var j = 0; j < carts[i].items.length; j++) {
        await itemCartSQLiteDao.insertItemCart(carts[i].items[j]);
      }
    }

    // Purchases
    final purchaseAPIDao = Modular.get<PurchaseAPIDao>();
    final purchaseSQLiteDao = Modular.get<PurchaseSQLiteDao>();

    final purchases = await purchaseAPIDao.getPurchases();
    for (var i = 0; i < purchases.length; i++) {
      await purchaseSQLiteDao.insertPurchase(purchases[i]);
    }
  }
}

imageUrlTobase64(String url) async {
  http.Response response = await http.get(url);
  return base64Encode(response.bodyBytes);
}
