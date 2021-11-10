import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  AppColorScheme _selectedScheme;
  AppColorService appColorService;

  @override
  void initState() {
    appColorService = Provider.of<AppColorService>(context, listen: false);
    _selectedScheme = appColorService.currentColorScheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppElements.background.color(colorScheme: _selectedScheme),
      appBar: AppBar(
        backgroundColor: AppElements.appbar.color(colorScheme: _selectedScheme),
        brightness: getCurrentAppBarBrightness(colorScheme: _selectedScheme),
        title: Text(
          AppLocalizations.of(context).appearance,
          style: TextStyle(color: AppElements.basicText.color(colorScheme: _selectedScheme)),
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
                            border: Border.all(width: 2, color: _selectedScheme.mainColor)),
                        child: Container(
                          height: 30,
                          width: 30,
                          child: AppColorScheme.values[index] == _selectedScheme
                              ? Icon(
                                  Icons.done_outline,
                                  color: Colors.green,
                                )
                              : Container(),
                        ),
                      ),
                      Text(
                        AppColorScheme.values[index].nameLabel(context),
                        style: TextStyle(
                          color: AppElements.basicText.color(colorScheme: _selectedScheme),
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  color: AppElements.simpleCard.color(colorScheme: _selectedScheme),
                ),
                onTap: () => setState(() {
                  _selectedScheme = AppColorScheme.values[index];
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
              text: AppLocalizations.of(context).save,
              textSize: 20,
              buttonColor: AppElements.enabledButton.color(colorScheme: _selectedScheme),
              onPressed: _selectedScheme != appColorService.currentColorScheme
                  ? () => setState(() {
                        appColorService.currentColorScheme = _selectedScheme;
                        Navigator.pop(context);
                      })
                  : null,
            ),
          ))
        ],
      ),
    );
  }
}
