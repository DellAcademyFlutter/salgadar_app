import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/item_controller.dart';
import 'package:salgadar_app/app/models/item.dart';
import 'package:salgadar_app/app/shared/utils/url_images.dart';

class PreconfigureSalgadar {
  static initializeSalgadarItems() async {
    final itemController = Modular.get<ItemController>();

    final item1 = Item(
      id: 1,
      name: 'Croissant',
      image: URL_SAVORY_CROISSANTS,
      description: 'Salgado de massa foliada recheado com queijo.',
      category: 'food',
      subCategory: 'savory',
      price: 3.00,
    );

    final item2 = Item(
      id: 2,
      name: 'Frango empanado',
      image: URL_SAVORY_FRIED_CHICKEN,
      description: 'Salgado de frango frito.',
      category: 'food',
      subCategory: 'savory',
      price: 1.00,
    );

    final item3 = Item(
      id: 3,
      name: 'Onion ring',
      image: URL_SAVORY_ONION_RING,
      description: 'Cebola empanada e frita.',
      category: 'food',
      subCategory: 'savory',
      price: 0.50,
    );

    final item4 = Item(
      id: 4,
      name: 'Torta de mirtilo',
      image: URL_SAVORY_BLUEBERRY_PIE,
      description: 'Torta recheada com os deliciosos e suculentos mirtilos!',
      category: 'food',
      subCategory: 'savory',
      price: 3.00,
    );

    final item5 = Item(
      id: 5,
      name: 'Bacon',
      image: URL_PIZZA_BACON,
      description: 'Pizza recheada com bacon.',
      category: 'food',
      subCategory: 'pizza',
      price: 18.00,
    );

    final item6 = Item(
      id: 6,
      name: 'Queijo',
      image: URL_PIZZA_CHEESE,
      description: 'Pizza recheada com queijo.',
      category: 'food',
      subCategory: 'pizza',
      price: 16.00,
    );

    final item7 = Item(
      id: 7,
      name: 'Marguerita',
      image: URL_PIZZA_MARGUERITA,
      description: 'Pizza recheada com queijo, tomate e manjericão.',
      category: 'food',
      subCategory: 'pizza',
      price: 17.00,
    );

    final item8 = Item(
      id: 8,
      name: 'Pepperoni ',
      image: URL_PIZZA_PEPPERONI,
      description: 'Pizza recheada com pepperoni e queijo.',
      category: 'food',
      subCategory: 'pizza',
      price: 20.00,
    );

    final item9 = Item(
      id: 9,
      name: 'Cheese Burger',
      image: URL_HAMBURGER_CHEESEBURGER,
      description: 'Hamburger recheado com queijo!',
      category: 'food',
      subCategory: 'hamburger',
      price: 7.00,
    );

    final item10 = Item(
      id: 10,
      name: 'Clássico',
      image: URL_HAMBURGER_CLASSIC,
      description: 'Nada como um bom clássico!',
      category: 'food',
      subCategory: 'hamburger',
      price: 5.00,
    );

    final item11 = Item(
      id: 11,
      name: 'Misto-quente',
      image: URL_HAMBURGER_DOUBLE,
      description: 'Sanduíche recheado com queijo e presunto!',
      category: 'food',
      subCategory: 'hamburger',
      price: 5.00,
    );

    final item12 = Item(
      id: 12,
      name: 'Duplo',
      image: URL_HAMBURGER_DOUBLE,
      description: 'Hamburger com duas camadas.',
      category: 'food',
      subCategory: 'hamburger',
      price: 7.50,
    );

    final item13 = Item(
      id: 13,
      name: 'Suco de laranja',
      image: URL_JUICE_ORANGE,
      description: 'Suco de laranja geladinho!',
      category: 'drink',
      subCategory: 'juice',
      price: 2.00,
    );

    final item14 = Item(
      id: 14,
      name: 'Suco de maracujá',
      image: URL_JUICE_PASSION_FRUIT,
      description: 'Suco de maracujá geladinho!',
      category: 'drink',
      subCategory: 'juice',
      price: 2.00,
    );

    final item15 = Item(
      id: 15,
      name: 'Café',
      image: URL_JUICE_COFFEE,
      description: 'Nada como um café quentinho!',
      category: 'drink',
      subCategory: 'juice',
      price: 2.00,
    );

    final item16 = Item(
      id: 16,
      name: 'Chocolate',
      image: URL_SMOOTHIE_CHOCOLATE,
      description: 'Vitamina de chocolate.',
      category: 'drink',
      subCategory: 'smoothie',
      price: 4.50,
    );

    final item17 = Item(
      id: 17,
      name: 'Uva',
      image: URL_SMOOTHIE_GRAPE,
      description: 'Vitamina de uva.',
      category: 'drink',
      subCategory: 'smoothie',
      price: 3.50,
    );

    final item18 = Item(
      id: 18,
      name: 'Abacaxi',
      image: URL_SMOOTHIE_PINEAPPLE,
      description: 'Vitamina de abacaxi.',
      category: 'drink',
      subCategory: 'smoothie',
      price: 3.50,
    );

    final item19 = Item(
      id: 19,
      name: 'Morango',
      image: URL_SMOOTHIE_STRAWBERRY,
      description: 'Vitamina de morango.',
      category: 'drink',
      subCategory: 'smoothie',
      price: 4.00,
    );

    final items = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8,
      item9,
      item10,
      item11,
      item12,
      item13,
      item14,
      item15,
      item16,
      item17,
      item18,
      item19
    ];

    for (var i = 0; i < items.length; i++) {
      itemController.addItem(items[i]);
    }
  }
}
