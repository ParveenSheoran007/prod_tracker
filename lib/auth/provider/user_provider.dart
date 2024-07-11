import 'package:flutter/material.dart';
import 'package:prod_tracker/auth/model/user_model.dart';
import 'package:prod_tracker/auth/service/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  UserModel? _user;
  bool _isLoggedIn = false;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  Future<void> register(UserModel user, String email, String password) async {
    _setLoading(true);
    bool success = await _userService.register(user, email, password);
    if (success) {
      _user = user;
      _isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception('Registration failed');
    }
    _setLoading(false);
  }

  Future<bool> login(UserModel user) async {
    _setLoading(true);
    bool success = await _userService.login(user);
    if (success) {
      _user = user;
      _isLoggedIn = true;
      notifyListeners();
    }
    _setLoading(false);
    return success;
  }

  void logout() {
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
