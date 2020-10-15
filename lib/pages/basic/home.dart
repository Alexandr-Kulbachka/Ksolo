import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_manager/app/services/app_color_service.dart';
import 'package:provider/provider.dart';
import '../../enums/app_elements.dart';
import '../../style/app_color_scheme.dart';
import '../main_navigation.dart';

class Home extends StatefulWidget {
  int currentBottomNavigationIndex;
  final String title;

  Home({Key key, this.title = 'HOME'}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    widget.currentBottomNavigationIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColorService>(
        builder: (context, appColorService, child) {
      return Scaffold(
        backgroundColor: AppElements.background.color(),
        appBar: AppBar(
          backgroundColor: AppElements.appBar.color(),
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('HOME')],
          ),
        ),
      );
    });
  }
}
