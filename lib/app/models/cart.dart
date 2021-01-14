import 'package:flutter/cupertino.dart';
import 'package:salgadar_app/app/models/item_cart.dart';

class Cart {
  // Construtor da classe.
  Cart({
    this.id,
    this.items,
  });

  // Atributos da classe.
  int id;
  List<ItemCart> items;

  // Construtor a partir de um json.
  Cart.fromJson({Map<String, dynamic> json}) {
    id = json['id'];
    items = json['items'].map((item) => ItemCart.fromJson(json: item)).toList();
  }

  // Codifica este objeto em um map.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['id'] = id;
    json['items'] = items.map((item) => item.toJson()).toList();
    return json;
  }

  // Copia os valores de outro objeto, do mesmo tipo, para este objeto.
  setValues({@required Cart otherCart}) {
    id = otherCart.id;
    items = otherCart.items;
  }
}
