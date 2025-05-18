import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../firebase/firebase_auth.dart';

class AccountService extends ChangeNotifier {
  //FBAuth _fbAuth;
  late FlutterSecureStorage _secureStorage;

  late bool _isRememberMe;
  bool get rememberMe => _isRememberMe;

  String? _savedLogin;
  String? get savedLogin => _savedLogin;

  set rememberMe(bool flagValue) {
    _secureStorage.write(key: 'isRememberMeFlag', value: flagValue.toString());
    _isRememberMe = flagValue;
    if (!_isRememberMe) {
      _savedLogin = null;
      _secureStorage.delete(key: 'lgValue');
    }
    notifyListeners();
  }

  AccountService() {
    //_fbAuth = FBAuth.getInstance();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _secureStorage = const FlutterSecureStorage();
    try {
      _isRememberMe = await _secureStorage.read(key: 'isRememberMeFlag') == 'true';
      if (_isRememberMe) {
        _savedLogin = await _secureStorage.read(key: 'lgValue');
      }
    } catch (e) {
      rememberMe = false;
    }
    notifyListeners();
  }

  Future<dynamic> signInWithEmailAndPassword(
      {required String email, required String password, bool isAutomaticallyLogIn = false}) async {
    // var result = await _fbAuth.signInWithEmailAndPassword(email, password);
    // if (result is bool && result && !isAutomaticallyLogIn) {
    //   _secureStorage.write(key: 'lgValue', value: email);
    //   _secureStorage.write(key: 'psValue', value: password);
    // }
    // return result;
  }

  Future<dynamic> signInAutomatically() async {
    String? login = await _secureStorage.read(key: 'lgValue');
    String? password = await _secureStorage.read(key: 'psValue');

    if (login != null && login.isNotEmpty && password != null && password.isNotEmpty) {
      return signInWithEmailAndPassword(email: login, password: password, isAutomaticallyLogIn: true);
    }
    return false;
  }

  Future<dynamic> signOut() async {
    // var result = await _fbAuth.signOut();
    // if (result is bool && result) {
    //   _secureStorage.delete(key: 'psValue');
    //   if (!_isRememberMe) {
    //     _secureStorage.delete(key: 'lgValue');
    //     _savedLogin = null;
    //   }
    // }
    // return result;
  }
}
