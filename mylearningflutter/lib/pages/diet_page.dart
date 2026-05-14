import 'package:flutter/material.dart';

class DietPage extends StatelessWidget {
  const DietPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Diet Tracker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.restaurant, size: 100, color: Colors.orange),
            SizedBox(height: 20),
            Text("Diet Tracker", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Track your meals, calories, and nutrition goals here.", textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
