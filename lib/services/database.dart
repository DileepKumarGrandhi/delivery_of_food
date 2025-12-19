import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to save user data
  Future<void> saveUserData(String userId, String email, String name,String password,) async {
    await _db.collection('users').doc(userId).set({
      'email': email,
      'name': name,
      'password':password,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
