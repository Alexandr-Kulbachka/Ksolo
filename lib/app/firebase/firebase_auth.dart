import 'package:firebase_auth/firebase_auth.dart';

class FBAuth {
  FirebaseAuth _auth;

  User get currentUser => _auth.currentUser;

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
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (exception) {
      return exception;
    }
    return true;
  }

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (exception) {
      return exception;
    }
    return true;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<dynamic> changeEmail(
      String oldEmail, String password, String newEmail) async {
    try {
      await _auth.currentUser
          .reauthenticateWithCredential(
              EmailAuthProvider.credential(email: oldEmail, password: password))
          .then((value) async {
        await _auth.currentUser.updateEmail(newEmail);
      });
    } catch (exception) {
      return exception;
    }
    return true;
  }

  Future<dynamic> changePassword(
      String oldEmail, String password, String newPassword) async {
    try {
      await _auth.currentUser
          .reauthenticateWithCredential(
              EmailAuthProvider.credential(email: oldEmail, password: password))
          .then((value) async {
        await _auth.currentUser.updatePassword(newPassword);
      });
    } catch (exception) {
      return exception;
    }
    return true;
  }
}
