import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_manager/app/services/app_color_service.dart';
import 'package:list_manager/components/simple_card.dart';
import 'package:provider/provider.dart';
import '../../enums/app_elements.dart';
import '../../style/app_color_scheme.dart';

class AppStyleSetting extends StatefulWidget {
  AppStyleSetting({Key key}) : super(key: key);

  @override
  _AppStyleSettingState createState() => _AppStyleSettingState();
}

class _AppStyleSettingState extends State<AppStyleSetting> {
  AppColorSchemes selectedScheme;
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
        backgroundColor: AppElements.appBar.color(colorScheme: selectedScheme),
        title: Text(
          'App color style',
          style: TextStyle(
              color: AppElements.basicText.color(colorScheme: selectedScheme)),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: SimpleCard(
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
                          child: AppColorSchemes.values[index] == selectedScheme
                              ? Icon(
                                  Icons.done_outline,
                                  color: Colors.green,
                                )
                              : Container(),
                        ),
                      ),
                      Text(
                        AppColorSchemes.values[index].name,
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
                  selectedScheme = AppColorSchemes.values[index];
                }),
              );
            },
            itemCount: AppColorSchemes.values.length,
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: _saveButton(),
          ))
        ],
      ),
    );
  }

  Widget _saveButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton(
        color: AppElements.button.color(colorScheme: selectedScheme),
        child: Container(
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(maxHeight: 70, maxWidth: 150),
          child: Text(
            'SAVE',
            style: TextStyle(
              color: AppElements.basicText.color(colorScheme: selectedScheme),
              fontSize: 20,
            ),
          ),
        ),
        onPressed: () => setState(() {
          appColorService.currentColorScheme = selectedScheme;
          Navigator.pop(context);
        }),
      ),
    );
  }
}
