import 'package:flutter/cupertino.dart';

class Purchase {
  // Construtor da classe.
  Purchase(
      {this.id,
      this.userId,
      this.cartId,
      this.totalValue,
      this.date,
      this.isDeleted});

  // Atributos da classe.
  int id;
  int userId;
  int cartId;
  double totalValue;
  String date;
  bool isDeleted;

  // Construtor a partir de um json.
  Purchase.fromJson({Map<String, dynamic> json}) {
    id = json['id'];
    userId = json['userId'];
    cartId = json['cartId'];
    totalValue = json['totalValue'].toDouble();
    date = json['date'];
    isDeleted = json['isDeleted'] == '1';
  }

  // Codifica este objeto em um map.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['id'] = id;
    json['userId'] = userId;
    json['cartId'] = cartId;
    json['totalValue'] = totalValue;
    json['date'] = date;
    json['isDeleted'] = isDeleted ? 1 : 0;
    return json;
  }

  // Copia os valores de outro objeto, do mesmo tipo, para este objeto.
  setValues({@required Purchase otherPurchase}) {
    id = otherPurchase.id;
    userId = otherPurchase.userId;
    cartId = otherPurchase.cartId;
    totalValue = otherPurchase.totalValue;
    date = otherPurchase.date;
    isDeleted = otherPurchase.isDeleted;
  }
}
