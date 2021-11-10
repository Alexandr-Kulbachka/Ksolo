import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/app_color_scheme.dart';
import 'app_button.dart';

void fbAuthSuccessErrorMessage(
    {dynamic result,
    BuildContext context,
    String successText,
    Function successAction,
    Function errorAction,
    Function(BuildContext context) onPopAction}) {
  if (result is bool) {
    if (result) {
      if (successText != null) {
        showDialog(
            context: context,
            builder: (cxt) {
              if (successAction != null) {
                successAction();
              }
              return (AlertDialog(
                backgroundColor: AppElements.appbar.color(),
                title: Text(
                  successText,
                  style: TextStyle(
                    color: AppElements.basicText.color(),
                  ),
                ),
              ));
            }).whenComplete(() => Future.delayed(
            Duration(seconds: 1),
            onPopAction != null
                ? onPopAction
                : () {
                    Navigator.of(context, rootNavigator: true).pop(result);
                  }));
      } else {
        successAction();
      }
    } else {
      if (errorAction != null) {
        errorAction();
      }
    }
  } else if (result is FirebaseAuthException) {
    if (errorAction != null) {
      errorAction();
    }
    showDialog(
        context: context,
        builder: (cxt) {
          return AlertDialog(
            backgroundColor: AppElements.appbar.color(),
            title: Text(
              result.message,
              style: TextStyle(
                color: AppElements.basicText.color(),
              ),
            ),
            actions: [
              AppButton(
                  text: AppLocalizations.of(context).ok,
                  buttonColor: AppElements.simpleCard.color(),
                  textColor: AppElements.basicText.color(),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }
}
