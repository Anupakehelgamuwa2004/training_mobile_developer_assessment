import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_mobile_developer_assessment/providers/auth_provider.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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

            // Login Button
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    child: Text('Login'),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = '';
                      });

                      bool success = await authProvider.login(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );

                      setState(() => _isLoading = false);

                      if (success) {
                        // Navigate to Home
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        setState(() {
                          _errorMessage = 'Invalid credentials';
                        });
                      }
                    },
                  ),

            // Navigate to Register
            TextButton(
              child: Text('Don\'t have an account? Register'),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            )
          ],
        ),
      ),
    );
  }
}
