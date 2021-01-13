import 'package:flutter/cupertino.dart';

class ItemCart {
  // Construtor da classe.
  ItemCart({
    this.itemId,
    this.cartId,
    this.qtt,
    this.itemPrice,
  });

  // Atributos da classe.
  int itemId;
  int cartId;
  int qtt;
  double itemPrice;

  // Construtor a partir de um json.
  ItemCart.fromJson({Map<String, dynamic> json}) {
    itemId = json['itemId'];
    cartId = json['cartId'];
    qtt = json['qtt'];
    itemPrice = json['itemPrice'];
  }

  // Codifica este objeto em um map.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['itemId'] = itemId;
    json['cartId'] = cartId;
    json['qtt'] = qtt;
    json['itemPrice'] = itemPrice;
    return json;
  }

  // Copia os valores de outro objeto, do mesmo tipo, para este objeto.
  setValues({@required ItemCart otherItemCart}) {
    itemId = otherItemCart.itemId;
    cartId = otherItemCart.cartId;
    qtt = otherItemCart.qtt;
    itemPrice = otherItemCart.itemPrice;
  }
}
