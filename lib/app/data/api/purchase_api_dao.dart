import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salgadar_app/app/models/purchase.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';

class PurchaseAPIDao {
  /// Post - adiciona um [Purchase].
  Future<http.Response> postPurchase({Purchase purchase}) async {
    final headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode(purchase.toJson());
    final response =
        await http.post(URL_PURCHASE, body: body, headers: headers);

    return response;
  }

  /// Put - atualiza um [Card].
  Future<Purchase> putPurchase({Purchase purchase}) async {
    final response = await http.put(
      '$URL_PURCHASE/${purchase.userId & purchase.cartId}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(purchase.toJson()),
    );

    // Caso sucesso
    if (response.statusCode == 200) {
      return Purchase.fromJson(json: jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }

  /// Get - busca todos [Purchase].
  Future<List<Purchase>> getPurchases() async {
    final response = await http.get(URL_PURCHASE);

    // Caso sucesso.
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final purchases = (jsonResponse as List)
          .map((data) => Purchase.fromJson(json: data))
          .toList();

      return purchases;
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }

  /// Delete - remove um [Purchase].
  Future<http.Response> deletePurchase({int id}) async {
    final response = await http.delete(
      '$URL_PURCHASE/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  /// Busca um [Purchase].
  Future<Purchase> getPurchase({id}) async {
    final response = await http.get("$URL_PURCHASE/$id");

    // Caso sucesso
    if (response.statusCode == 200) {
      return Purchase.fromJson(json: jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha no carregamento.');
    }
  }
}
