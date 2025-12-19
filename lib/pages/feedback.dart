import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  String? _feedbackType = 'Bug Report'; // Default feedback type
  String? _feedbackMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      // Get the current user's ID if logged in
      String? userId = _auth.currentUser?.uid;

      // Create feedback data
      Map<String, dynamic> feedbackData = {
        'feedbackType': _feedbackType,
        'feedbackMessage': _feedbackMessage,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      };

      try {
        // Add feedback to Firestore
        await _firestore.collection('feedback').add(feedbackData);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Thank you for your feedback!")),
        );

        // Clear the form fields
        setState(() {
          _feedbackType = 'Bug Report';
          _feedbackMessage = '';
        });
      } catch (error) {
        // Show error message if submission fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to submit feedback. Please try again.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Feedback Type",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _feedbackType,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('Bug Report'),
                    value: 'Bug Report',
                  ),
                  DropdownMenuItem(
                    child: Text('Feature Request'),
                    value: 'Feature Request',
                  ),
                  DropdownMenuItem(
                    child: Text('Other'),
                    value: 'Other',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _feedbackType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a feedback type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                "Your Feedback",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter your feedback here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _feedbackMessage = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide your feedback';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: submitFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 25.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
