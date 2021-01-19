import 'package:flutter/material.dart';

class FocusUtils{
  /// Este metodo remove o focus de um widget.
  static removeFocus({BuildContext context}) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    // Remove o focus do widget atual
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}