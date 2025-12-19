import 'package:deliveryoffood/pages/editprofile.dart';
import 'package:deliveryoffood/pages/feedback.dart';
import 'package:deliveryoffood/pages/help_support.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true; // Initial value of the notification toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.deepPurple,  // Updated AppBar color
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color(0xFFF3F4F6),  // Light background color for the entire page
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Edit Profile Tile with updated styling
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.deepPurple),
                title: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
              ),
            ),
            Divider(),

            // Notifications toggle
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: SwitchListTile(
                title: Text(
                  'Notifications',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                secondary: Icon(Icons.notifications, color: Colors.deepPurple),
                activeColor: Colors.deepPurple,
                value: _notificationsEnabled, // Bind the switch to the state variable
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value; // Toggle the switch state
                  });
                },
              ),
            ),
            Divider(),

            // Rate App tile
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: Icon(Icons.star, color: Colors.deepPurple),
                title: Text(
                  'Rate App',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                onTap: () {
                  // Handle Rate App
                },
              ),
            ),
            Divider(),

            // Feedback tile
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: Icon(Icons.feedback, color: Colors.deepPurple),
                title: Text(
                  'Feedback',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                onTap: () {
                  // Handle Feedback
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()));
                },
              ),
            ),
            Divider(),

            // Help & Support tile
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: Icon(Icons.help, color: Colors.deepPurple),
                title: Text(
                  'Help & Support',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                onTap: () {
                  // Handle Help & Support
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>HelpSupportPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
