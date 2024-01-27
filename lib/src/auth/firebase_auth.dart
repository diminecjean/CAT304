import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:express_all/src/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<String> get onAuthStateChanged => _auth
      .authStateChanges()
      .map(
        (User? user) => user?.uid,
      )
      .where((String? uid) => uid != null)
      .cast<String>();

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password,
      String username, String userType, BuildContext context) async {
    try {
      Logger().i('Creating user...');
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Logger().i('User created!');
      // update displayName of current user
      await updateUserName(username, credential.user!);
      Logger().i('Name Updated!');
      Logger().i('Storing user data in Firestore');
      try {
        Logger().i('Storing user data in Firestore');
        // store user data in firestore
        // purpose is to retrieve user type based on email
        await _firestore.collection('users').doc(credential.user?.uid).set({
          'username': username,
          'email': email,
          'userType': userType,
        });
        Logger().i('User data stored in Firestore');
      } on FirebaseException catch (e) {
        Logger().e(
            'Firestore operation failed: ${e.code}\nError Message: ${e.message}');
        // Handle Firestore exception...
      }
      Logger().i('User data stored in Firestore');
      // Direct user to page based on userType
      if (userType == 'child') {
        Navigator.pushNamed(context, '/MainMenu');
      } else if (userType == 'parent') {
        Navigator.pushNamed(context, '/Dashboard');
      }
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      Logger().i("sign in with email and password");
      UserCredential credential = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 360), onTimeout: () {
        throw TimeoutException('Connection timed out. Please try again.');
      });
      Logger().i("found user");
      Logger().i(email);

      // Get document snapshot from firestore based on email
      var userQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      Logger().i(userQuery);
      if (userQuery.docs.isEmpty) {
        Logger().e("no match in firestore");
        showToast(message: 'No user found with this email.');
        return null;
      }

      // Get userType from firestore
      DocumentSnapshot userDoc = userQuery.docs.first;
      String userType = userDoc['userType'];

      // Direct user to page based on userType
      if (userType == 'child') {
        Logger().i("match type child");
        Navigator.pushNamed(context, '/MainMenu');
      } else if (userType == 'parent') {
        Logger().i("match type parent");
        Navigator.pushNamed(context, '/Dashboard');
      }
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Logger().i("Invalid email.");
        showToast(message: 'Invalid email.');
      } else if (e.code == 'invalid-credentials') {
        Logger().i("Invalid password.");
        showToast(message: 'Invalid password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    } on TimeoutException catch (e) {
      Logger().e(e.message);
      return null;
    }
    return null;
  }

  signOut() {
    return _auth.signOut();
  }

  Future updateUserName(String name, User currentUser) async {
    await currentUser.updateDisplayName(name);
    await currentUser.reload();
  }
}
