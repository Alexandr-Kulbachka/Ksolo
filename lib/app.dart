import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app/services/app_color_service.dart';
import 'package:provider/provider.dart';
import 'app/navigation/route_generator.dart';
import 'app/services/tasks_service.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppColorService()),
        ChangeNotifierProvider(create: (_) => TasksService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
