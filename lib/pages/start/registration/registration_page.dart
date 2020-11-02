import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _confirmPasswordFocusNode;

  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _canSave = false;

  @override
  void initState() {
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
                  children: [
                    AppTextField(
                      padding: EdgeInsets.all(10),
                      fieldController: _emailController,
                      fieldFocusNode: _emailFocusNode,
                      maxLines: 1,
                      cursorColor:
                          AppColorService.currentAppColorScheme.mainColor,
                      labelText: "Input email",
                      labelColor: _emailFocusNode.hasFocus ||
                              _emailController.text.length > 0
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
                        if (_emailRegExp.hasMatch(value)) {
                          _isEmailValid = true;
                        } else {
                          _isEmailValid = false;
                        }
                        setState(() {
                          checkFields();
                        });
                      },
                    ),
                    AppTextField(
                      padding: EdgeInsets.all(10),
                      fieldController: _passwordController,
                      fieldFocusNode: _passwordFocusNode,
                      maxLines: 1,
                      cursorColor:
                          AppColorService.currentAppColorScheme.mainColor,
                      labelText: "Input password",
                      labelColor: _passwordFocusNode.hasFocus ||
                              _passwordController.text.length > 0
                          ? AppElements.textFieldEnabled.color()
                          : AppElements.textFieldDisabled.color(),
                      enabledBorderColor: AppElements.textFieldEnabled.color(),
                      disabledBorderColor: _passwordController.text.length > 0
                          ? AppElements.textFieldEnabled.color()
                          : AppElements.textFieldDisabled.color(),
                      errorText:
                          _isPasswordValid || _passwordController.text.isEmpty
                              ? null
                              : "Invalid password",
                      onChanged: (value) {
                        _isPasswordValid = _isPasswordCompliant(value);
                        _isPasswordsMatched();
                        setState(() {
                          checkFields();
                        });
                      },
                    ),
                    AppTextField(
                      padding: EdgeInsets.all(10),
                      fieldController: _confirmPasswordController,
                      fieldFocusNode: _confirmPasswordFocusNode,
                      maxLines: 1,
                      cursorColor:
                          AppColorService.currentAppColorScheme.mainColor,
                      labelText: "Confirm password",
                      labelColor: _confirmPasswordFocusNode.hasFocus ||
                              _confirmPasswordController.text.length > 0
                          ? AppElements.textFieldEnabled.color()
                          : AppElements.textFieldDisabled.color(),
                      enabledBorderColor: AppElements.textFieldEnabled.color(),
                      disabledBorderColor:
                          _confirmPasswordController.text.length > 0
                              ? AppElements.textFieldEnabled.color()
                              : AppElements.textFieldDisabled.color(),
                      errorText: _isConfirmPasswordValid ||
                              _confirmPasswordController.text.isEmpty
                          ? null
                          : "Invalid password",
                      onChanged: (value) {
                        _isConfirmPasswordValid = _isPasswordCompliant(value);
                        _isPasswordsMatched();
                        setState(() {
                          checkFields();
                        });
                      },
                    ),
                  ],
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
                      onPressed: () {
                        if (_canSave) {
                          setState(() {
                            Navigator.of(context).pushNamed('/home');
                          });
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

  bool _isPasswordCompliant(String password, [int minLength = 6]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?"_:{}|<>+-]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
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
