import 'package:flutter/material.dart';
import 'package:lab_4/models/user.dart';

class ApplicationProvider extends ChangeNotifier {
  MyUser _user = MyUser("", "");

  MyUser get user => _user;

  set user(MyUser user) {
    _user = user;
    notifyListeners();
  }
}
