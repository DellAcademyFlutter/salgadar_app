import 'package:flutter/cupertino.dart';

class Cart {
  // Construtor da classe.
  Cart({
    this.id,
  });

  // Atributos da classe.
  int id;

  // Construtor a partir de um json.
  Cart.fromJson({Map<String, dynamic> json}) {
    id = json['id'];
  }

  // Codifica este objeto em um map.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['id'] = id;
    return json;
  }

  // Copia os valores de outro objeto, do mesmo tipo, para este objeto.
  setValues({@required Cart otherCart}) {
    id = otherCart.id;
  }
}
