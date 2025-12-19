import 'package:deliveryoffood/pages/AppUsageGuide.dart';
import 'package:flutter/material.dart';
import 'faq_page.dart'; // Import the FAQ page

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How can we assist you?",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigate to the FAQ page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQPage()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.question_answer, color: Colors.blue),
                title: Text(
                  "FAQs",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Frequently Asked Questions"),
              ),
            ),
            Divider(thickness: 1.5),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>AppUsageGuidePage()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.info_outline, color: Colors.orange),
                title: Text(
                  "App Usage Guide",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Step-by-step guide on how to use the app"),
              ),
            ),
            Divider(thickness: 1.5),
          ],
        ),
      ),
    );
  }
}
