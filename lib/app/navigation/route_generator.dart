import 'package:Ksolo/pages/settings/accountInfo/account_info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/basic/home_page.dart';
import '../../pages/basic/settings_page.dart';
import '../../pages/main_navigation.dart';
import '../../pages/settings/appearance/appearance_page.dart';
import '../../pages/start/authorization/authorization_page.dart';
import '../../pages/start/registration/registration_page.dart';
import '../../pages/start/start_page.dart';
import '../../pages/task/new_task_page.dart';
import '../../pages/task/task_details_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments;
    var page;
    switch (settings.name) {
      case '/':
        page = Start();
        break;
      case '/authorization':
        page = Authorization();
        break;
      case '/registration':
        page = Registration();
        break;
      case '/main':
        page = MainNavigation();
        break;
      case '/home':
        page = Home();
        break;
      case 'home/new_task':
        page = NewTask();
        break;
      case 'home/task':
        if (args['index'] != null && args['index'] is int) {
          page = Task(
            index: args['index'],
          );
        }
        break;
      case '/settings':
        if (args is String) {
          page = Settings();
        }
        break;
      case '/settings/appearance':
        page = Appearance();
        break;
      case '/settings/account_info':
        page = AccountInfo();
        break;
      default:
        return _errorRoute();
    }
    return MaterialPageRoute(builder: (_) => page ?? Home());
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
