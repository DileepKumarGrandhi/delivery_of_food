import 'package:flutter/material.dart';

class AppUsageGuidePage extends StatelessWidget {
  const AppUsageGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Usage Guide"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Getting Started Section
            Text(
              "Getting Started",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "1. Open the app and log in with your account.\n"
                  "2. Explore the main features available on the home screen.",
            ),
            SizedBox(height: 20),

            // Profile Management Section
            Text(
              "Profile Management",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "1. Navigate to the Profile page to view your profile details.\n"
                  "2. To change your profile picture, tap on the edit icon next to the profile image.\n"
                  "3. Select an image from your gallery and upload it to update your profile picture.",
            ),
            SizedBox(height: 20),

            // Updating Username and Email Section
            Text(
              "Updating Username and Email",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "1. On the Profile page, you can view your current username and email.\n"
                  "2. If allowed, you can edit these fields by tapping on the respective fields and entering the new information.\n"
                  "3. Save changes to update your profile.",
            ),
            SizedBox(height: 20),

            // Logging Out
            Text(
              "Logging Out",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "1. To log out, go to the Profile page and tap on the 'Logout' button.\n"
                  "2. You will be safely logged out and redirected to the login screen.",
            ),
            SizedBox(height: 20),

            // Deleting Account
            Text(
              "Deleting Your Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "1. On the Profile page, you will find a 'Delete Account' option.\n"
                  "2. Tap this button to permanently delete your account.\n"
                  "3. Confirm the deletion if prompted. Note that this action is irreversible.",
            ),
            SizedBox(height: 20),

            // Submitting Feedback
            Text(
              "Submitting Feedback",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "1. Navigate to the Feedback page to share your thoughts.\n"
                  "2. Choose the feedback type (e.g., Bug Report, Feature Request) from the dropdown menu.\n"
                  "3. Enter your feedback in the text field and submit it. You will see a confirmation message once submitted.",
            ),
            SizedBox(height: 20),

            // Accessing Help & Support
            Text(
              "Help & Support",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "1. If you need assistance, go to the Help & Support page from the main menu.\n"
                  "2. Access FAQs or the App Usage Guide for additional help with common questions and features.",
            ),
            SizedBox(height: 20),

            // Navigating to Home Screen
            Text(
              "Navigating to the Home Screen",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "1. Use the back arrow at the top of each page to return to the home screen.\n"
                  "2. Alternatively, tap the Home button if available in the bottom navigation bar.",
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
