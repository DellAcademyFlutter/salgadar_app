// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salgadar_app/app/app_module.dart';
import 'package:salgadar_app/app/controllers/cart_controller.dart';
import 'package:salgadar_app/app/models/item.dart';

void main() async {
  await Stetho.initialize();
  initModule(AppModule());

  /// Teste para verificacao do preço total do carrinho
  test('Teste de inicializacao do carrinho', () {
    final cartController = Modular.get<CartController>();

    cartController.reinitializeCart();
    expect(cartController.userCart.items.length, 0);
  });

  /// Teste para verificacao do preço total do carrinho
  test('Teste de quantidade de items do carrinho', () async {
    final cartController = Modular.get<CartController>();

    cartController.reinitializeCart();

    final item1 = Item(
        id: 0,
        category: 'food',
        name: 'risole',
        price: 10.50,
        description: 'Um risole de carne moída',
        image: 'image',
        subCategory: 'savory');

    await cartController.addItem(item1);
    await cartController.addItem(item1);

    expect(cartController.totalItems, 2);
  });

  test('Teste do preço do carrinho', () async {
    final cartController = Modular.get<CartController>();

    cartController.reinitializeCart();

    final item1 = Item(
        id: 0,
        category: 'food',
        name: 'risole',
        price: 10.50,
        description: 'Um risole de carne moída',
        image: 'image',
        subCategory: 'savory');

    final item2 = Item(
        id: 1,
        category: 'drink',
        name: 'suco de laranja',
        price: 0.50,
        description: 'Um sjuco de laranja doce e gelado',
        image: 'image',
        subCategory: 'juice');

    await cartController.addItem(item1);
    await cartController.addItem(item2);

    expect(cartController.totalValue, 11.00);
  });
}
