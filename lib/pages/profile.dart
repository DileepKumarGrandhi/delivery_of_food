import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryoffood/pages/login.dart';
import 'package:deliveryoffood/pages/settings.dart';
import 'package:deliveryoffood/pages/terms_conditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      uploadItem();
    }
  }

  Future<void> uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child("profileImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      await saveUserProfile(downloadUrl);
      setState(() {
        profile = downloadUrl;
      });
    }
  }

  Future<void> saveUserProfile(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userProfile", url);
  }

  Future<void> getUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
      if (userDoc.exists) {
        setState(() {
          // Use the correct field names from Firestore
          name = userDoc['name'];
          email = userDoc['email'];
        });
      } else {
        print("User document does not exist.");
      }
    } else {
      print("No user is currently logged in.");
    }
  }


  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profile = prefs.getString("userProfile");
    });
    await getUserData(); // Load user data from Firestore
  }

  Future<void> deleteAccount(String password) async {
    User? user = _auth.currentUser;
    if (user != null) {
      AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: password);
      try {
        // Re-authenticate the user
        await user.reauthenticateWithCredential(credential);
        // Delete the user account
        await user.delete();
        showSnackbar("Account deleted successfully");
        // Navigate to the login page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => logIn()),
        );
      } catch (e) {
        showSnackbar("Error deleting account: ${e.toString()}");
        print("Error deleting account: $e");
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    showSnackbar("Logged out successfully");
    // Navigate to the login page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => logIn()),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFF3F4F6),
          child: Column(
            children: [
              // Header with Profile Picture and Name
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                    height: MediaQuery.of(context).size.height / 4.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 105.0),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: getImage,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 6.5),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(60),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: profile != null
                                    ? Image.network(
                                  profile!,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                )
                                    : Icon(
                                  Icons.person,
                                  size: 120,
                                  color: Colors.grey,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 70.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name ?? "User",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            fontFamily: 'Poppins',
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              // Name Section
              _buildInfoCard(Icons.person, "Name", name ?? "User"),

              // Email Section
              _buildInfoCard(Icons.mail, "Email", email ?? "user@example.com"),

              // Terms and Conditions
              _buildActionCard(Icons.description, "Terms and Conditions", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsAndConditions()),
                );
              }),

              // Delete Account
              _buildActionCard(Icons.delete, "Delete Account", () {
                // Add logic to ask for password or confirmation
                deleteAccount("userPassword"); // Replace with actual password input
              }),

              // LogOut
              _buildActionCard(Icons.logout, "LogOut", logout),

              // Settings
              _buildActionCard(Icons.settings, "Settings", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build Info Cards
  Widget _buildInfoCard(IconData icon, String title, [String? subtitle]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.deepPurple),
              SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build Action Cards
  Widget _buildActionCard(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.deepPurple),
                SizedBox(width: 20.0),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
