import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../pages/appearance/appearance.dart';
import '../../pages/new_list/new_task.dart';
import '../../pages/main_navigation.dart';
import '../../pages/basic/home.dart';
import '../../pages/basic/settings.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    var page;
    switch (settings.name) {
      case '/':
        page = MainNavigation();
        break;
      case '/home':
        page = Home();
        break;
      case 'home/new_list':
        page = NewTask();
        break;
      case '/settings':
        if (args is String) {
          page = Settings();
        }
        break;
      case '/settings/color_scheme':
        page = Appearance();
        break;
      default:
        return _errorRoute();
    }
    return MaterialPageRoute(builder: (_) => page);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('ERROR!'),
          ));
    });
  }
}
