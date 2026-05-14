import 'package:flutter/material.dart';

class AccountingPage extends StatelessWidget {
  const AccountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Accounting")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.pie_chart, size: 100, color: Colors.deepPurple),
            SizedBox(height: 20),
            Text("Accounting", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Detailed financial reports and balance sheets.", textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
