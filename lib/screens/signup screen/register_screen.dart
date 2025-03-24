import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_mobile_developer_assessment/providers/auth_provider.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // Password
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            // Error message
            if (_errorMessage.isNotEmpty)
              Text(_errorMessage, style: TextStyle(color: Colors.red)),
            SizedBox(height: 16),

            // Register Button
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    child: Text('Register'),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = '';
                      });

                      bool success = await authProvider.register(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );

                      setState(() => _isLoading = false);

                      if (success) {
                        // Option: navigate back to login screen
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          _errorMessage = 'Registration failed.';
                        });
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
