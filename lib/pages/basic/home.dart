import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppElements.appBar.color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('HOME')],
        ),
      ),
    );
  }
}
