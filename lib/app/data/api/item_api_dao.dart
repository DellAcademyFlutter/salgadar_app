import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salgadar_app/app/models/item.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';

class ItemAPIDao {
  /// Post - adiciona um [Item] e retorna [id] gerado.
  Future<int> postItem(Item item) async {
    final headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode(item.toJson());
    final response = await http.post(URL_ITEM, body: body, headers: headers);
    final jsonResponse = jsonDecode(response.body);

    return jsonResponse[ITEM_ID];
  }

  /// Put - atualiza um [Card].
  Future<Item> putItem(Item item) async {
    final response = await http.put(
      '$URL_ITEM/${item.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    );

    // Caso sucesso
    if (response.statusCode == 200) {
      return Item.fromJson(json: jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }

  /// Get - busca todos [Item].
  Future<List<Item>> getItems() async {
    final response = await http.get(URL_ITEM);

    // Caso sucesso.
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final items = (jsonResponse as List)
          .map((data) => Item.fromJson(json: data))
          .toList();

      return items;
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }

  /// Delete - remove um [Item].
  Future<http.Response> deleteItem({int id}) async {
    final response = await http.delete(
      '$URL_ITEM/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  /// Busca um [Item].
  Future<Item> getItem({id}) async {
    final response = await http.get("$URL_ITEM?$ITEM_ID=$id");

    // Caso sucesso
    if (response.statusCode == 200) {
      return jsonDecode(response.body).toString() == '[]'
          ? null
          : Item.fromJson(json: jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }

  /// Verifica se contem [Item].
  Future<bool> contains({int id}) async {
    final response = await http.get("$URL_USER?$ITEM_ID=$id");

    // Caso sucesso
    if (response.statusCode == 200) {
      return jsonDecode(response.body).toString() != '[]';
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }

  /// Get - busca todos [Item] por categoria.
  Future<List<Item>> getItemsByCategory({String category}) async {
    final response = await http.get("$URL_ITEM?$ITEM_CATEGORY=$category");

    // Caso sucesso.
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final items = (jsonResponse as List)
          .map((data) => Item.fromJson(json: data))
          .toList();

      return items;
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }

  /// Get - busca todos [Item] por subcategoria.
  Future<List<Item>> getItemsBySubCategory({String subCategory}) async {
    final response = await http.get("$URL_ITEM?$ITEM_SUBCATEGORY=$subCategory");

    // Caso sucesso.
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final items = (jsonResponse as List)
          .map((data) => Item.fromJson(json: data))
          .toList();

      return items;
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }
}
