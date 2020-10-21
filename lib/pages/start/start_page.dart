import 'package:Ksolo/app/services/app_color_service.dart';
import 'package:Ksolo/enums/app_elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../style/app_color_scheme.dart';

class Start extends StatefulWidget {
  Start({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppColorService>(
        builder: (context, appColorService, child) {
      return Scaffold(
        backgroundColor: AppElements.background.color(),
        appBar: AppBar(
          backgroundColor: AppElements.appbar.color(),
          title: Text(
            'Ksolo',
            style: TextStyle(color: AppElements.basicText.color()),
          ),
        ),
        body: Center(),
      );
    });
  }
}
