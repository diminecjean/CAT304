import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<String> get onAuthStateChanged => _auth
      .authStateChanges()
      .map(
        (User? user) => user?.uid,
      )
      .where((String? uid) => uid != null)
      .cast<String>();

  Future<User?> getUserInfo(String uid) async {
    return _auth.currentUser;
  }
}
