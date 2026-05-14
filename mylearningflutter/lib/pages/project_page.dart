import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Project Planner")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.assignment, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text("Project Planner", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Organize your tasks and manage your projects effectively.", textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
