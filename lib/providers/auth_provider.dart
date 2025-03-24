import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A provider class that handles user authentication and registration.
///
/// This class leverages [SharedPreferences] for local storage of user credentials and tokens.
/// It exposes methods for user registration, login, and logout, and notifies listeners when
/// authentication state changes.
class AuthProvider extends ChangeNotifier {
  // Private fields to manage authentication state.
  
  /// Indicates whether a user is currently logged in.
  bool _isLoggedIn = false;
  
  /// Stores the authentication token for the current session.
  String _token = '';
  
  /// The key used to store registered users in SharedPreferences.
  static const String registeredUsersKey = 'registered_users';

  // Public getters for accessing the private authentication fields.

  /// Returns `true` if a user is currently logged in.
  bool get isLoggedIn => _isLoggedIn;
  
  /// Returns the current session token.
  String get token => _token;

  /// Constructs an instance of [AuthProvider] and checks for an existing login session.
  AuthProvider() {
    _checkLoginStatus();
  }

  /// Checks if an authentication token is already saved when the app starts.
  ///
  /// If a non-empty token is found in [SharedPreferences], updates the internal state and
  /// notifies listeners about the login status.
  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedToken = prefs.getString('token');
    if (savedToken != null && savedToken.isNotEmpty) {
      _token = savedToken;
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  /// Registers a new user with the provided [email] and [password].
  ///
  /// This method saves the user's credentials to [SharedPreferences] as a JSON-encoded map.
  /// Returns `true` if registration is successful, or `false` if the email is already registered
  /// or if either field is empty.
  ///
  /// [email] - The email address of the user.
  /// [password] - The password for the user.
  Future<bool> register(String email, String password) async {
    // Return false if email or password is empty.
    if (email.isEmpty || password.isEmpty) return false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the registered users stored as JSON.
    String? usersJson = prefs.getString(registeredUsersKey);
    Map<String, dynamic> registeredUsers = usersJson != null
        ? json.decode(usersJson)
        : <String, dynamic>{};

    // Check if the email is already registered.
    if (registeredUsers.containsKey(email)) {
      return false;
    }

    // Add new user credentials to the map.
    registeredUsers[email] = password;
    // Save the updated user list back to SharedPreferences.
    await prefs.setString(registeredUsersKey, json.encode(registeredUsers));
    return true;
  }

  /// Logs in the user by validating the provided [email] and [password].
  ///
  /// The login is successful only if the user is registered and the provided password matches.
  /// On success, a fake token is generated and saved in [SharedPreferences], and authentication
  /// state is updated accordingly.
  ///
  /// [email] - The email address of the user.
  /// [password] - The password provided for authentication.
  ///
  /// Returns `true` if the login is successful; otherwise, returns `false`.
  Future<bool> login(String email, String password) async {
    // Return false if email or password is empty.
    if (email.isEmpty || password.isEmpty) return false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the registered users.
    String? usersJson = prefs.getString(registeredUsersKey);
    if (usersJson == null) return false; // No registered users yet.

    Map<String, dynamic> registeredUsers = json.decode(usersJson);

    // Check if the email exists and the password matches.
    if (registeredUsers.containsKey(email) && registeredUsers[email] == password) {
      // Simulate a successful login by generating a fake token.
      String fakeToken = 'fake_jwt_token';
      await prefs.setString('token', fakeToken);

      // Update the authentication state.
      _token = fakeToken;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }

    // Return false if credentials do not match.
    return false;
  }

  /// Logs out the current user.
  ///
  /// This method removes the stored token from [SharedPreferences] and updates the internal
  /// authentication state, notifying listeners of the change.
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}
