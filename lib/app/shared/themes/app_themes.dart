import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/user_settings_controller.dart';

enum AppThemesEnum { lightTheme, darkTheme, highContrast, system }

class ThemeCollection {
  /// Obtem o tema do usuario
  static ThemeData getAppTheme() {
    final settings = Modular.get<UserSettingsController>();

    switch (settings.userTheme) {
      case AppThemesEnum.darkTheme:
        return ThemeCollection.darkTheme();
        break;
      case AppThemesEnum.highContrast:
        return ThemeCollection.highContrastTheme();
        break;
      default:
        return ThemeCollection.defaultTheme();
        break;
    }
  }

  static defaultTheme() {
    final settings = Modular.get<UserSettingsController>();
    const primaryColor = Colors.indigo;

    return ThemeData(
      backgroundColor: primaryColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.black87,
              fontWeight: FontWeight.bold),
        ),
        color: primaryColor,
      ),
      brightness: Brightness.light,
      cardColor: primaryColor[100],
      buttonColor: primaryColor,
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        shape: RoundedRectangleBorder(),
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
      textTheme: TextTheme(
          headline5: TextStyle(color: Colors.green),
          headline6: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.black87,
              fontWeight: FontWeight.bold),
          bodyText2: TextStyle(
            fontSize: (settings.fontSize),
            color: Colors.black87,
          ),
          subtitle1: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.black87,
              fontWeight: FontWeight.bold),
          subtitle2: TextStyle(
            fontSize: (settings.fontSize - 5),
            color: Colors.black54,
          ),
          caption: TextStyle(
            fontSize: (settings.fontSize - 5),
            color: Colors.black54,
          )),
    );
  }

  static darkTheme() {
    final settings = Modular.get<UserSettingsController>();
    final primaryDarkThemeColor = Colors.grey[800];
    final secundaryDarkThemeColor = Colors.blue;

    return ThemeData(
      backgroundColor: primaryDarkThemeColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        color: primaryDarkThemeColor,
      ),
      brightness: Brightness.dark,
      cardColor: primaryDarkThemeColor,
      buttonColor: secundaryDarkThemeColor,
      buttonTheme: ButtonThemeData(
        buttonColor: secundaryDarkThemeColor,
        shape: RoundedRectangleBorder(),
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: secundaryDarkThemeColor,
      ),
      textTheme: TextTheme(
          headline5: TextStyle(color: Colors.green),
          headline6: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.white70,
              fontWeight: FontWeight.bold),
          bodyText2: TextStyle(
            fontSize: (settings.fontSize),
            color: Colors.white,
          ),
          subtitle1: TextStyle(
              fontSize: (settings.fontSize),
              color: Colors.white,
              fontWeight: FontWeight.bold),
          subtitle2: TextStyle(
            fontSize: (settings.fontSize - 5),
            color: Colors.white70,
          ),
          caption: TextStyle(
            fontSize: (settings.fontSize - 5),
            color: Colors.white60,
          )),
    );
  }

  static highContrastTheme() {
    final settings = Modular.get<UserSettingsController>();
    final primaryHighContrastColor = Colors.grey[800];
    final secundaryHighContrastColor = Colors.yellow;

    return ThemeData(
        backgroundColor: primaryHighContrastColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
            headline6: TextStyle(
                fontSize: (10 + settings.fontSize),
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          color: primaryHighContrastColor,
        ),
        brightness: Brightness.dark,
        cardColor: primaryHighContrastColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secundaryHighContrastColor,
        ),
        buttonColor: secundaryHighContrastColor,
        buttonTheme: ButtonThemeData(
          buttonColor: secundaryHighContrastColor,
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
            headline5: TextStyle(color: Colors.green),
            headline6: TextStyle(
                fontSize: (settings.fontSize),
                color: Colors.black87,
                fontWeight: FontWeight.bold),
            bodyText2: TextStyle(
                fontSize: (settings.fontSize),
                color: Colors.grey,
                fontWeight: FontWeight.bold),
            subtitle1: TextStyle(
                fontSize: (settings.fontSize),
                color: Colors.white70,
                fontWeight: FontWeight.bold),
            subtitle2: TextStyle(
              fontSize: (settings.fontSize - 5),
              color: Colors.white70,
            ),
            caption: TextStyle(
              fontSize: (settings.fontSize - 5),
              color: Colors.white70,
            )));
  }
}
