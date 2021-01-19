import 'package:flutter/material.dart';
import 'package:salgadar_app/app/models/item.dart';
import 'package:salgadar_app/app/repositories/local/database/dbHelper.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class ItemSQLiteDao {
  /// Insere em registro [Item] em sua tabela.
  Future<void> insertItem(Item item) async {
    try {
      final db = await DBHelper.getDatabase();

      await db.insert(
        TABLE_ITEM_NAME,
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: $ex");
    }
  }

  /// Atualiza um registro [Item].
  Future<void> updateItem(Item item) async {
    final db = await DBHelper.getDatabase();

    await db.update(
      TABLE_ITEM_NAME,
      item.toJson(),
      where: "$ITEM_ID = ?",
      whereArgs: [item.id],
    );
  }

  /// Deleta um registro [Item].
  Future<void> deleteItem(int id) async {
    final db = await DBHelper.getDatabase();

    await db.delete(
      TABLE_ITEM_NAME,
      where: "$ITEM_ID = ?",
      whereArgs: [id],
    );
  }

  /// Retorna a lista de todos os [Item]s.
  Future<List<Item>> getItems() async {
    try {
      final db = await DBHelper.getDatabase();
      final maps = await db.query(TABLE_ITEM_NAME);

      final items = <Item>[];

      for (var i = 0; i < maps.length; i++) {
        items.add(Item.fromJson(json: maps[i]));
      }
      return items;
    } catch (ex) {
      //print(ex);
      return <Item>[];
    }
  }

  /// Retorna um [Item].
  Future<Item> getItem({int id}) async {
    try {
      final db = await DBHelper.getDatabase();
      final maps = await db.query(TABLE_ITEM_NAME);

      for (var i = 0; i < maps.length; i++) {
        if (maps[i][ITEM_ID] == id) {
          return Item.fromJson(json: maps[i]);
        }
      }
      return null;
    } catch (ex) {
      //print(ex);
      return null;
    }
  }

  /// Retorna a lista de todos os [Item]s por subcategoria.
  Future<List<Item>> getItemsBySubcategory({String subcategory}) async {
    try {
      final db = await DBHelper.getDatabase();
      final maps = await db.query(TABLE_ITEM_NAME);

      final items = <Item>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i][ITEM_SUBCATEGORY] == subcategory) {
          items.add(Item.fromJson(json: maps[i]));
        }
      }
      return items;
    } catch (ex) {
      //print(ex);
      return <Item>[];
    }
  }
}
