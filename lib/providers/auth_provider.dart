import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String _userName = '';
  String get userName => _userName;

  void login(String name) {
    _isLoggedIn = true;
    _userName = name;
    notifyListeners();
  }

  void loginAsGuest() {
    _isLoggedIn = true;
    _userName = 'Invitado';
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userName = '';
    notifyListeners();
  }
}
