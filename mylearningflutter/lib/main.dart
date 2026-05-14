import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/landing_page.dart';
import 'pages/register_page.dart';
import 'pages/diet_page.dart';
import 'pages/expense_page.dart';
import 'pages/project_page.dart';
import 'pages/cash_page.dart';
import 'pages/journaling_page.dart';
import 'pages/income_page.dart';
import 'pages/accounting_page.dart';
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
        '/landing': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/diet': (context) => const DietPage(),
        '/expense': (context) => const ExpensePage(),
        '/projects': (context) => const ProjectPage(),
        '/cash': (context) => const CashPage(),
        '/journaling': (context) => const JournalingPage(),
        '/income': (context) => const IncomePage(),
        '/accounting': (context) => const AccountingPage(),
      },
      // ... Set initial route to landing page
      initialRoute: '/landing',
    );
  }
}

