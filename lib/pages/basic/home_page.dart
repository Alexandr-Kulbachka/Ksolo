import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app/services/tasks_service.dart';
import '../../components/app_card.dart';
import '../../app/services/app_color_service.dart';
import '../../components/circled_button.dart';
import '../../style/app_color_scheme.dart';

class Home extends StatefulWidget {
  int currentBottomNavigationIndex;

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    widget.currentBottomNavigationIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppColorService, TasksService>(
        builder: (context, appColorService, tasksService, child) {
      return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(AppLocalizations.of(context).main),
          actions: [
            CircledButton(
              size: 45,
              margin: EdgeInsets.symmetric(horizontal: 4),
              iconColor: AppElements.basicText.color(),
              icon: Icons.search,
              onPressed: () {},
            ),
            CircledButton(
              size: 45,
              margin: EdgeInsets.only(left: 4, right: 15),
              iconColor: AppElements.basicText.color(),
              icon: Icons.add,
              onPressed: () {
                Navigator.of(context).pushNamed('home/new_task');
              },
            )
          ],
        ),
        body: GestureDetector(
          child: Center(
            child: tasksService.size == 0
                ? Text(
                    'No tasks',
                    style: TextStyle(
                      fontSize: 25,
                      color: AppElements.textOnBackground.color(),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, i) {
                      var task = tasksService.getTask(i);
                      return GestureDetector(
                          child: AppCard(
                            Column(
                              children: [
                                Row(children: [
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      child: Text(
                                        task.title,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: AppElements.basicText.color(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer()
                                ]),
                                Row(children: [
                                  Flexible(
                                      child: Text(
                                    task.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppElements.basicText.color()),
                                  ))
                                ])
                              ],
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, 'home/task',
                                arguments: {'index': i});
                          });
                    },
                    itemCount: tasksService.size,
                  ),
          ),
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
        ),
      );
    });
  }
}
