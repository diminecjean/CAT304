import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:express_all/src/components/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

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

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMoodData(
      String userEmail, DateTime startDate, DateTime endDate) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('mood')
        .where('email', isEqualTo: userEmail)
        .where('timestamp', isGreaterThanOrEqualTo: startDate)
        .where('timestamp', isLessThanOrEqualTo: endDate)
        .get();

    return snapshot;
  }

  Future<String> getUserMood(User user) async {
    String? userEmail = user.email;

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('mood')
        .where('email', isEqualTo: userEmail)
        .get();

    if (snapshot.docs.isNotEmpty) {
      String mood = snapshot.docs.first.get('mood');
      return mood;
    } else {
      return ''; // Return an empty string if no mood is found for the user
    }
  }

  updateUserMood(String mood, DateTime timestamp) async {
    Future<User?> user = getCurrentUser();
    var userEmail = (await user)?.email;
    var username = (await user)?.displayName;

    Logger().i(userEmail);

    // Convert DateTime to Date (time set to midnight)
    DateTime dateOnly =
        DateTime(timestamp.year, timestamp.month, timestamp.day);

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('mood')
        .where('email', isEqualTo: userEmail)
        .where('dateTime', isEqualTo: dateOnly)
        .get();

    // If mood for current date exists, update it
    if (snapshot.docs.isNotEmpty) {
      try {
        String documentId = snapshot.docs.first.id;
        await _firestore.collection('mood').doc(documentId).update({
          'mood': mood,
        });
      } on FirebaseException catch (e) {
        Logger().e(
            'Firestore operation failed: ${e.code}\nError Message: ${e.message}');
        showToast(message: "Error Message: ${e.message}");
        return false;
      }
    }
    // If mood for current date does not exist, create a new one
    // If mood for current date does not exist, create a new one
    else {
      try {
        await _firestore.collection('mood').add({
          'email': userEmail,
          'mood': mood,
          'dateTime': dateOnly,
          'username': username,
        });
      } on FirebaseException catch (e) {
        Logger().e(
            'Firestore operation failed: ${e.code}\nError Message: ${e.message}');
        showToast(message: "Error Message: ${e.message}");
        return false;
      }
    }
  }

  Future<Map<String, dynamic>?> setExerciseScore(
    String exerciseType,
    int correctAnsNum,
    int totalQnNum,
    int level,
    double score,
    DateTime timestamp,
  ) async {
    Future<User?> user = getCurrentUser();
    var userEmail = (await user)?.email;

    Logger().i(userEmail);

    try {
      Logger().i('Storing score data in Firestore');
      var docRef = await _firestore.collection('scores').add({
        'email': userEmail,
        'exerciseType': exerciseType,
        'correctAnsNum': correctAnsNum,
        'totalQnNum': totalQnNum,
        'level': level,
        'score': score,
        'dateTime': timestamp,
      });
      Logger().i('Score data stored in Firestore');

      // Fetch the document that you just added
      var doc = await docRef.get();

      return doc.data() as Map<String, dynamic>;
    } on FirebaseException catch (e) {
      Logger().e(
          'Firestore operation failed: ${e.code}\nError Message: ${e.message}');
      return null;
    }
  }

  // Future<double> getUserMoodHappy(String userEmail, String mood) async {
  //   QuerySnapshot totalMoodCount = await FirebaseFirestore.instance
  //       .collection('mood')
  //       .where('email', isEqualTo: userEmail)
  //       .get();

  //   QuerySnapshot happyCount = await FirebaseFirestore.instance
  //       .collection('mood')
  //       .where('email', isEqualTo: userEmail)
  //       .where('mood', isEqualTo: mood)
  //       .get();

  //   if (totalMoodCount.docs.isEmpty) {
  //     return 0.0; // Avoid division by zero
  //   }

  //   return happyCount.docs.length / totalMoodCount.docs.length;
  // }

  // // TODO: check this function
  // Future<double> getMoodCount(String mood, String userEmail, DateTime startDate,
  //     DateTime endDate) async {
  //   QuerySnapshot<Map<String, dynamic>> moodCount = await _firestore
  //       .collection('mood')
  //       .where('mood', isEqualTo: mood)
  //       .where('email', isEqualTo: userEmail)
  //       .where('timestamp', isGreaterThanOrEqualTo: startDate)
  //       .where('timestamp', isLessThanOrEqualTo: endDate)
  //       .get();
  //   QuerySnapshot totalMoodCount = await FirebaseFirestore.instance
  //       .collection('mood')
  //       .where('email', isEqualTo: userEmail)
  //       .get();

  //   if (totalMoodCount.docs.isEmpty) {
  //     return 0.0; // Avoid division by zero
  //   }

  //   return moodCount.size / totalMoodCount.size;
  // }
}
