import 'package:flutter/material.dart';
import 'package:salgadar_app/app/modules/settings/components/change_theme_widget.dart';
import 'package:salgadar_app/app/modules/settings/components/text_size_widget.dart';

class SystemSettingsPage extends StatefulWidget {
  @override
  _SystemSettingsPageState createState() => _SystemSettingsPageState();
}

class _SystemSettingsPageState extends State<SystemSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView(
          children: [
            ChangeThemeWidget(),
            TextSizeWidget(),
          ],
        ),
      ),
    ]);
  }
}
