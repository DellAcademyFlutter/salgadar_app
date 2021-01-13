import 'package:flutter/cupertino.dart';
import 'package:salgadar_app/app/shared/themes/app_themes.dart';

class UserSettingsController extends ChangeNotifier {
  // Atributos da classe
  AppThemesEnum _userTheme = AppThemesEnum.system;
  double _fontSize = 19.5;
  final _defaultFontSize = 19.5;

  // Construtor da classe
  UserSettingsController();

  // Metodos da classe
  changeTheme({AppThemesEnum theme, BuildContext context}) {
    // Escolha sistema
    if (theme == AppThemesEnum.system) {
      // Primeiro verifica alto contraste
      (MediaQuery.of(context).highContrast == true)
          ? userTheme = AppThemesEnum.highContrast
          :
          // Depois verifica claro/escuro
          (MediaQuery.platformBrightnessOf(context) == Brightness.light)
              ? userTheme = AppThemesEnum.lightTheme
              : userTheme = AppThemesEnum.darkTheme;
      return;
    }

    userTheme = theme;
  }

  /// Get [_userTheme].
  AppThemesEnum get userTheme => _userTheme;

  /// Set [_userTheme].
  set userTheme(AppThemesEnum value) {
    _userTheme = value;
    notifyListeners();
  }

  /// Get [_fontSize].
  double get fontSize => _fontSize;

  /// Set [_fontSize].
  set fontSize(double value) {
    _fontSize = value;
    notifyListeners();
  }

  /// Get [_defaultFontSize].
  double get defaultFontSize => _defaultFontSize;
}
