import 'package:Ksolo/app/services/app_color_service.dart';
import 'package:Ksolo/enums/app_elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../style/app_color_scheme.dart';

class Registration extends StatefulWidget {
  Registration({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppColorService>(
        builder: (context, appColorService, child) {
          return Scaffold(
            backgroundColor: AppElements.background.color(),
            appBar: AppBar(
              backgroundColor: AppElements.appbar.color(),
              title: Text('Registration'),
            ),
            body: Center(

            ),
          );
        });
  }
}
