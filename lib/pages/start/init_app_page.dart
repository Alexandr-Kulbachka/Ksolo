import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../app/services/locale_service.dart';
import '../../app/services/account_service.dart';
import '../../app/services/app_color_service.dart';
import '../../components/ksolo_loading.dart';
import '../../components/fb_auth_success_error_message.dart';
import '../../style/app_color_scheme.dart';

class InitApp extends StatefulWidget {
  InitApp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _initialization = Firebase.initializeApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppColorService, LocaleService>(builder: (context, appColorService, localeService, child) {
      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              backgroundColor: AppElements.background.color(),
              body: FutureBuilder(
                future: _initialization,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return _somethingWentWrong();
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      AppColorService.currentAppColorScheme != null) {
                    var accountService = Provider.of<AccountService>(context);
                    if (accountService != null &&
                        localeService.currentLocale != null) {
                      _callSignInAutomatically(context, accountService);
                    }
                  }
                  return KsoloLoading();
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

  void _callSignInAutomatically(BuildContext context, AccountService accountService) async {
    var result = await accountService.signInAutomatically();
    fbAuthSuccessErrorMessage(
        result: result,
        context: context,
        successAction: () {
          Navigator.of(context).pushReplacementNamed('/main');
        },
        errorAction: () {
          Navigator.of(context).pushReplacementNamed('/start');
        });
  }
}
