import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_manager/enums/app_color_scheme.dart';

class ListsPage extends StatefulWidget {
  ListsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListsPagePageState createState() => _ListsPagePageState();
}

class _ListsPagePageState extends State<ListsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppElementsColors.appBar.color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}