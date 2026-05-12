import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

/// Login and Registration Page
/// 
/// This widget handles both login and registration functionality.
/// Users can toggle between the two modes using the text button at the bottom.
/// 
/// Features:
/// - ... Toggle between login and register modes
/// - ... Validate and submit user credentials
/// - ... Display loading indicators during API calls
/// - ... Show error/success messages via SnackBar
/// - ... Navigate to home page on successful login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ... Toggle between Login and Register modes
  bool _isLogin = true;
  
  // ... Track loading state during API requests
  bool _isLoading = false;

  // ... Text controllers for form inputs
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    // ... Clean up controllers to prevent memory leaks
    _userController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  /// ... Handles user authentication (login/register)
  /// 
  /// Process:
  /// 1. Set loading state
  /// 2. Use ApiConfig for platform-aware URL handling
  /// 3. Build request body based on mode
  /// 4. Send HTTP POST request
  /// 5. Check response status
  /// 6. Show success/error message
  /// 7. Navigate to home page on success
  Future<void> _submit() async {
    // ... Validate input fields
    if (_userController.text.trim().isEmpty ||
        _passController.text.trim().isEmpty ||
        (!_isLogin && _emailController.text.trim().isEmpty)) {
      _showMessage("Please fill all fields");
      return;
    }

    setState(() => _isLoading = true);

    // ... Use ApiConfig for universal URL handling
    final url = Uri.parse(_isLogin ? ApiConfig.loginUrl : ApiConfig.registerUrl);

    // ... Prepare request body with common fields
    Map<String, String> bodyData = {
      "username": _userController.text.trim(),
      "password": _passController.text.trim(),
    };

    // ... Add registration-specific fields
    if (!_isLogin) {
      bodyData["email"] = _emailController.text.trim();
      bodyData["role"] = "user";
    }

    try {
      // ... Send HTTP POST request to API
      final response = await http.post(
        url,
        headers: ApiConfig.defaultHeaders,
        body: jsonEncode(bodyData),
      ).timeout(
        Duration(seconds: ApiConfig.requestTimeoutSeconds),
        onTimeout: () => throw Exception("Request timeout"),
      );

      // ... Check if response status indicates success
      if (ApiConfig.successStatusCodes.contains(response.statusCode)) {
        final message =
            _isLogin ? "Login Successful!" : "Account Created!";
        _showMessage(message);

        // ... Clear form fields after successful registration
        if (!_isLogin) {
          _clearFields();
          // ... Auto-switch to login mode
          setState(() => _isLogin = true);
        } else {
          // ... Navigate to home page on successful login
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        }
      } else {
        // ... Show error message from server response
        _showMessage("Error: ${response.body}");
      }
    } catch (e) {
      // ... Handle network or timeout errors
      _showMessage("Connection error: ${e.toString()}");
    } finally {
      // ... Stop loading indicator if widget is still mounted
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// ... Clear all input fields
  void _clearFields() {
    _userController.clear();
    _emailController.clear();
    _passController.clear();
  }

  /// ... Display message to user via SnackBar
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? "Login" : "Register"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // ... Display lock icon
            const Icon(
              Icons.lock_outline,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 30),

            // ... Username input field
            TextField(
              controller: _userController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            // ... Email input field (only visible in register mode)
            if (!_isLogin) ...[
              const SizedBox(height: 15),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],

            // ... Password input field
            const SizedBox(height: 15),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),

            const SizedBox(height: 30),

            // ... Show loading indicator or buttons based on loading state
            _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      // ... Submit button (Login or Create Account)
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 55),
                        ),
                        child: Text(
                          _isLogin ? "LOGIN" : "CREATE ACCOUNT",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),

                      // ... Toggle between login and register modes
                      TextButton(
                        onPressed: () =>
                            setState(() => _isLogin = !_isLogin),
                        child: Text(
                          _isLogin
                              ? "Need an account? Register"
                              : "Already have an account? Login",
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
