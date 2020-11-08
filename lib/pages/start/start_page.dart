import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColorService>(
        builder: (context, appColorService, child) {
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;

      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              backgroundColor: AppElements.background.color(),
              appBar: AppBar(
                backgroundColor: AppElements.appbar.color(),
                centerTitle: true,
                title: Text(
                  'Ksolo',
                  style: TextStyle(color: AppElements.basicText.color()),
                ),
              ),
              body: FutureBuilder(
                future: _initialization,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return _somethingWentWrong();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Stack(children: [
                      GestureDetector(
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: CustomPaint(
                            painter: LeftButtonBackground(),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.2, left: width * 0.1),
                              child: Text(
                                'Create account',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: AppElements.basicText.color()),
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
                              padding: EdgeInsets.only(
                                  top: height * 0.65, left: width * 0.65),
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: AppElements.basicText.color()),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('/authorization');
                        },
                      ),
                    ]);
                  }
                  return _loading();
                },
              )));
    });
  }

  Widget _somethingWentWrong() {
    return Center(
      child: Container(
        width: 300,
        height: 200,
        child: Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(color: AppElements.appbar.color(), fontSize: 25),
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return Center(
      child: Container(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppElements.appbar.color()),
        ),
      ),
    );
  }
}
