import 'package:flutter/cupertino.dart';

class Item {
  // Construtor da classe.
  Item(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.category,
      this.subCategory,
      this.price});

  // Atributos da classe.
  int id;
  String name;
  String description;
  String image;
  String category;
  String subCategory;
  double price;

  // Construtor a partir de um json.
  Item.fromJson({Map<String, dynamic> json}) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    category = json['category'];
    subCategory = json['subCategory'];
    price = json['price'];
  }

  // Codifica este objeto em um map.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['description'] = description;
    json['image'] = image;
    json['category'] = category;
    json['subCategory'] = subCategory;
    json['price'] = price;
    return json;
  }

  // Copia os valores de outro objeto, do mesmo tipo, para este objeto.
  setValues({@required Item otherItem}) {
    id = otherItem.id;
    name = otherItem.name;
    description = otherItem.description;
    image = otherItem.image;
    category = otherItem.category;
    subCategory = otherItem.subCategory;
    price = otherItem.price;
  }
}
