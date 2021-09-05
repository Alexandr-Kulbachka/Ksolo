import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/services/app_color_service.dart';
import '../../../components/app_button.dart';
import '../../../components/app_card.dart';
import '../../../style/app_color_scheme.dart';


class Appearance extends StatefulWidget {
  Appearance({Key key}) : super(key: key);

  @override
  _AppearanceState createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  AppColorScheme selectedScheme;
  AppColorService appColorService;

  @override
  void initState() {
    appColorService = Provider.of<AppColorService>(context, listen: false);
    selectedScheme = appColorService.currentColorScheme;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppElements.background.color(colorScheme: selectedScheme),
      appBar: AppBar(
        backgroundColor: AppElements.appbar.color(colorScheme: selectedScheme),
        title: Text(
          'Appearance',
          style: TextStyle(
              color: AppElements.basicText.color(colorScheme: selectedScheme)),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: AppCard(
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 2, color: selectedScheme.mainColor)),
                        child: Container(
                          height: 30,
                          width: 30,
                          child: AppColorScheme.values[index] == selectedScheme
                              ? Icon(
                                  Icons.done_outline,
                                  color: Colors.green,
                                )
                              : Container(),
                        ),
                      ),
                      Text(
                        AppColorScheme.values[index].name,
                        style: TextStyle(
                          color: AppElements.basicText
                              .color(colorScheme: selectedScheme),
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  color:
                      AppElements.simpleCard.color(colorScheme: selectedScheme),
                ),
                onTap: () => setState(() {
                  selectedScheme = AppColorScheme.values[index];
                }),
              );
            },
            itemCount: AppColorScheme.values.length,
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: AppButton(
              margin: EdgeInsets.only(bottom: 10),
              text: 'SAVE',
              textSize: 20,
              textColor:
                  AppElements.basicText.color(colorScheme: selectedScheme),
              buttonColor:
                  AppElements.enabledButton.color(colorScheme: selectedScheme),
              onPressed: () => setState(() {
                appColorService.currentColorScheme = selectedScheme;
                Navigator.pop(context);
              }),
            ),
          ))
        ],
      ),
    );
  }
}
