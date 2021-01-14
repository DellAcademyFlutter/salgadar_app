import 'package:flutter/cupertino.dart';

class HomeController {
  final selectedIndex = ValueNotifier(0);

  changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
