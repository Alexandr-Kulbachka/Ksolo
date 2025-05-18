import 'package:flutter/material.dart';
import 'package:ksolo/l10n/all_locales.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app/services/locale_service.dart';
import '../../../app/services/app_color_service.dart';
import '../../../components/app_button.dart';
import '../../../components/app_card.dart';
import '../../../style/app_color_scheme.dart';

class AppLanguage extends StatefulWidget {
  AppLanguage({Key? key}) : super(key: key);

  @override
  _AppLanguageState createState() => _AppLanguageState();
}

class _AppLanguageState extends State<AppLanguage> {
  late Locale _currentLocale;
  late Locale _selectedLocale;

  late LocaleService _localeService;

  @override
  void initState() {
    _localeService = Provider.of<LocaleService>(context, listen: false);
    _currentLocale = _localeService.currentAppLocale;
    _selectedLocale = _localeService.currentAppLocale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColorService>(builder: (context, appColorService, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)?.appLanguageTitle ?? '',
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
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2, color: appColorService.currentAppColorScheme.mainColor)),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: AppLocales.allLocales.values.toList()[index] == _selectedLocale
                                ? const Icon(
                                    Icons.done_outline,
                                    color: Colors.green,
                                  )
                                : Container(),
                          ),
                        ),
                        Text(
                          AppLocales.names[AppLocales.allLocales.keys.toList()[index]]!,
                          style: TextStyle(
                            color: AppElements.basicText.color(),
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    color: AppElements.simpleCard.color(),
                  ),
                  onTap: () => setState(() {
                    _selectedLocale = AppLocales.allLocales.values.toList()[index];
                  }),
                );
              },
              itemCount: AppLocales.names.length,
            ),
            Positioned.fill(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: AppButton(
                margin: const EdgeInsets.only(bottom: 10),
                text: AppLocalizations.of(context)!.save,
                textSize: 20,
                onPressed: _selectedLocale != _currentLocale
                    ? () => setState(() {
                          _localeService.currentAppLocale = _selectedLocale;
                          Navigator.pop(context);
                        })
                    : null,
              ),
            ))
          ],
        ),
      );
    });
  }
}
