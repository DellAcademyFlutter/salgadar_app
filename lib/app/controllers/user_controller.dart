import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/data/api/user_api_dao.dart';
import 'package:salgadar_app/app/data/local/user_SQLite_dao.dart';
import 'package:salgadar_app/app/models/user.dart';
import 'package:salgadar_app/app/repositories/local/database/shared_prefs.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';
import 'package:salgadar_app/app/shared/utils/string_utils.dart';

class UserController extends ChangeNotifier {
  final userAPIDao = Modular.get<UserAPIDao>();
  final userSQLiteDao = Modular.get<UserSQLiteDao>();
  User loggedUser;

  /// Adiciona um [User].
  addUser(User user) async {
    await userAPIDao.postUser(user).then((value) => user.id = value);
    await userSQLiteDao.insertUser(user);

    notifyListeners();
  }

  /// Atualiza um [User].
  updateUser(User user) async {
    await userAPIDao.putUser(user);
    await userSQLiteDao.updateUser(user);
    loggedUser.setValues(otherUser: user);

    notifyListeners();
  }

  /// Remove um [User] o marcando como removido.
  removeUser(User user) async {
    await userAPIDao.deleteUser(id: user.id);
    await userSQLiteDao.deleteUser(user.id);

    notifyListeners();
  }

  /// Verifica se contem um [User].
  Future<bool> containsUser({String username, User userEditing}) async {
    // Caso de atualizacao de usuario
    if (userEditing != null) {
      if (userEditing.username == username) {
        return false;
      }
    }

    final result = await (userAPIDao.contains(
        username: StringUtils.trimLowerCase(username)));
    return result;
  }

  /// Verifica as credenciais de um [User].
  Future<bool> isUserCredentials({String username, String password}) async {
    final user = await userAPIDao.getUser(username: username);
    if (user == null) {
      return false;
    }
    return user?.password == password;
  }

  /// Salva o ultimo [User] logado em Local Storage.
  cacheLastLoggedUser({String username}) async {
    loggedUser = await userAPIDao.getUser(username: username);

    SharedPrefs.save(LOGGED_USER_LOCAL_STORAGE_KEY,
        loggedUser != null ? jsonEncode(loggedUser.toJson()) : 'null');
  }

  /// Carrega o ultimo [User] logado em Local Storage.
  loadLastLoggedUser() async {
    await SharedPrefs.contains(LOGGED_USER_LOCAL_STORAGE_KEY)
        .then((value) async {
      if (value) {
        await SharedPrefs.read(LOGGED_USER_LOCAL_STORAGE_KEY).then((value) {
          loggedUser = value != 'null' && value != '0'
              ? User.fromJson(json: jsonDecode(value))
              : null;
        });
      } else {
        loggedUser = null;
      }
    });
  }
}
