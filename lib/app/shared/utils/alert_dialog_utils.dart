import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

showAlertDialog({BuildContext context, String title, String message,
    String buttonConfirmationLabel}) {
  // exibe o dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
              child: Text(buttonConfirmationLabel),
              onPressed: () {
                Modular.to.pop();
              },
            ),
          ],
        );
      });
}
