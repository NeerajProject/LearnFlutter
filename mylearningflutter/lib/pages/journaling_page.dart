import 'package:flutter/material.dart';

class JournalingPage extends StatelessWidget {
  const JournalingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Journaling")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.book, size: 100, color: Colors.brown),
            SizedBox(height: 20),
            Text("Daily Journaling", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Capture your thoughts and track your personal growth.", textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
