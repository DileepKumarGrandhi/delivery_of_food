import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
        centerTitle: true,
        backgroundColor: Colors.teal, // Changed color to teal for a fresh look
        elevation: 2.0, // Added elevation for subtle shadow effect
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '''Terms and Conditions

Welcome to FoodShare. By using our mobile application, you agree to the following terms and conditions. Please read them carefully before using the app.

1. Acceptance of Terms
By accessing or using the FoodShare app, you agree to be bound by these terms and conditions ("Terms"). If you do not agree to these Terms, you may not use the app. FoodShare reserves the right to modify these Terms at any time. Your continued use of the app after any changes signifies your acceptance of the updated Terms.

2. Purpose of the App
FoodShare is a mobile platform designed to connect individuals, organizations, and businesses with surplus food to those in need. The app facilitates food donations by providing tools to manage, coordinate, and track donations and deliveries in real time.

3. Eligibility
You must be at least 18 years of age to use the FoodShare app. By using the app, you confirm that you meet this requirement. If you are using the app on behalf of an organization, you represent that you have the authority to bind the organization to these Terms.

...

8. Privacy
Your privacy is important to us. Please review our [Privacy Policy] to understand how we collect, use, and protect your personal information when using the FoodShare app.''',
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.5, // Adjusted line height for better readability
                    color: Colors.grey[800], // Dark grey text color for readability
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 25.0),
                    backgroundColor: Colors.redAccent, // Softer red color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                  ),
                  child: Text('Decline', style: TextStyle(fontSize: 18.0)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Logic to save user's acceptance can be added here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 25.0),
                    backgroundColor: Colors.green, // Green to indicate acceptance
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                  ),
                  child: Text('Accept', style: TextStyle(fontSize: 18.0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
