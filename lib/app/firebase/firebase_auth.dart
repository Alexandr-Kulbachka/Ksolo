import 'package:firebase_auth/firebase_auth.dart';

class FBAuth {
  FirebaseAuth _auth;
  User _currentUser;

  FBAuth._constructor() {
    _auth = FirebaseAuth.instance;
  }

  static FBAuth _instance;

  static FBAuth getInstance() {
    if (_instance == null) {
      _instance = FBAuth._constructor();
    }
    return _instance;
  }

  Future<dynamic> register(String email, String password) async {
    try {
      _currentUser = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
    } catch (exception) {
      return exception;
    }
    return _currentUser;
  }

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      _currentUser = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
    } catch (exception) {
      return exception;
    }
    return _currentUser;
  }
}
