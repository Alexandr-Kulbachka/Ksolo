import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../enums/app_elements.dart';
import '../../style/app_color_scheme.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title = 'SETTINGS'}) : super(key: key);
  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppElements.appBar.color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('SETTINGS')],
        ),
      ),
    );
  }
}
