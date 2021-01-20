import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/data/api/item_api_dao.dart';
import 'package:salgadar_app/app/data/local/item_SQLite_dao.dart';
import 'package:salgadar_app/app/models/item.dart';
import 'package:http/http.dart' as http;

import '../shared/utils/connectivity_utils.dart';

class ItemController extends ChangeNotifier {
  List<Item> items = [];
  final itemSQLiteDao = Modular.get<ItemSQLiteDao>();
  final itemAPIDao = Modular.get<ItemAPIDao>();

  /// Adiciona um [Item].
  addItem(Item item) async {
    await itemAPIDao.postItem(item);
    final String base64Image = await imageUrlTobase64(item.image);
    item.image = base64Image;
    await itemSQLiteDao.insertItem(item);
    items.add(item);

    notifyListeners();
  }

  /// Atualiza um [Item].
  updateItem(Item item) async {
    await itemAPIDao.putItem(item);
    final String base64Image = await imageUrlTobase64(item.image);
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
  initializeItems({BuildContext context}) async {
    try {
      // Verificacao de internet
      final hasInternet = await ConnectivityUtils.hasInternetConnectivity();

      hasInternet
          ? await itemAPIDao.getItems().then((value) => items = value)
          : await itemSQLiteDao.getItems().then((value) => items = value);

      notifyListeners();
    } catch (e) {
      ConnectivityUtils.loadErrorMessage(context: context);
    }
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

  /// Retorna os items por subCategoria.
  Future<List<Item>> getItemsBySubCategory(
      {String subCategory, BuildContext context}) async {
    try {
      final hasInternet = await ConnectivityUtils.hasInternetConnectivity();

      final result = hasInternet
          ? await itemAPIDao.getItemsBySubCategory(subCategory: subCategory)
          : await itemSQLiteDao.getItemsBySubcategory(subcategory: subCategory);

      return result;
    } catch (e) {
      ConnectivityUtils.loadErrorMessage(context: context);
    }
  }

  /// Retorna o widget imagem do item.
  getItemImage({Item item, BuildContext context}) async {
    final hasInternet = await ConnectivityUtils.hasInternetConnectivity();

    return hasInternet
        ? Image.network(
            item.image,
            fit: BoxFit.fill,
          )
        : Image.memory(base64Decode(item.image), fit: BoxFit.fill);
  }

  /// Retorna o widget imagem do item, dado seu id.
  getItemThumbnailImage({int itemId, BuildContext context}) async {
    final hasInternet = await ConnectivityUtils.hasInternetConnectivity();

    final item = hasInternet
        ? await itemAPIDao.getItem(id: itemId)
        : await itemSQLiteDao.getItem(id: itemId);

    if (item == null) {
      return null;
    }

    return hasInternet
        ? Image.network(
            item.image,
            fit: BoxFit.fill,
          )
        : Image.memory(
            base64Decode(item.image),
            fit: BoxFit.fill,
          );
  }

  /// Converte uma imagem em URL para Base64.
  imageUrlTobase64(String url) async {
    final response = await http.get(url);
    return base64Encode(response.bodyBytes);
  }
}
