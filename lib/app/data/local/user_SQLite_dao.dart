import 'package:flutter/material.dart';
import 'package:salgadar_app/app/models/user.dart';
import 'package:salgadar_app/app/repositories/local/database/dbHelper.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class UserSQLiteDao {
  /// Insere em registro [User] em sua tabela.
  Future<void> insertUser(User user) async {
    try {
      final db = await DBHelper.getDatabase();

      await db.insert(
        TABLE_USER_NAME,
        user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: $ex");
    }
  }

  /// Atualiza um registro [User].
  Future<void> updateUser(User user) async {
    final db = await DBHelper.getDatabase();

    await db.update(
      TABLE_USER_NAME,
      user.toJson(),
      where: "$USER_ID = ?",
      whereArgs: [user.id],
    );
  }

  /// Deleta um registro [User].
  Future<void> deleteUser(int id) async {
    final db = await DBHelper.getDatabase();

    await db.delete(
      TABLE_USER_NAME,
      where: "$USER_ID = ?",
      whereArgs: [id],
    );
  }

  /// Retorna a lista de todos os [User]s.
  Future<List<User>> getUsers() async {
    try {
      final db = await DBHelper.getDatabase();
      final maps = await db.query(TABLE_USER_NAME);

      final users = <User>[];

      for (var i = 0; i < maps.length; i++) {
        users.add(User.fromJson(json: maps[i]));
      }
      return users;
    } catch (ex) {
      //print(ex);
      return <User>[];
    }
  }

  /// Retorna um [User].
  Future<User> getUser({String username}) async {
    final db = await DBHelper.getDatabase();
    final maps = await db.query(
      TABLE_USER_NAME,
      where: "$USER_USERNAME = ?",
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return User.fromJson(json: maps.first);
    }
    return null;
  }
}
