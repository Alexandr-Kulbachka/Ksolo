import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/firebase/firebase_auth.dart';
import '../../../app/services/app_color_service.dart';
import '../../../components/app_button.dart';
import '../../../components/app_text_field.dart';
import '../../../components/circled_button.dart';
import '../../../enums/app_elements.dart';
import '../../../style/app_color_scheme.dart';

class Authorization extends StatefulWidget {
  Authorization({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  FBAuth _fbAuth;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;

  bool _isEmailValid = false;
  bool _isPasswordValid = true;

  bool _isPasswordObscured = true;

  RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _allFieldsFilled = false;

  @override
  void initState() {
    _fbAuth = FBAuth.getInstance();

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
    return Consumer<AppColorService>(
        builder: (context, appColorService, child) {
      return Scaffold(
          backgroundColor: AppElements.background.color(),
          appBar: AppBar(
            backgroundColor: AppElements.appbar.color(),
            title: Text('Authorization'),
          ),
          body: GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: [
                _fields(),
                Positioned(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AppButton(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      text: 'SIGN IN',
                      textSize: 20,
                      textColor: AppElements.basicText.color(),
                      buttonColor: _allFieldsFilled
                          ? AppElements.enabledButton.color()
                          : AppElements.disabledButton.color(),
                      maxHeight: 70,
                      maxWidth: 150,
                      onPressed: () async {
                        if (_allFieldsFilled) {
                          var result = await _fbAuth.signInWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                          if (result is User) {
                            Navigator.of(context).pushReplacementNamed('/main');
                          } else if (result is FirebaseAuthException) {
                            _handleErrors(result.code);
                            showDialog(
                                context: context,
                                builder: (context) {
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
                                          size: 50,
                                          text: 'OK',
                                          textColor:
                                              AppElements.basicText.color(),
                                          onPressed: () =>
                                              Navigator.of(context).pop())
                                    ],
                                  );
                                });
                          }
                        }
                      }),
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

  Widget _fields() {
    return Column(children: [
      AppTextField(
        padding: EdgeInsets.all(10),
        fieldController: _emailController,
        fieldFocusNode: _emailFocusNode,
        maxLines: 1,
        cursorColor: AppColorService.currentAppColorScheme.mainColor,
        labelText: "Input email",
        labelColor: _emailFocusNode.hasFocus || _emailController.text.length > 0
            ? AppElements.textFieldEnabled.color()
            : AppElements.textFieldDisabled.color(),
        enabledBorderColor: AppElements.textFieldEnabled.color(),
        disabledBorderColor: _emailController.text.length > 0
            ? AppElements.textFieldEnabled.color()
            : AppElements.textFieldDisabled.color(),
        errorText: _isEmailValid || _emailController.text.isEmpty
            ? null
            : "Invalid email",
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
            labelText: "Input password",
            labelColor: _passwordFocusNode.hasFocus ||
                    _passwordController.text.length > 0
                ? AppElements.textFieldEnabled.color()
                : AppElements.textFieldDisabled.color(),
            enabledBorderColor: AppElements.textFieldEnabled.color(),
            disabledBorderColor: _passwordController.text.length > 0
                ? AppElements.textFieldEnabled.color()
                : AppElements.textFieldDisabled.color(),
            errorText: _isPasswordValid ? null : "Invalid password",
            onChanged: (value) {
              setState(() {
                checkFields();
              });
            },
          )),
          CircledButton(
              size: 40,
              icon: _isPasswordObscured
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              iconColor: _passwordFocusNode.hasFocus ||
                      _passwordController.text.length > 0
                  ? AppElements.textFieldEnabled.color()
                  : AppElements.textFieldDisabled.color(),
              onPressed: () {
                setState(() {
                  _isPasswordObscured = !_isPasswordObscured;
                });
              })
        ],
      ),
    ]);
  }

  void checkFields() {
    _isPasswordValid = true;
    if (_isEmailValid &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _allFieldsFilled = true;
    } else {
      _allFieldsFilled = false;
    }
  }
}
