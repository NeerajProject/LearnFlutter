import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

/// Login Page
/// 
/// This widget handles user login functionality.
/// Users can enter their username and password to authenticate.
/// 
/// Features:
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
  // ... Track loading state during API requests
  bool _isLoading = false;

  // ... Text controllers for form inputs
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    // ... Clean up controllers to prevent memory leaks
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  /// ... Handles user login authentication
  /// 
  /// Process:
  /// 1. Set loading state
  /// 2. Use ApiConfig for platform-aware URL handling
  /// 3. Build request body with credentials
  /// 4. Send HTTP POST request
  /// 5. Check response status
  /// 6. Show success/error message
  /// 7. Navigate to home page on success
  Future<void> _submit() async {
                    _showMessage(_userController.text);
                  
        
    // ... Validate input fields
    if (_userController.text.trim().isEmpty ||
        _passController.text.trim().isEmpty) {
                _showMessage(_userController.text);

      _showMessage("Please fill all fields");
      return;
    }

    setState(() => _isLoading = true);

    // ... Use ApiConfig for universal URL handling
    final url = Uri.parse(ApiConfig.loginUrl);

    // ... Prepare request body with credentials
    Map<String, String> bodyData = {
      "username": _userController.text.trim(),
      "password": _passController.text.trim(),
    };

    try {
              _showMessage("App confi : ${ ApiConfig.defaultHeaders}");
              _showMessage("App confi : ${ jsonEncode(bodyData)}");

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
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        ApiConfig.authToken = responseData['access_token'];
        
        _showMessage("Login Successful!");

        // ... Navigate to home page on successful loginr
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        // ... Show error message from server response
        _showMessage("Error: ${_userController.text} ${response.body}");
      }
    } catch (e) {
      // ... Handle network or timeout errors
      _showMessage("Connection error: ${e.toString()}");
    } finally {
      // ... Stop loading indicator if widget is still mounted
      if (mounted) setState(() => _isLoading = false);
    }
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
        title: const Text("Login"),
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

            // ... Show loading indicator or login button
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
