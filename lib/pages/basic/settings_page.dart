import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app/services/account_service.dart';
import '../../components/app_button.dart';
import '../../components/fb_auth_success_error_message.dart';
import '../../app/services/app_color_service.dart';
import '../../components/app_card.dart';
import '../../style/app_color_scheme.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppColorService, AccountService>(builder: (context, appColorService, accountService, child) {
      return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(AppLocalizations.of(context).settings),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              _settingsButton(
                  icon: Icons.person,
                  title: AppLocalizations.of(context).accountSettings,
                  onTap: () {
                    Navigator.pushNamed(context, '/settings/account_info');
                  }),
              _settingsButton(
                  icon: Icons.visibility,
                  title: AppLocalizations.of(context).appearance,
                  onTap: () {
                    Navigator.pushNamed(context, '/settings/appearance');
                  }),
              _settingsButton(
                  icon: Icons.language,
                  title: AppLocalizations.of(context).language,
                  onTap: () {
                    Navigator.pushNamed(context, '/settings/language');
                  }),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: _settingsButton(
                    icon: Icons.logout,
                    title: AppLocalizations.of(context).logout,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppElements.appbar.color(),
                              title: Text(
                                AppLocalizations.of(context).logoutQuestion,
                                style: TextStyle(
                                  color: AppElements.basicText.color(),
                                ),
                              ),
                              actions: [
                                AppButton(
                                    text: AppLocalizations.of(context).yes,
                                    buttonColor: AppElements.simpleCard.color(),
                                    textColor: AppElements.basicText.color(),
                                    onPressed: () async {
                                      var result = await accountService.signOut();
                                      fbAuthSuccessErrorMessage(
                                          result: result,
                                          context: context,
                                          successAction: () {
                                            Navigator.of(context).pushReplacementNamed('/start');
                                          },
                                          errorAction: () {});
                                    }),
                                AppButton(
                                    text: AppLocalizations.of(context).no,
                                    buttonColor: AppElements.simpleCard.color(),
                                    textColor: AppElements.basicText.color(),
                                    onPressed: () => Navigator.of(context).pop())
                              ],
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _settingsButton({IconData icon, String title, Function onTap}) {
    return GestureDetector(
      child: AppCard(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.all(15),
                child: Icon(
                  icon,
                  color: AppElements.basicText.color(),
                  size: 40,
                )),
            Text(
              title,
              style: TextStyle(color: AppElements.basicText.color(), fontSize: 20),
            ),
            Container(
                margin: EdgeInsets.all(15),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppElements.basicText.color(),
                  size: 25,
                ))
          ],
        ),
        color: AppElements.simpleCard.color(),
      ),
      onTap: onTap,
    );
  }
}
