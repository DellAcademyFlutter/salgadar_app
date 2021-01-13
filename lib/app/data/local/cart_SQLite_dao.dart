import 'package:flutter/material.dart';
import 'package:salgadar_app/app/models/cart.dart';
import 'package:salgadar_app/app/repositories/local/database/dbHelper.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class CartSQLiteDao {
  /// Insere em registro [Cart] em sua tabela.
  Future<void> insertCart(Cart cart) async {
    try {
      final db = await DBHelper.getDatabase();

      await db.insert(
        TABLE_CART_NAME,
        cart.toJson(),
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
}
