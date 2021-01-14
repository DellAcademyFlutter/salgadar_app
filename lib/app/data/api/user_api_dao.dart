import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salgadar_app/app/models/user.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';

class UserAPIDao {
  /// Post - adiciona um [User] e retorna [id] gerado.
  Future<int> postUser({User user}) async {
    final headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode(user.toJson());
    final response = await http.post(URL_USER, body: body, headers: headers);
    final jsonResponse = jsonDecode(response.body);

    return jsonResponse[USER_ID];
  }

  /// Put - atualiza um [Card].
  Future<User> putUser({User user}) async {
    final response = await http.put(
      '$URL_USER/${user.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    // Caso sucesso
    if (response.statusCode == 200) {
      return User.fromJson(json: jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }

  /// Get - busca todos [User].
  Future<List<User>> getUsers() async {
    final response = await http.get(URL_USER);

    // Caso sucesso.
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final users = (jsonResponse as List)
          .map((data) => User.fromJson(json: data))
          .toList();

      return users;
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }

  /// Delete - remove um [User].
  Future<http.Response> deleteUser({int id}) async {
    final response = await http.delete(
      '$URL_USER/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  /// Busca um [User].
  Future<User> getUser({id}) async {
    final response = await http.get("$URL_USER/$id");

    // Caso sucesso
    if (response.statusCode == 200) {
      return User.fromJson(json: jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }
}
