import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../app/services/app_color_service.dart';
import '../../components/app_card.dart';
import 'package:provider/provider.dart';
import '../../enums/app_elements.dart';
import '../../style/app_color_scheme.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppColorService>(
        builder: (context, appColorService, child) {
      return Scaffold(
        backgroundColor: AppElements.background.color(),
        appBar: AppBar(
          backgroundColor: AppElements.appbar.color(),
          title: Text('SETTINGS'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[_settingsButton()],
          ),
        ),
      );
    });
  }

  Widget _settingsButton() {
    return GestureDetector(
      child: AppCard(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.all(15),
                child: Icon(
                  Icons.settings,
                  color: AppElements.basicText.color(),
                  size: 40,
                )),
            Text(
              'Appearance',
              style:
                  TextStyle(color: AppElements.basicText.color(), fontSize: 20),
            ),
            Container(
                margin: EdgeInsets.all(15),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppElements.basicText.color(),
                  size: 25,
                ))
          ],
        ),
        color: AppElements.simpleCard.color(),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/settings/color_scheme');
      },
    );
  }
}
