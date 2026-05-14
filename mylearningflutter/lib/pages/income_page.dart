import 'package:flutter/material.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Income Tracker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.trending_up, size: 100, color: Colors.blueAccent),
            SizedBox(height: 20),
            Text("Income Tracker", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Monitor your various income streams and salary.", textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
