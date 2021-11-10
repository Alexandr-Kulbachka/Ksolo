import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app/services/account_service.dart';
import '../../../app/firebase/firebase_auth.dart';
import '../../../app/services/app_color_service.dart';
import '../../../components/app_button.dart';
import '../../../components/app_text_field.dart';
import '../../../components/circled_button.dart';
import '../../../components/fb_auth_success_error_message.dart';
import '../../../style/app_color_scheme.dart';

class AccountInfo extends StatefulWidget {
  bool editMode;
  AccountInfo({Key key, this.editMode = false}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  FBAuth _fbAuth;

  String _oldEmail;

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _newPasswordController;

  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _newPasswordFocusNode;

  bool _isEmailValid = true;
  bool _isPasswordValid = false;
  bool _isNewPasswordValid = false;

  bool _hasUppercase;
  bool _hasDigits;
  bool _hasLowercase;
  bool _hasSpecialCharacters;
  bool _hasMinLength;

  bool _isPasswordObscured = true;
  bool _isNewPasswordObscured = true;

  bool _isEmailShouldBeeEditable = true;
  bool _isNewPasswordShouldBeeVisible = true;

  RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _canSave = false;

  @override
  void initState() {
    _fbAuth = FBAuth.getInstance();
    _emailController = TextEditingController();
    _emailController.text = _fbAuth.currentUser.email;
    _oldEmail = _fbAuth.currentUser.email;
    _passwordController = TextEditingController();
    _newPasswordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _emailFocusNode.addListener(() {
      setState(() {});
    });

    _passwordFocusNode = FocusNode();
    _passwordFocusNode.addListener(() {
      setState(() {});
    });

    _newPasswordFocusNode = FocusNode();
    _newPasswordFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountService>(builder: (context, accountService, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).accountInfo,
            ),
            actions: [
              CircledButton(
                  size: 30,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  iconColor: AppElements.basicText.color(),
                  icon: widget.editMode ? Icons.edit_off : Icons.edit,
                  onPressed: () => setState(() {
                        _switchEditMode();
                      }))
            ],
          ),
          body: GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  children: [
                    _fields(),
                    if (widget.editMode && _isNewPasswordShouldBeeVisible) _passwordRequirements(),
                  ],
                ),
                if (widget.editMode)
                  Positioned(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AppButton(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        text: AppLocalizations.of(context).save,
                        textSize: 20,
                        height: 70,
                        width: 150,
                        onPressed: _canSave ? () => _saveChanges() : null),
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
        readOnly: !widget.editMode || !_isEmailShouldBeeEditable,
        padding: EdgeInsets.all(10),
        fieldController: _emailController,
        fieldFocusNode: _emailFocusNode,
        maxLines: 1,
        cursorColor: AppColorService.currentAppColorScheme.mainColor,
        labelText: AppLocalizations.of(context).email,
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
      if (!widget.editMode)
        Center(
          child: Text(
            AppLocalizations.of(context).switchToEditAccountInfoMode,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppElements.textOnBackground.color()),
          ),
        ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: AppTextField(
            readOnly: !widget.editMode,
            obscureText: _isPasswordObscured,
            autocorrect: false,
            enableSuggestions: false,
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            fieldController: _passwordController,
            fieldFocusNode: _passwordFocusNode,
            maxLines: 1,
            cursorColor: AppColorService.currentAppColorScheme.mainColor,
            labelText: AppLocalizations.of(context).password,
            labelColor: _passwordFocusNode.hasFocus || _passwordController.text.length > 0
                ? AppElements.textFieldEnabled.color()
                : AppElements.textFieldDisabled.color(),
            enabledBorderColor: AppElements.textFieldEnabled.color(),
            disabledBorderColor: _passwordController.text.length > 0
                ? AppElements.textFieldEnabled.color()
                : AppElements.textFieldDisabled.color(),
            errorText: _passwordController.text.isEmpty || _isPasswordValid
                ? null
                : AppLocalizations.of(context).invalidPassword,
            onChanged: (value) {
              setState(() {
                _isPasswordValid = _isPasswordCompliant(value);
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
      if (_isNewPasswordShouldBeeVisible)
        Row(
          children: [
            Flexible(
                child: AppTextField(
              readOnly: !widget.editMode,
              obscureText: _isNewPasswordObscured,
              autocorrect: false,
              enableSuggestions: false,
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              fieldController: _newPasswordController,
              fieldFocusNode: _newPasswordFocusNode,
              maxLines: 1,
              cursorColor: AppColorService.currentAppColorScheme.mainColor,
              labelText: AppLocalizations.of(context).newPassword,
              labelColor: _newPasswordFocusNode.hasFocus || _newPasswordController.text.length > 0
                  ? AppElements.textFieldEnabled.color()
                  : AppElements.textFieldDisabled.color(),
              enabledBorderColor: AppElements.textFieldEnabled.color(),
              disabledBorderColor: _newPasswordController.text.length > 0
                  ? AppElements.textFieldEnabled.color()
                  : AppElements.textFieldDisabled.color(),
              errorText: _isNewPasswordValid || _newPasswordController.text.isEmpty
                  ? null
                  : AppLocalizations.of(context).invalidPassword,
              onChanged: (value) {
                setState(() {
                  _isNewPasswordValid = _isPasswordCompliant(value);
                  checkFields();
                });
              },
            )),
            CircledButton(
                size: 40,
                icon: _isNewPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                iconColor: _newPasswordFocusNode.hasFocus || _newPasswordController.text.length > 0
                    ? AppElements.textFieldEnabled.color()
                    : AppElements.textFieldDisabled.color(),
                onPressed: () {
                  setState(() {
                    _isNewPasswordObscured = !_isNewPasswordObscured;
                  });
                }),
          ],
        )
    ]);
  }

  Widget _passwordRequirements() {
    return Container(
      margin: EdgeInsets.only(bottom: 75),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: _passwordRequirement(
              text: AppLocalizations.of(context).passwordRequirements,
              color: _newPasswordController.text.isEmpty ? Colors.grey : AppElements.textFieldEnabled.color(),
              size: 22),
        ),
        _passwordRequirement(
            text: AppLocalizations.of(context).uppercaseLetter,
            color: _newPasswordController.text.isEmpty
                ? Colors.grey
                : _hasUppercase
                    ? AppElements.textFieldEnabled.color()
                    : Colors.red),
        _passwordRequirement(
            text: AppLocalizations.of(context).lowercaseLetter,
            color: _newPasswordController.text.isEmpty
                ? Colors.grey
                : _hasLowercase
                    ? AppElements.textFieldEnabled.color()
                    : Colors.red),
        _passwordRequirement(
            text: AppLocalizations.of(context).numericCharacter,
            color: _newPasswordController.text.isEmpty
                ? Colors.grey
                : _hasDigits
                    ? AppElements.textFieldEnabled.color()
                    : Colors.red),
        _passwordRequirement(
            text: AppLocalizations.of(context).specialCharacter,
            color: _newPasswordController.text.isEmpty
                ? Colors.grey
                : _hasSpecialCharacters
                    ? AppElements.textFieldEnabled.color()
                    : Colors.red),
        _passwordRequirement(
            text: AppLocalizations.of(context).longerThan,
            color: _newPasswordController.text.isEmpty
                ? Colors.grey
                : _hasMinLength
                    ? AppElements.textFieldEnabled.color()
                    : Colors.red),
      ]),
    );
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
    _hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?"_:{}|<>+-]'));
    _hasMinLength = password.length > minLength;

    return _hasDigits & _hasUppercase & _hasLowercase & _hasSpecialCharacters & _hasMinLength;
  }

  void checkFields() {
    if (_passwordController.text.isNotEmpty &&
        (_isEmailValid && _emailController.text != _oldEmail ||
            _passwordController.text != _newPasswordController.text &&
                _newPasswordController.text.isNotEmpty &&
                _isNewPasswordValid)) {
      _canSave = true;
    } else {
      _canSave = false;
    }
    if (_emailController.text != _oldEmail) {
      _isNewPasswordShouldBeeVisible = false;
    } else {
      _isNewPasswordShouldBeeVisible = true;
    }
    if (_newPasswordController.text.isNotEmpty) {
      _isEmailShouldBeeEditable = false;
    } else {
      _isEmailShouldBeeEditable = true;
    }
  }

  void _saveChanges() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppElements.appbar.color(),
            title: Text(
              _isEmailShouldBeeEditable
                  ? AppLocalizations.of(context).changeEmailQuestion
                  : _isNewPasswordShouldBeeVisible
                      ? AppLocalizations.of(context).changePasswordQuestion
                      : '',
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
                    if (_isEmailShouldBeeEditable) {
                      await _fbAuth
                          .changeEmail(_oldEmail, _passwordController.text, _emailController.text)
                          .then((result) {
                        Navigator.of(context).pop();
                        fbAuthSuccessErrorMessage(
                            result: result,
                            context: context,
                            successText: AppLocalizations.of(context).emailSuccessfullyChanged,
                            successAction: () {
                              _oldEmail = _emailController.text;
                              _switchEditMode();
                            });
                      });
                    } else if (_isNewPasswordShouldBeeVisible) {
                      await _fbAuth
                          .changePassword(_oldEmail, _passwordController.text, _newPasswordController.text)
                          .then((result) {
                        Navigator.of(context).pop();
                        fbAuthSuccessErrorMessage(
                            result: result,
                            context: context,
                            successText: AppLocalizations.of(context).passwordSuccessfullyChanged,
                            successAction: () {
                              _switchEditMode();
                            });
                      });
                    }
                  }),
              AppButton(
                  text: AppLocalizations.of(context).no,
                  buttonColor: AppElements.simpleCard.color(),
                  textColor: AppElements.basicText.color(),
                  onPressed: () => Navigator.of(context).pop())
            ],
          );
        });
  }

  void _switchEditMode() {
    if (widget.editMode) {
      _isEmailShouldBeeEditable = true;
      _isNewPasswordShouldBeeVisible = true;
      _emailController.text = _oldEmail;
      _passwordController.text = '';
      _newPasswordController.text = '';
    }
    widget.editMode = !widget.editMode;
  }
}
