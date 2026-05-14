import 'package:flutter/material.dart';

class CashPage extends StatelessWidget {
  const CashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cash Management")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.money, size: 100, color: Colors.teal),
            SizedBox(height: 20),
            Text("Cash Management", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Track your physical cash and liquid assets.", textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
