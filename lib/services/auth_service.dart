import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_4/models/user.dart';

class AuthServiceProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _user;
  get user => _user;

  MyUser _userFromFirebase(User? user) {
    return MyUser(user?.uid ?? "", user?.email ?? "");
  }

  Future<MyUser?> signInAnno() async {
    try {
      var result = await _auth.signInAnonymously();
      if (result.user != null) {
        _user = _userFromFirebase(result.user);
        notifyListeners();
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> signout() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
