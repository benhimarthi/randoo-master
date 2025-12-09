import 'package:flutter/material.dart';
import 'package:myapp/features/auth/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}
