import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../firebase/firebase_auth.dart';

class AccountService extends ChangeNotifier {
  FBAuth _fbAuth;
  FlutterSecureStorage _secureStorage;
  bool _isRememberMe;

  bool get isRememberMe => _isRememberMe;

  set isRememberMe(bool flagValue) {
    _secureStorage.write(key: 'isRememberMeFlag', value: flagValue.toString());
    _isRememberMe = flagValue;
    notifyListeners();
  }

  AccountService() {
    _fbAuth = FBAuth.getInstance();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _secureStorage = FlutterSecureStorage();
    try {
      _isRememberMe = await _secureStorage.read(key: 'isRememberMeFlag') == 'true';
    } catch (e) {
      isRememberMe = false;
    }
    notifyListeners();
  }

  Future<dynamic> signInWithEmailAndPassword({String email, String password, bool isAutomaticallyLogIn = false}) async {
    var result = await _fbAuth.signInWithEmailAndPassword(email, password);
    if (result is bool && result && !isAutomaticallyLogIn) {
      if (_isRememberMe) {
        _secureStorage.write(key: 'loginValue', value: email);
        _secureStorage.write(key: 'passwordValue', value: password);
      } else {
        _secureStorage.delete(key: 'loginValue');
        _secureStorage.delete(key: 'passwordValue');
      }
    }
    return result;
  }

  Future<dynamic> signInAutomatically() async {
    String login = await _secureStorage.read(key: 'loginValue');
    String password = await _secureStorage.read(key: 'passwordValue');

    if (login != null && login.isNotEmpty && password != null && password.isNotEmpty) {
      return signInWithEmailAndPassword(email: login, password: password, isAutomaticallyLogIn: true);
    }
    return false;
  }

  Future<dynamic> signOut() async {
    var result = await _fbAuth.signOut();
    if (result is bool && result) {
      _secureStorage.delete(key: 'passwordValue');
    }
    return result;
  }
}
