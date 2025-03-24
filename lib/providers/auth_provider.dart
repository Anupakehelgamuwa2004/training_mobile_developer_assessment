import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _token = '';
  static const String registeredUsersKey = 'registered_users';

  bool get isLoggedIn => _isLoggedIn;
  String get token => _token;

  AuthProvider() {
    _checkLoginStatus();
  }

  // Check if a token is already saved when the app starts
  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedToken = prefs.getString('token');
    if (savedToken != null && savedToken.isNotEmpty) {
      _token = savedToken;
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  // Register a new user. Returns false if the email is already registered.
  Future<bool> register(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the registered users (stored as JSON)
    String? usersJson = prefs.getString(registeredUsersKey);
    Map<String, dynamic> registeredUsers = usersJson != null
        ? json.decode(usersJson)
        : <String, dynamic>{};

    // Check if the email is already registered
    if (registeredUsers.containsKey(email)) {
      return false;
    }

    // Add new user to the map
    registeredUsers[email] = password;
    await prefs.setString(registeredUsersKey, json.encode(registeredUsers));
    return true;
  }

  // Login the user only if they've been previously registered and the password matches
  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the registered users
    String? usersJson = prefs.getString(registeredUsersKey);
    if (usersJson == null) return false; // No registered users yet

    Map<String, dynamic> registeredUsers = json.decode(usersJson);

    // Check if the email exists and the password matches
    if (registeredUsers.containsKey(email) && registeredUsers[email] == password) {
      // Simulate a successful login by generating a fake token
      String fakeToken = 'fake_jwt_token';
      await prefs.setString('token', fakeToken);

      _token = fakeToken;
      _isLoggedIn = true;
      notifyListeners();
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
