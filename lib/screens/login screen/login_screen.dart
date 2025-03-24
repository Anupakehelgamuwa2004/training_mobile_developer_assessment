import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_mobile_developer_assessment/providers/auth_provider.dart';

/// A login screen that allows users to authenticate with their email and password.
///
/// The [LoginScreen] presents a form with input fields for the user's email and password.
/// It validates the inputs, displays any error messages, and triggers authentication using
/// [AuthProvider]. Upon successful login, the user is navigated to the home screen.
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

/// The state class for [LoginScreen] that manages form validation, loading state,
/// and error messages during the login process.
class _LoginScreenState extends State<LoginScreen> {
  /// A global key that uniquely identifies the form and allows validation.
  final _formKey = GlobalKey<FormState>();

  /// Controller for the email text field.
  final _emailController = TextEditingController();

  /// Controller for the password text field.
  final _passwordController = TextEditingController();

  /// Boolean to track if the login process is currently in progress.
  bool _isLoading = false;

  /// Stores any error message to be displayed if login fails.
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    // Retrieve the authentication provider instance.
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      // The login screen uses a full-screen container with a gradient background.
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // Center the content vertically and horizontally.
        child: Center(
          child: SingleChildScrollView(
            // Horizontal padding for the content.
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              // Elevation and shape give the card a distinct, elevated look.
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              // Padding inside the card to space out its contents.
              child: Padding(
                padding: EdgeInsets.all(24),
                // The Form widget contains all input fields and buttons.
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Screen title greeting the user.
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Email input field.
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        // Validate that the email field is not empty.
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Password input field.
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        // Hide the text for security.
                        obscureText: true,
                        // Validate that the password field is not empty.
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Display an error message if one exists.
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      SizedBox(height: 16),
                      // Show a loading indicator during the login process.
                      _isLoading
                          ? CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                // Handle the login button press.
                                onPressed: () async {
                                  // Validate the form fields.
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                      _errorMessage = '';
                                    });
                                    // Attempt login with the provided credentials.
                                    bool success = await authProvider.login(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                    setState(() => _isLoading = false);
                                    if (success) {
                                      // Navigate to home if login is successful.
                                      Navigator.pushReplacementNamed(context, '/home');
                                    } else {
                                      // Display an error message if login fails.
                                      setState(() {
                                        _errorMessage = 'Invalid credentials';
                                      });
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 16),
                      // Navigation link for users who need to register an account.
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          "Don't have an account? Register",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
