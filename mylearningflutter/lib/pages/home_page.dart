import 'package:flutter/material.dart';

/// Home Page (Blank Page)
/// 
/// This is the main page displayed after a user successfully logs in.
/// Currently shows a welcome message and a logout button.
/// 
/// Features:
/// - ... Display welcome message
/// - ... Logout button to return to login page
/// - ... Clear and simple UI for future content
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ... Track logout loading state
  bool _isLoading = false;

  /// ... Handle logout action
  /// 
  /// Process:
  /// 1. Set loading state
  /// 2. Simulate API call delay (optional)
  /// 3. Navigate back to login page
  /// 4. Clear navigation stack to prevent back navigation
  Future<void> _logout() async {
    setState(() => _isLoading = true);

    // ... Simulate API logout call (optional)
    await Future.delayed(const Duration(milliseconds: 500));

    // ... Navigate back to login page and remove all previous routes
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  /// ... Display logout confirmation dialog
  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            // ... Cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            // ... Confirm logout button
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _logout();
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        // ... Add logout button in app bar
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _isLoading ? null : _showLogoutConfirmation,
            tooltip: "Logout",
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            // ... Show loading indicator during logout
            ? const CircularProgressIndicator()
            // ... Show welcome message and content area
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ... Welcome icon
                  const Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 30),

                  // ... Welcome title
                  const Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // ... Welcome message
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "You have successfully logged in.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // ... Logout button
                  ElevatedButton.icon(
                    onPressed:
                        _isLoading ? null : _showLogoutConfirmation,
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 50),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
