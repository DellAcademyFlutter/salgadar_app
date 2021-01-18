import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/user_controller.dart';
import 'package:salgadar_app/app/repositories/local/database/shared_prefs.dart';
import 'package:salgadar_app/app/shared/themes/app_themes.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';

class UserSettingsController extends ChangeNotifier {
  final userController = Modular.get<UserController>();

  static const DEFAULT_FONT_SIZE = 19.5;

  // Atributos da classe
  AppThemesEnum _userTheme = AppThemesEnum.system;
  double _fontSize = DEFAULT_FONT_SIZE;

  initializeUserSettings() async {
    await loadUserSettings();
  }

  /// Modifica o tema do app.
  changeTheme({AppThemesEnum theme, BuildContext context}) async {
    // Escolha sistema
    if (theme == AppThemesEnum.system) {
      await cacheUserSettings(theme: theme);

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
    await cacheUserSettings();
  }

  /// Modifica o tema do app.
  changeFontSize({double newFontSize}) async {
    _fontSize = newFontSize;

    await cacheUserSettings();

    notifyListeners();
  }

  /// Armazena as configuracoes em Local Storage.
  cacheUserSettings({AppThemesEnum theme}) async {
    await SharedPrefs.save(
        getUserThemeLocalStorageKey(), theme?.toString() ?? _userTheme.toString());
    await SharedPrefs.save(
        getUserFontSizeLocalStorageKey(), _fontSize.toString());
  }

  /// Carrega as preferencias salvas em Local Storage.
  loadUserSettings() async {
    final themeKey = getUserThemeLocalStorageKey();
    await SharedPrefs.contains(themeKey).then((value) async {
      if (value) {
        await SharedPrefs.read(themeKey).then((value) {
          switch (value) {
            case 'AppThemesEnum.lightTheme':
              _userTheme = AppThemesEnum.lightTheme;
              break;
            case 'AppThemesEnum.darkTheme':
              _userTheme = AppThemesEnum.darkTheme;
              break;
            case 'AppThemesEnum.highContrast':
              _userTheme = AppThemesEnum.highContrast;
              break;
            default:
              _userTheme = AppThemesEnum.system;
              break;
          }
        });
      } else {
        _userTheme = AppThemesEnum.system;
      }
    });

    final fontSizeKey = getUserFontSizeLocalStorageKey();
    await SharedPrefs.contains(fontSizeKey).then((value) async {
      if (value) {
        await SharedPrefs.read(fontSizeKey).then((value) {
          _fontSize = double.parse(value);
        });
      } else {
        _fontSize = DEFAULT_FONT_SIZE;
      }
    });

    notifyListeners();
  }

  /// Atribui os valores padroes de configuracoes.
  setDefaultSettings(){
    _userTheme = AppThemesEnum.system;
    _fontSize = DEFAULT_FONT_SIZE;

    notifyListeners();
  }

  /// Retorna a Key em Local Storage.
  getUserThemeLocalStorageKey() =>
      '$USER_THEME/${userController?.loggedUser?.id ?? -1}';

  /// Retorna a Key em Local Storage.
  getUserFontSizeLocalStorageKey() =>
      '$USER_FONT_SIZE/${userController?.loggedUser?.id ?? -1}';

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
}
