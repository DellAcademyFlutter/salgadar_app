import 'package:flutter/material.dart';
import 'package:salgadar_app/app/models/item_cart.dart';
import 'package:salgadar_app/app/repositories/local/database/dbHelper.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class ItemCartSQLiteDao {
  /// Insere em registro [ItemCart] em sua tabela.
  Future<void> insertItemCart(ItemCart itemCart) async {
    try {
      final db = await DBHelper.getDatabase();

      await db.insert(
        TABLE_ITEM_CART_NAME,
        itemCart.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: $ex");
    }
  }

  /// Atualiza um registro [ItemCart].
  Future<void> updateItemCart(ItemCart itemCart) async {
    final db = await DBHelper.getDatabase();

    await db.update(
      TABLE_ITEM_CART_NAME,
      itemCart.toJson(),
      where: "$ITEM_CART_ITEMID = ? AND $ITEM_CART_CARTID = ?",
      whereArgs: [itemCart.itemId, itemCart.cartId],
    );
  }

  /// Deleta um registro [ItemCart].
  Future<void> deleteItemCart({int itemId, int cartId}) async {
    final db = await DBHelper.getDatabase();

    await db.delete(
      TABLE_ITEM_CART_NAME,
      where: "$ITEM_CART_ITEMID = ? AND $ITEM_CART_CARTID = ?",
      whereArgs: [itemId, cartId],
    );
  }

  /// Retorna a lista de todos os [ItemCart]s.
  Future<List<ItemCart>> getItemCarts() async {
    try {
      final db = await DBHelper.getDatabase();
      final maps = await db.query(TABLE_ITEM_CART_NAME);

      final itemCarts = <ItemCart>[];

      for (var i = 0; i < maps.length; i++) {
        itemCarts.add(ItemCart.fromJson(json: maps[i]));
      }
      return itemCarts;
    } catch (ex) {
      //print(ex);
      return <ItemCart>[];
    }
  }

  /// Retorna a lista de todos os [ItemCart]s filtrados por [Cart].
  Future<List<ItemCart>> getItemCartsByCart(int cartId) async {
    try {
      final db = await DBHelper.getDatabase();
      final maps = await db.query(TABLE_ITEM_CART_NAME);

      final itemCarts = <ItemCart>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i][ITEM_CART_CARTID] == cartId) {
          itemCarts.add(ItemCart.fromJson(json: maps[i]));
        }
      }
      return itemCarts;
    } catch (ex) {
      //print(ex);
      return <ItemCart>[];
    }
  }
}
