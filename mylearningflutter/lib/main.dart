import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'config/api_config.dart';

/// ... Entry point of the application
/// 
/// Initializes the MyApp widget which sets up
/// the material design theme and navigation routes
void main() => runApp(const MyApp());

/// ... Root widget of the application
/// 
/// Configures the MaterialApp with:
/// - Theme using Material 3 with blue color scheme
/// - Named routes for navigation
/// - Login page as initial route
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Learning Flutter',
      // ... Configure theme with Material 3 design
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      // ... Define named routes for navigation
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
      // ... Set initial route to login page
      initialRoute: '/login',
    );
  }
}

