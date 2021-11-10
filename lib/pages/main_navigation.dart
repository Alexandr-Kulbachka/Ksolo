import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app/services/app_color_service.dart';
import '../pages/basic/settings_page.dart';
import '../style/app_custom_colors.dart';
import '../style/app_color_scheme.dart';
import 'basic/home_page.dart';

class MainNavigation extends StatefulWidget {
  MainNavigation({Key key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> mainPages = [Home(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColorService>(builder: (context, appColorService, child) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: mainPages[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            unselectedLabelStyle: TextStyle(fontSize: 13),
            unselectedItemColor: AppCustomColors.inactiveElement,
            selectedLabelStyle: TextStyle(fontSize: 16),
            selectedItemColor: AppElements.bottomNavigationBarItem.color(),
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: AppLocalizations.of(context).mainSmall,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: AppLocalizations.of(context).settingsSmall,
              ),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      );
    });
  }
}
