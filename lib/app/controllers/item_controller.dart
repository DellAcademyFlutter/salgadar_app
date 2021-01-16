import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/data/api/item_api_dao.dart';
import 'package:salgadar_app/app/data/local/item_SQLite_dao.dart';
import 'package:salgadar_app/app/models/item.dart';
import 'package:http/http.dart' as http;

class ItemController extends ChangeNotifier {
  List<Item> items = [];
  final itemSQLiteDao = Modular.get<ItemSQLiteDao>();
  final itemAPIDao = Modular.get<ItemAPIDao>();

  /// Adiciona um [Item].
  addItem(Item item) async {
    await itemAPIDao.postItem(item);
    String base64Image = await imageUrlTobase64(item.image);
    item.image = base64Image;
    await itemSQLiteDao.insertItem(item);
    items.add(item);

    notifyListeners();
  }

  /// Atualiza um [Item].
  updateItem(Item item) async {
    await itemAPIDao.putItem(item);
    String base64Image = await imageUrlTobase64(item.image);
    item.image = base64Image;
    await itemSQLiteDao.updateItem(item);
    items[getItemIndexById(item.id)].setValues(otherItem: item);

    notifyListeners();
  }

  /// Remove um [Item] o marcando como removido.
  removeItem(Item item) async {
    await itemAPIDao.deleteItem(id: item.id);
    await itemSQLiteDao.deleteItem(item.id);
    items.remove(item);

    notifyListeners();
  }

  /// Inicializa com todos [Item]s.
  initializeItems() async {
    await itemAPIDao.getItems().then((value) => items = value);
    //await itemSQLiteDao.getItems().then((value) => items = value); pelo SQLite

    notifyListeners();
  }

  /// Retorna o index de um [Item] dado seu [id].
  getItemIndexById(int id) {
    for (var i = 0; i < items.length; i++) {
      if (items[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  /// Retorna um [Item] dado seu [id].
  getItemById(int id) {
    for (var i = 0; i < items.length; i++) {
      if (items[i].id == id) {
        return items[i];
      }
    }
    return null;
  }

  getItemImage({Item item, BuildContext context}) {
    // Online
    return Image.network(item.image,
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width * 0.10,
        fit: BoxFit.fill);
    //
    //Offline
    // return Image.memory(base64Decode(item.image),
    //     height: MediaQuery.of(context).size.height * 0.10,
    //     width: MediaQuery.of(context).size.width * 0.10,
    //     fit: BoxFit.fill);
  }

  imageUrlTobase64(String url) async {
    http.Response response = await http.get(url);
    return base64Encode(response.bodyBytes);
  }
}
