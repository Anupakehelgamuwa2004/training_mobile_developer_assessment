import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_mobile_developer_assessment/screens/Item%20screen/item_detail_screen.dart';
import 'package:training_mobile_developer_assessment/screens/home%20screen/home_screen.dart';
import 'package:training_mobile_developer_assessment/screens/login%20screen/login_screen.dart';
import 'package:training_mobile_developer_assessment/screens/signup%20screen/register_screen.dart';


import 'providers/auth_provider.dart';
import 'providers/item_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ItemProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      title: 'Mobile Dev Assessment',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Check if user is already logged in
      home: authProvider.isLoggedIn ? HomeScreen() : LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/detail': (context) => ItemDetailScreen(),
      },
    );
  }
}
