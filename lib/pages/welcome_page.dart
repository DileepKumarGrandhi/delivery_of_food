import 'package:deliveryoffood/admin/admin_login.dart';
import 'package:deliveryoffood/pages/signup.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.green[300]!], // Softer background gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adjusted Welcome message
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black, // Changed text color to white
                  fontSize: 48, // Increased font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),

            // Image with updated border color and increased size
            Container(
              width: 255, // Increased width
              height: 255, // Increased height
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: Colors.amber, // Updated border color to amber for a warmer look
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/your_image.png', // Replace with your actual image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 60),

            // Your specific quotation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'A simple act of sharing food can have a profound impact on someone\'s life.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black, // Changed text color to white
                  fontSize: 25, // Increased font size
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 120),

            // Admin and User registration icons
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLogin()));
                      },
                      child: Column(
                        children: [
                          Icon(Icons.admin_panel_settings, size: 60, color: Colors.amber), // Updated icon color to amber
                          SizedBox(height: 5),
                          Text(
                            'Admin',
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20), // Changed text color to white
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Column(
                        children: [
                          Icon(Icons.person_add, size: 60, color: Colors.amber), // Updated icon color to amber
                          SizedBox(height: 5),
                          Text(
                            'User',
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20), // Changed text color to white
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
