import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _token = '';

  bool get isLoggedIn => _isLoggedIn;
  String get token => _token;

  AuthProvider() {
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedToken = prefs.getString('token');
    if (savedToken != null && savedToken.isNotEmpty) {
      _token = savedToken;
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    // Mock API call or Firebase Auth
    // For example, success if both are non-empty:
    if (email.isNotEmpty && password.isNotEmpty) {
      // Save token (mock data)
      String token = 'fake_jwt_token_123';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      _token = token;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String email, String password) async {
    // Mock registration logic
    if (email.isNotEmpty && password.isNotEmpty) {
      // On successful registration, auto-login or direct user to login
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}
