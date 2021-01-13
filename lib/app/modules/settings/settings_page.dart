import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/change_theme_widget.dart';
import 'components/text_size_widget.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: [
            ChangeThemeWidget(),
            TextSizeWidget(),
          ],
        ),
      ),
    );
  }
}
