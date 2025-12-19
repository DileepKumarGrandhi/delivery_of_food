import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save user data to Firestore (without password)
  Future<void> saveUserData(String uid, String email, String name) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  // Get user data from Firestore
  Future<DocumentSnapshot> getUserData(String uid) async {
    try {
      return await _firestore.collection('users').doc(uid).get();
    } catch (e) {
      print('Error getting user data: $e');
      rethrow;
    }
  }

  // Update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    }
  }

  // Delete user data
  Future<void> deleteUserData(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
    } catch (e) {
      print('Error deleting user data: $e');
      rethrow;
    }
  }
}