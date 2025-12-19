import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryoffood/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form validation key

  @override
  void initState() {
    super.initState();_loadUserData(); // Load user data when the page initializes
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc['name'] ?? '';
          _emailController.text = userDoc['email'] ?? '';
          _phoneController.text = userDoc['phone'] ?? '';
          _cityController.text = userDoc['city'] ?? '';
        });
      }
    }
  }

  // Function to handle saving profile information
  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Extract values from textcontrollers
      String name = _nameController.text;
      String email = _emailController.text;
      String phone = _phoneController.text;
      String city = _cityController.text;

      // Get the current user's UID
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Update the user document in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({
          'name': name,
          'email': email,
          'phone': phone,
          'city': city,
        });

        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile Saved!')),
        );

        // Navigate to SettingsPage after saving
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Color(0xFFF3F4F6),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildLabel('Name'),
              buildTextField(
                controller: _nameController,
                hintText: 'Enter your name',
                validatorMessage: 'Please enter your name',
              ),
              SizedBox(height: 16),
              buildLabel('Email'),
              buildTextField(
                controller: _emailController,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                validatorMessage: 'Please enter a valid email',
                additionalValidator: (value) {
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value ?? '')) {
                    return 'Please entera valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              buildLabel('Phone Number'),
              buildTextField(
                controller: _phoneController,
                hintText: 'Enter your phone number',
                keyboardType: TextInputType.phone,
                validatorMessage: 'Please enter a valid phone number',
                additionalValidator: (value) {
                  if (!RegExp(r'^\d{10}$').hasMatch(value ?? '')) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              buildLabel('City'),
              buildTextField(
                controller: _cityController,
                hintText: 'Enter your city',
                validatorMessage: 'Please enter your city',
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create label text
  Widget buildLabel(String labelText) {
    return Text(
      labelText,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  // Helper function to create text fields
  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String validatorMessage,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? additionalValidator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled:true,
        fillColor: Colors.white,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: EdgeInsets.all(15.0),
      ),
      style: TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        return additionalValidator != null ? additionalValidator(value) : null;
      },
    );
  }
}