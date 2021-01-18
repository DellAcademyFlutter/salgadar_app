import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Alert Dialog.
showAlertDialog(
    {BuildContext context,
    String title,
    String message,
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

/// Confirmation Dialog.
showAConfirmationDialog({BuildContext context, String title, String message,
    Function yesFunction, Function noFunction}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text("Sim"),
            onPressed: () async => await yesFunction(),
          ),
          FlatButton(
            child: Text("Não"),
            onPressed: () async => await noFunction(),
          ),
        ],
      );
    },
  );
}
