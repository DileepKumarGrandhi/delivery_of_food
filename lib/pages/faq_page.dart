import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequently Asked Questions'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FAQItem(
              question: "How do I reset my password?",
              answer: "To reset your password, go to the login screen, click on 'Forgot Password,' and follow the instructions sent to your registered email.",
            ),
            Divider(thickness: 1.5),
            FAQItem(
              question: "Can I use the app offline?",
              answer: "The app requires an internet connection for most features to function. Some offline features may be available, but data syncing will occur only when you're back online.",
            ),
            Divider(thickness: 1.5),
            FAQItem(
              question: "Why am I experiencing login issues?",
              answer: "Login issues may occur due to incorrect credentials, connectivity problems, or server maintenance. Double-check your login details and ensure you have a stable internet connection.",
            ),
            Divider(thickness: 1.5),
            FAQItem(
              question: "Is my data secure?",
              answer: "Yes, we prioritize your data security and employ industry-standard encryption and security protocols.",
            ),
            Divider(thickness: 1.5),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({required this.question, required this.answer, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            answer,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
