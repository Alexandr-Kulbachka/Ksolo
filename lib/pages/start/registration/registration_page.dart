import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/firebase/firebase_auth.dart';
import '../../../components/circled_button.dart';
import '../../../app/services/app_color_service.dart';
import '../../../components/app_button.dart';
import '../../../components/app_text_field.dart';
import '../../../enums/app_elements.dart';
import '../../../style/app_color_scheme.dart';

class Registration extends StatefulWidget {
  Registration({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  FBAuth _fbAuth;

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _confirmPasswordFocusNode;

  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  bool _hasUppercase;
  bool _hasDigits;
  bool _hasLowercase;
  bool _hasSpecialCharacters;
  bool _hasMinLength;

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _canSave = false;

  @override
  void initState() {
    _fbAuth = FBAuth.getInstance();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _emailFocusNode.addListener(() {
      setState(() {});
    });

    _passwordFocusNode = FocusNode();
    _passwordFocusNode.addListener(() {
      setState(() {});
    });

    _confirmPasswordFocusNode = FocusNode();
    _confirmPasswordFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColorService>(
        builder: (context, appColorService, child) {
      return Scaffold(
          backgroundColor: AppElements.background.color(),
          appBar: AppBar(
            backgroundColor: AppElements.appbar.color(),
            title: Text('Registration'),
          ),
          body: GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  children: [_fields(), _passwordRequirements()],
                ),
                Positioned(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AppButton(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      text: 'SAVE',
                      textSize: 20,
                      textColor: AppElements.basicText.color(),
                      buttonColor: _canSave
                          ? AppElements.enabledButton.color()
                          : AppElements.disabledButton.color(),
                      maxHeight: 70,
                      maxWidth: 150,
                      onPressed: () async {
                        if (_canSave) {
                          var result = await _fbAuth.register(
                              _emailController.text, _passwordController.text);
                          if (result is User) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/home');
                                  });
                                  return AlertDialog(
                                    backgroundColor: AppElements.appbar.color(),
                                    title: Text(
                                      'Account successfully created!',
                                      style: TextStyle(
                                        color: AppElements.basicText.color(),
                                      ),
                                    ),
                                  );
                                });
                          } else if (result is FirebaseAuthException) {
                            if (result.code == 'email-already-in-use') {
                              setState(() {
                                _isEmailValid = false;
                              });
                            }
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
            errorText: _isPasswordValid || _passwordController.text.isEmpty
                ? null
                : "Invalid password",
            onChanged: (value) {
              setState(() {
                _isPasswordValid = _isPasswordCompliant(value);
                _isPasswordsMatched();
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
      Row(
        children: [
          Flexible(
              child: AppTextField(
            obscureText: _isConfirmPasswordObscured,
            autocorrect: false,
            enableSuggestions: false,
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            fieldController: _confirmPasswordController,
            fieldFocusNode: _confirmPasswordFocusNode,
            maxLines: 1,
            cursorColor: AppColorService.currentAppColorScheme.mainColor,
            labelText: "Confirm password",
            labelColor: _confirmPasswordFocusNode.hasFocus ||
                    _confirmPasswordController.text.length > 0
                ? AppElements.textFieldEnabled.color()
                : AppElements.textFieldDisabled.color(),
            enabledBorderColor: AppElements.textFieldEnabled.color(),
            disabledBorderColor: _confirmPasswordController.text.length > 0
                ? AppElements.textFieldEnabled.color()
                : AppElements.textFieldDisabled.color(),
            errorText: _isConfirmPasswordValid ||
                    _confirmPasswordController.text.isEmpty
                ? null
                : "Invalid password",
            onChanged: (value) {
              setState(() {
                _isPasswordsMatched();
                checkFields();
              });
            },
          )),
          CircledButton(
              size: 40,
              icon: _isConfirmPasswordObscured
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              iconColor: _confirmPasswordFocusNode.hasFocus ||
                      _confirmPasswordController.text.length > 0
                  ? AppElements.textFieldEnabled.color()
                  : AppElements.textFieldDisabled.color(),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                });
              }),
        ],
      )
    ]);
  }

  Widget _passwordRequirements() {
    return Column(children: [
      _passwordRequirement(
          text: 'Password Requirements:',
          color: _passwordController.text.isEmpty
              ? Colors.grey
              : AppElements.appbar.color(),
          size: 20),
      _passwordRequirement(
          text: 'Uppercase letter(s)',
          color: _passwordController.text.isEmpty
              ? Colors.grey
              : _hasUppercase
                  ? AppElements.appbar.color()
                  : Colors.red),
      _passwordRequirement(
          text: 'Lowercase letter(s)',
          color: _passwordController.text.isEmpty
              ? Colors.grey
              : _hasLowercase
                  ? AppElements.appbar.color()
                  : Colors.red),
      _passwordRequirement(
          text: 'Numeric character(s)',
          color: _passwordController.text.isEmpty
              ? Colors.grey
              : _hasDigits
                  ? AppElements.appbar.color()
                  : Colors.red),
      _passwordRequirement(
          text: 'Special character(s)',
          color: _passwordController.text.isEmpty
              ? Colors.grey
              : _hasSpecialCharacters
                  ? AppElements.appbar.color()
                  : Colors.red),
      _passwordRequirement(
          text: 'Longer than 8 characters',
          color: _passwordController.text.isEmpty
              ? Colors.grey
              : _hasMinLength
                  ? AppElements.appbar.color()
                  : Colors.red),
    ]);
  }

  Widget _passwordRequirement({String text, Color color, double size}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: size ?? 18,
        ),
      ),
    );
  }

  bool _isPasswordCompliant(String password, [int minLength = 8]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    _hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    _hasDigits = password.contains(new RegExp(r'[0-9]'));
    _hasLowercase = password.contains(new RegExp(r'[a-z]'));
    _hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?"_:{}|<>+-]'));
    _hasMinLength = password.length > minLength;

    return _hasDigits &
        _hasUppercase &
        _hasLowercase &
        _hasSpecialCharacters &
        _hasMinLength;
  }

  void _isPasswordsMatched() {
    _isConfirmPasswordValid = _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _passwordController.text == _confirmPasswordController.text;
  }

  void checkFields() {
    if (_isEmailValid &&
        _isPasswordValid &&
        _isConfirmPasswordValid &&
        _passwordController.text == _confirmPasswordController.text) {
      _canSave = true;
    } else {
      _canSave = false;
    }
  }
}
