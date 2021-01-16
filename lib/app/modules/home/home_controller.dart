import 'package:flutter/cupertino.dart';

class HomeController {
  final selectedIndex = ValueNotifier(0);

  /// Modifica o valor do [selectedIndex].
  changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
