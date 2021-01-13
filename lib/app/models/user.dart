import 'package:flutter/cupertino.dart';

class User {
  // Construtor da classe.
  User(
      {this.id,
      this.username,
      this.password,
      this.name,
      this.birthday,
      this.email});

  // Atributos da classe.
  int id;
  String username;
  String password;
  String name;
  String birthday;
  String email;

  // Construtor a partir de um json.
  User.fromJson({Map<String, dynamic> json}) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    birthday = json['birthday'];
    email = json['email'];
  }

  // Codifica este objeto em um map.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['id'] = id;
    json['username'] = username;
    json['password'] = password;
    json['name'] = name;
    json['birthday'] = birthday;
    json['email'] = email;
    return json;
  }

  // Copia os valores de outro objeto, do mesmo tipo, para este objeto.
  setValues({@required User otherUser}) {
    id = otherUser.id;
    username = otherUser.username;
    password = otherUser.password;
    name = otherUser.name;
    birthday = otherUser.birthday;
    email = otherUser.email;
  }
}
