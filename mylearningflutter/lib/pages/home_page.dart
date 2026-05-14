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
      Navigator.of(context).pushNamedAndRemoveUntil('/landing', (route) => false);
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
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(20),
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: [
                        _buildDashboardCard(
                          context,
                          "Diet",
                          Icons.restaurant,
                          Colors.orange,
                          '/diet',
                        ),
                        _buildDashboardCard(
                          context,
                          "Expense",
                          Icons.account_balance_wallet,
                          Colors.green,
                          '/expense',
                        ),
                        _buildDashboardCard(
                          context,
                          "Projects",
                          Icons.assignment,
                          Colors.blue,
                          '/projects',
                        ),
                        _buildDashboardCard(
                          context,
                          "Cash",
                          Icons.money,
                          Colors.teal,
                          '/cash',
                        ),
                        _buildDashboardCard(
                          context,
                          "Journaling",
                          Icons.book,
                          Colors.brown,
                          '/journaling',
                        ),
                        _buildDashboardCard(
                          context,
                          "Income",
                          Icons.trending_up,
                          Colors.blueAccent,
                          '/income',
                        ),
                        _buildDashboardCard(
                          context,
                          "Accounting",
                          Icons.pie_chart,
                          Colors.deepPurple,
                          '/accounting',
                        ),
                        _buildDashboardCard(
                          context,
                          "Profile",
                          Icons.person,
                          Colors.purple,
                          '/profile',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon, Color color, String route) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
