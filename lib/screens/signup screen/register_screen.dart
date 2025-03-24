import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_mobile_developer_assessment/providers/auth_provider.dart';

/// A screen that allows users to create a new account.
///
/// The [RegisterScreen] provides a form for users to register by entering
/// an email address and a password. The form validates user inputs, displays
/// error messages when necessary, and utilizes [AuthProvider] to handle the
/// registration process. On successful registration, the user is navigated
/// back to the previous screen.
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

/// The state class for [RegisterScreen] that manages form validation, user input,
/// loading state, and error messages during the registration process.
class _RegisterScreenState extends State<RegisterScreen> {
  /// A global key used to uniquely identify the form and enable form validation.
  final _formKey = GlobalKey<FormState>();

  /// Controller for the email input field.
  final _emailController = TextEditingController();

  /// Controller for the password input field.
  final _passwordController = TextEditingController();

  /// Indicates whether the registration process is currently in progress.
  bool _isLoading = false;

  /// Stores any error message to be displayed if registration fails.
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    // Retrieve the AuthProvider to handle registration logic.
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      // The background uses a purple gradient for a vibrant look.
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade400, Colors.purple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          // SingleChildScrollView allows the form to be scrollable on smaller screens.
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              // Elevated card for a material look with a rounded shape.
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    // Use min main axis size to fit the content.
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Screen title indicating the registration process.
                      Text(
                        'Create Account',
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
                        obscureText: true,
                        // Validate that the password field is not empty and meets minimum length.
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.trim().length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Display error message if registration fails.
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      SizedBox(height: 16),
                      // Show a loading indicator while the registration is in progress.
                      _isLoading
                          ? CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                // Handle the registration process when the button is pressed.
                                onPressed: () async {
                                  // Validate the form before processing registration.
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                      _errorMessage = '';
                                    });
                                    // Attempt to register with the provided email and password.
                                    bool success = await authProvider.register(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                    setState(() => _isLoading = false);
                                    if (success) {
                                      // If registration is successful, navigate back.
                                      Navigator.pop(context);
                                    } else {
                                      // Otherwise, display an error message.
                                      setState(() {
                                        _errorMessage = 'Registration failed or email already exists';
                                      });
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 16),
                      // Link to navigate back to the login screen if the user already has an account.
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Already have an account? Login",
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
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
