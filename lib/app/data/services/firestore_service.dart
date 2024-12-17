import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

FirestoreService get firestoreService => Get.find<FirestoreService>();

class FirestoreService extends GetxController {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Future<Map<String, String>?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection("users").doc(uid).get();
      if (doc.exists) {
        return doc.data() as Map<String, String>?;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Error getting user data: $e");
      return null;
    }
  }

  Future<void> createAccount(String uid, Map<String, String> userData) async {
    try {
      await _db.collection("users").doc(uid).set(userData);
    } catch (e) {
      debugPrint("Error creating user: $e");
    }
  }

  Future<void> updateAccount(String uid, Map<String, String> userData) async {
    try {
      await _db.collection("users").doc(uid).update(userData);
    } catch (e) {
      debugPrint("Error updating user: $e");
    }
  }

  Future<void> deleteAccount(Map<String, String> profileData) async {
    try {
      if (user != null) {
        await _db.collection("users").doc(user!.uid).update(profileData);
      } else {
        debugPrint("No user is currently signed in.");
      }
    } catch (e) {
      debugPrint("Error updating profile: $e");
    }
  }
}
