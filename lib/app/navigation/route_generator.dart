import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      case '/settings':
        if (args is String) {
          page = Settings(
            title: args,
          );
        }
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
