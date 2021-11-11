import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app/services/account_service.dart';
import '../../style/app_color_scheme.dart';
import '../../app/services/app_color_service.dart';
import 'components/right_button_background.dart';
import 'components/left_button_background.dart';

class Start extends StatefulWidget {
  Start({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppColorService, AccountService>(builder: (context, appColorService, accountService, child) {
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;

      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              appBar: AppBar(
                leading: Container(),
                centerTitle: true,
                title: Text(
                  'Ksolo',
                  style: TextStyle(color: AppElements.basicText.color()),
                ),
              ),
              body: Stack(children: [
                GestureDetector(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: CustomPaint(
                      painter: LeftButtonBackground(),
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.2, left: width * 0.05),
                        child: Text(
                          AppLocalizations.of(context).registration,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold, color: AppElements.basicText.color()),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/registration');
                  },
                ),
                GestureDetector(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: CustomPaint(
                      painter: RightButtonBackground(),
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.65, left: width * 0.6),
                        child: Text(
                          AppLocalizations.of(context).signIn,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold, color: AppElements.basicText.color()),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/authorization');
                  },
                ),
              ])));
    });
  }
}
