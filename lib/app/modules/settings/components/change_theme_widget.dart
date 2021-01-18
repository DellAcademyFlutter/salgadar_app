import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salgadar_app/app/controllers/user_settings_controller.dart';
import 'package:salgadar_app/app/shared/themes/app_themes.dart';

final List<String> values = [
  'Sistema',
  'Tema Claro',
  'Tema Escuro',
  'Alto contraste'
];

/// Esta classe retorna um widget referente a configuracao de tema escuro ou claro.
class ChangeThemeWidget extends StatefulWidget {
  @override
  _State createState() => _State();
}

/// Esta classe retorna um widget referente ao estado da configuracao de tema escuro ou claro.
class _State extends State<ChangeThemeWidget> {
  final settings = Modular.get<UserSettingsController>();
  Map<AppThemesEnum, String> themeDescriptionMap = {
    AppThemesEnum.system: "Tema do sistema.",
    AppThemesEnum.lightTheme: "Tema claro",
    AppThemesEnum.darkTheme: "Tema escuro.",
    AppThemesEnum.highContrast: "Melhora a distinção.",
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<UserSettingsController>(
      builder: (context, value) {
        return Card(
          child: ListTile(
            title: SingleChildScrollView(
                scrollDirection: Axis.horizontal, child: Text('Tema')),
            subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(themeDescriptionMap[settings.userTheme])),
            trailing: LightDarkThemeDropDownButton(),
          ),
        );
      },
    );
  }
}

/// Esta classe retorna um widget de dropdown de menu escuro ou claro.
class LightDarkThemeDropDownButton extends StatefulWidget {
  LightDarkThemeDropDownButton({Key key}) : super(key: key);

  @override
  LightDarkThemeDropDownButtonState createState() =>
      LightDarkThemeDropDownButtonState();
}

/// Esta classe retorna um widget de dropdown de menu escuro ou claro.
class LightDarkThemeDropDownButtonState
    extends State<LightDarkThemeDropDownButton> {
  String dropdownValue = _getDropdownValue();
  final settings = Modular.get<UserSettingsController>();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue, //"settings.themeDescription,
      icon: Icon(Icons.more_vert),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          AppThemesEnum theme;
          switch (newValue) {
            case 'Sistema':
              theme = AppThemesEnum.system;
              break;
            case 'Tema Escuro':
              theme = AppThemesEnum.darkTheme;
              break;
            case 'Alto contraste':
              theme = AppThemesEnum.highContrast;
              break;
            default:
              theme = AppThemesEnum.lightTheme;
              break;
          }
          settings.changeTheme(theme: theme, context: context);
        });
      },
      items: values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }
}

/// Retorna o valor inicial do dropdown.
_getDropdownValue() {
  final userSettingController = Modular.get<UserSettingsController>();
  switch (userSettingController.userTheme) {
    case AppThemesEnum.lightTheme:
      return 'Tema Claro';
      break;
    case AppThemesEnum.darkTheme:
      return 'Tema Escuro';
      break;
    case AppThemesEnum.highContrast:
      return 'Alto contraste';
      break;
    default:
      return 'Sistema';
      break;
  }
}
