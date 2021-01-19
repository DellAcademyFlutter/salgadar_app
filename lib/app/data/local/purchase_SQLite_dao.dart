import 'package:flutter/material.dart';
import 'package:salgadar_app/app/models/purchase.dart';
import 'package:salgadar_app/app/repositories/local/database/dbHelper.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class PurchaseSQLiteDao {
  /// Insere em registro [Purchase] em sua tabela.
  Future<void> insertPurchase(Purchase purchase) async {
    try {
      final db = await DBHelper.getDatabase();

      await db.insert(
        TABLE_PURCHASE_NAME,
        purchase.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: $ex");
    }
  }

  /// Atualiza um registro [Purchase].
  Future<void> updatePurchase(Purchase purchase) async {
    final db = await DBHelper.getDatabase();

    await db.update(
      TABLE_PURCHASE_NAME,
      purchase.toJson(),
      where: "$PURCHASE_USERID = ? AND $PURCHASE_CARTID = ?",
      whereArgs: [purchase.userId, purchase.cartId],
    );
  }

  /// Deleta um registro [Purchase].
  Future<void> deletePurchase({int userId, int cartId}) async {
    final db = await DBHelper.getDatabase();

    await db.delete(
      TABLE_PURCHASE_NAME,
      where: "$PURCHASE_USERID = ? AND $PURCHASE_CARTID = ?",
      whereArgs: [userId, cartId],
    );
  }

  /// Retorna a lista de todos os [Purchase]s.
  Future<List<Purchase>> getPurchases() async {
    try {
      final db = await DBHelper.getDatabase();
      final maps = await db.query(TABLE_PURCHASE_NAME);

      final purchases = <Purchase>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i][PURCHASE_ISDELETED] == 0) {
          purchases.add(Purchase.fromJson(json: maps[i]));
        }
      }
      return purchases;
    } catch (ex) {
      //print(ex);
      return <Purchase>[];
    }
  }

  /// Retorna a lista de todos os [Purchase]s filtrados por [User].
  Future<List<Purchase>> getPurchasesByUser({int userId}) async {
    try {
      final db = await DBHelper.getDatabase();
      final maps = await db.query(TABLE_PURCHASE_NAME);

      final purchases = <Purchase>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i][PURCHASE_USERID] == userId) {
          if (maps[i][PURCHASE_ISDELETED] == 0) {
            purchases.add(Purchase.fromJson(json: maps[i]));
          }
        }
      }
      return purchases;
    } catch (ex) {
      //print(ex);
      return <Purchase>[];
    }
  }
}
