import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_mobile_developer_assessment/screens/Item%20screen/item_detail_screen.dart';
import 'package:training_mobile_developer_assessment/screens/home%20screen/home_screen.dart';
import 'package:training_mobile_developer_assessment/screens/login%20screen/login_screen.dart';
import 'package:training_mobile_developer_assessment/screens/signup%20screen/register_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/item_provider.dart';

/// The entry point of the Mobile Developer Assessment application.
///
/// This file initializes the Flutter application by setting up necessary providers
/// and configuring the app's theme, home screen, and named routes.
void main() {
  runApp(
    MultiProvider(
      // Registering multiple providers to manage state across the application.
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ItemProvider()),
      ],
      // The root widget of the application.
      child: MyApp(),
    ),
  );
}

/// The root widget of the application.
///
/// [MyApp] is a stateless widget that sets up the MaterialApp configuration,
/// including theme data, initial route based on authentication status, and named routes.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the authentication provider to determine the initial screen.
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      title: 'Mobile Dev Assessment',
      debugShowCheckedModeBanner: false, // Removes the debug banner from the UI.
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the initial screen based on the user's authentication status.
      home: authProvider.isLoggedIn ? HomeScreen() : LoginScreen(),
      // Define named routes for navigation throughout the application.
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/detail': (context) => ItemDetailScreen(),
      },
    );
  }
}
