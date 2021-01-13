import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salgadar_app/app/models/cart.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';

/// Post - adiciona um [Cart] e retorna [id] gerado.
Future<int> postCart({Cart cart}) async {
  final headers = <String, String>{
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  final body = jsonEncode(cart.toJson());
  final response = await http.post(URL_CART, body: body, headers: headers);
  final jsonResponse = jsonDecode(response.body);

  return jsonResponse['id'];
}

/// Put - atualiza um [Card].
Future<Cart> putCart({Cart cart}) async {
  final response = await http.put(
    '$URL_CART/${cart.id}',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(cart.toJson()),
  );

  // Caso sucesso
  if (response.statusCode == 200) {
    return Cart.fromJson(json: jsonDecode(response.body));
  } else {
    throw Exception('Ocorreu uma falha no carregamento.');
  }
}

/// Busca um [Cart].
Future<Cart> getCart({id}) async {
  final response = await http.get("$URL_CART/$id");

  // Caso sucesso
  if (response.statusCode == 200) {
    return Cart.fromJson(json: jsonDecode(response.body));
  } else {
    throw Exception('Ocorreu uma falha no carregamento.');
  }
}

/// Get - busca todos [Cart].
Future<List<Cart>> getCarts() async {
  final response = await http.get(URL_CART);

  // Caso sucesso.
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final carts = (jsonResponse as List)
        .map((data) => Cart.fromJson(json: data))
        .toList();

    return carts;
  } else {
    throw Exception('Ocorreu uma falha no carregamento.');
  }
}

/// Delete - remove um [Cart].
Future<http.Response> deleteCart({int id}) async {
  final response = await http.delete(
    '$URL_CART/$id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}
