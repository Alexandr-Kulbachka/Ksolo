import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_manager/pages/basic/settings.dart';

import '../style/app_scheme_colors.dart';
import '../enums/app_elements.dart';
import '../style/app_color_scheme.dart';
import 'basic/home.dart';

class MainNavigation extends StatefulWidget {
  int currentIndex;

  MainNavigation({Key key, this.currentIndex = 0}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final List<Widget> mainPages = [
    Home(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainPages[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppElements.bottomNavigationBar.color,
        showUnselectedLabels: false,
        unselectedLabelStyle: TextStyle(fontSize: 13),
        unselectedItemColor: AppSchemeColors.inactiveElement,
        selectedLabelStyle: TextStyle(fontSize: 16),
        selectedItemColor: AppElements.bottomNavigationBarItem.color,
        currentIndex: widget.currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
      ),
    );
  }
}
