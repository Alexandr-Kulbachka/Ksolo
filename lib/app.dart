import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app/services/account_service.dart';
import 'app/services/app_color_service.dart';
import 'app/navigation/route_generator.dart';
import 'app/services/locale_service.dart';
import 'app/services/tasks_service.dart';
import 'l10n/all_locales.dart';
import 'style/app_color_scheme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountService()),
        ChangeNotifierProvider(create: (_) => AppColorService()),
        ChangeNotifierProvider(create: (_) => TasksService()),
        ChangeNotifierProvider(create: (_) => LocaleService()),
      ],
      child: Consumer<AppColorService>(builder: (context, appColorService, child) {
        return MaterialApp(
          theme: ThemeData(
              bottomNavigationBarTheme:
                  BottomNavigationBarThemeData(backgroundColor: AppElements.bottomNavigationBar.color()),
              scaffoldBackgroundColor: AppElements.background.color(),
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme:
                  AppBarTheme(backgroundColor: AppElements.appbar.color(), brightness: getCurrentAppBarBrightness()),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: AppElements.basicText.color(),
                ),
              )),
              buttonTheme: ButtonThemeData(
                  buttonColor: AppElements.enabledButton.color(),
                  disabledColor: AppElements.disabledButton.color(),
                  textTheme: ButtonTextTheme.primary)),
          supportedLocales: AllLocales.all.values,
          locale: Provider.of<LocaleService>(context).currentLocale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      }),
    );
  }
}
