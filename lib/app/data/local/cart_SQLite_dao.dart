import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/data/local/item_cart_SQLite_dao.dart';
import 'package:salgadar_app/app/models/cart.dart';
import 'package:salgadar_app/app/repositories/local/database/dbHelper.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class CartSQLiteDao {
  /// Insere em registro [Cart] em sua tabela.
  Future<void> insertCart({Map<String, dynamic> cartMap}) async {
    try {
      final db = await DBHelper.getDatabase();

      await db.insert(
        TABLE_CART_NAME,
        cartMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: $ex");
    }
  }

  /// Atualiza um registro [Cart].
  Future<void> updateCart(Cart cart) async {
    final db = await DBHelper.getDatabase();

    await db.update(
      TABLE_CART_NAME,
      cart.toJson(),
      where: "$CART_ID?",
      whereArgs: [cart.id],
    );
  }

  /// Deleta um registro [Cart].
  Future<void> deleteCart(int id) async {
    final db = await DBHelper.getDatabase();

    await db.delete(
      TABLE_CART_NAME,
      where: "$CART_ID = ?",
      whereArgs: [id],
    );
  }

  /// Retorna a lista de todos os [Cart]s.
  Future<List<Cart>> getCarts() async {
    try {
      final db = await DBHelper.getDatabase();
      final maps = await db.query(TABLE_CART_NAME);

      final carts = <Cart>[];

      for (var i = 0; i < maps.length; i++) {
        carts.add(Cart.fromJson(json: maps[i]));
      }
      return carts;
    } catch (ex) {
      //print(ex);
      return <Cart>[];
    }
  }

  /// Retorna um [Cart].
  Future<Cart> getCart({int cartId}) async {
    final itemCartSQLiteDao = Modular.get<ItemCartSQLiteDao>();
    final db = await DBHelper.getDatabase();
    List<Map<String, dynamic>> maps = await db.query(
      TABLE_CART_NAME,
      where: "$CART_ID = ?",
      whereArgs: [cartId],
    );
    if (maps.length > 0) {
      return Cart.fromMap(map: maps.first);
    }
    return null;
  }
}
