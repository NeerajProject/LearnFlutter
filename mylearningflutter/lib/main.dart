import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Toggle between Login and Register
  bool _isLogin = true;
  bool _isLoading = false;

  final _userController = TextEditingController();
  final _emailController = TextEditingController(); // Only for Register
  final _passController = TextEditingController();

  Future<void> _submit() async {
    setState(() => _isLoading = true);

    // Platform-aware localhost handling
    String baseUrl = kIsWeb ? "localhost" : (Platform.isAndroid ? "10.0.2.2" : "localhost");
    
    // Switch endpoint based on mode
    final String path = _isLogin ? '/users/login' : '/users/register';
    final url = Uri.parse('http://$baseUrl:8000$path');

    // Prepare body
    Map<String, String> bodyData = {
      "username": _userController.text.trim(),
      "password": _passController.text.trim(),
    };

    // Add registration-specific fields from image_a177f3.png
    if (!_isLogin) {
      bodyData["email"] = _emailController.text.trim();
      bodyData["role"] = "user"; 
    }

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bodyData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _msg(_isLogin ? "Login Successful!" : "Account Created!");
      } else {
        _msg("Error: ${response.body}");
      }
    } catch (e) {
      _msg("Connection error. Is the server running at port 8000?");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _msg(String m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? "Login" : "Register")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
            const SizedBox(height: 30),
            TextField(
              controller: _userController, 
              decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder())
            ),
            if (!_isLogin) ...[
              const SizedBox(height: 15),
              TextField(
                controller: _emailController, 
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())
              ),
            ],
            const SizedBox(height: 15),
            TextField(
              controller: _passController, 
              decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            _isLoading 
              ? const CircularProgressIndicator() 
              : Column(
                  children: [
                    ElevatedButton(
                      onPressed: _submit, 
                      style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 55)),
                      child: Text(_isLogin ? "LOGIN" : "CREATE ACCOUNT"),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _isLogin = !_isLogin),
                      child: Text(_isLogin ? "Need an account? Register" : "Already have an account? Login"),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}