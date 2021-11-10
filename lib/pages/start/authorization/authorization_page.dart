import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app/services/account_service.dart';
import '../../../components/fb_auth_success_error_message.dart';
import '../../../app/services/app_color_service.dart';
import '../../../components/app_button.dart';
import '../../../components/app_text_field.dart';
import '../../../components/circled_button.dart';
import '../../../style/app_color_scheme.dart';

class Authorization extends StatefulWidget {
  Authorization({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;

  bool _isEmailValid = false;
  bool _isPasswordValid = true;

  bool _isPasswordObscured = true;

  RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _allFieldsFilled = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _emailFocusNode.addListener(() {
      setState(() {});
    });

    _passwordFocusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppColorService, AccountService>(builder: (context, appColorService, accountService, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).authorization),
          ),
          body: GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  children: [_fields(accountService)],
                ),
                Positioned(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AppButton(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      text: AppLocalizations.of(context).signIn,
                      textSize: 20,
                      height: 70,
                      width: 150,
                      onPressed: _allFieldsFilled
                          ? () async {
                              var result = await accountService.signInWithEmailAndPassword(
                                  email: _emailController.text, password: _passwordController.text);
                              fbAuthSuccessErrorMessage(
                                  result: result,
                                  context: context,
                                  successAction: () {
                                    Navigator.of(context).pushReplacementNamed('/main');
                                  },
                                  errorAction: () => _handleErrors(result.code));
                            }
                          : null),
                ))
              ],
            ),
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
          ));
    });
  }

  void _handleErrors(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        setState(() {
          _isEmailValid = false;
        });
        break;
      case 'wrong-password':
        setState(() {
          _isPasswordValid = false;
        });
        break;
    }
  }

  Widget _fields(AccountService accountService) {
    return Container(
      margin: EdgeInsets.only(bottom: 80),
      child: Column(children: [
        AppTextField(
          padding: EdgeInsets.all(10),
          fieldController: _emailController,
          fieldFocusNode: _emailFocusNode,
          maxLines: 1,
          cursorColor: AppColorService.currentAppColorScheme.mainColor,
          labelText: AppLocalizations.of(context).inputEmail,
          labelColor: _emailFocusNode.hasFocus || _emailController.text.length > 0
              ? AppElements.textFieldEnabled.color()
              : AppElements.textFieldDisabled.color(),
          enabledBorderColor: AppElements.textFieldEnabled.color(),
          disabledBorderColor: _emailController.text.length > 0
              ? AppElements.textFieldEnabled.color()
              : AppElements.textFieldDisabled.color(),
          errorText: _isEmailValid || _emailController.text.isEmpty ? null : AppLocalizations.of(context).invalidEmail,
          onChanged: (value) {
            setState(() {
              if (_emailRegExp.hasMatch(value)) {
                _isEmailValid = true;
              } else {
                _isEmailValid = false;
              }
              checkFields();
            });
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                child: AppTextField(
              obscureText: _isPasswordObscured,
              autocorrect: false,
              enableSuggestions: false,
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              fieldController: _passwordController,
              fieldFocusNode: _passwordFocusNode,
              maxLines: 1,
              cursorColor: AppColorService.currentAppColorScheme.mainColor,
              labelText: AppLocalizations.of(context).inputPassword,
              labelColor: _passwordFocusNode.hasFocus || _passwordController.text.length > 0
                  ? AppElements.textFieldEnabled.color()
                  : AppElements.textFieldDisabled.color(),
              enabledBorderColor: AppElements.textFieldEnabled.color(),
              disabledBorderColor: _passwordController.text.length > 0
                  ? AppElements.textFieldEnabled.color()
                  : AppElements.textFieldDisabled.color(),
              errorText: _isPasswordValid ? null : AppLocalizations.of(context).invalidPassword,
              onChanged: (value) {
                setState(() {
                  checkFields();
                });
              },
            )),
            CircledButton(
                size: 40,
                icon: _isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                iconColor: _passwordFocusNode.hasFocus || _passwordController.text.length > 0
                    ? AppElements.textFieldEnabled.color()
                    : AppElements.textFieldDisabled.color(),
                onPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                })
          ],
        ),
        if (accountService.isRememberMe != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: accountService.isRememberMe
                        ? AppElements.textFieldEnabled.color()
                        : AppElements.textFieldDisabled.color(),
                    width: 2,
                  )),
                  child: accountService.isRememberMe
                      ? Icon(
                          Icons.done,
                          color: AppElements.textFieldEnabled.color(),
                        )
                      : Container(),
                ),
                onTap: () {
                  accountService.isRememberMe = !accountService.isRememberMe;
                },
              ),
              Text(
                AppLocalizations.of(context).rememberMe,
                style: TextStyle(
                  fontSize: 18,
                  color: accountService.isRememberMe
                      ? AppElements.textFieldEnabled.color()
                      : AppElements.textFieldDisabled.color(),
                ),
              ),
            ],
          )
      ]),
    );
  }

  void checkFields() {
    _isPasswordValid = true;
    if (_isEmailValid && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      _allFieldsFilled = true;
    } else {
      _allFieldsFilled = false;
    }
  }
}
