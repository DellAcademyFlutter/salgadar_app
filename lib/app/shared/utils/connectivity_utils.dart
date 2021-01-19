import 'package:connectivity/connectivity.dart';
import 'package:salgadar_app/app/shared/utils/alert_dialog_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectivityUtils {
  /// Retorna a flag de conexao com internet.
  static Future<bool> hasInternetConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.wifi: // Wi-fi.
      case ConnectivityResult.mobile: // Rede movel.
        return true;
        break;
      default:
        return false; // Sem acesso a internet.
        break;
    }
  }

  /// [AlertDialog] de falha na conexao.
  static noConnectionMessage({BuildContext context}) {
    showAlertDialog(
        context: context,
        title: 'Falha na conexao com a internet!',
        message:
            'Por favor, verifique sua conexao com a internet e tente novamente.',
        buttonConfirmationLabel: 'ok');
  }

  /// [AlertDialog] de erro no carregamento.
  static loadErrorMessage({BuildContext context}) {
    showAlertDialog(
        context: context,
        title: 'Falha no carregamento!',
        message:
            'Ocorreu um erro inesperado no carregamento. Por favor, tente novamente.',
        buttonConfirmationLabel: 'ok');
  }
}
