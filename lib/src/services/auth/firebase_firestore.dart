import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:express_all/src/components/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

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

    //Logger().i(userEmail);

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

    //Logger().i(userEmail);

    String dayOfWeek =
        DateFormat('EEEE').format(timestamp); // Get the day of the week

    try {
      //Logger().i('Storing score data in Firestore');
      var docRef = await _firestore.collection('scores').add({
        'email': userEmail,
        'exerciseType': exerciseType,
        'correctAnsNum': correctAnsNum,
        'totalQnNum': totalQnNum,
        'level': level,
        'score': score,
        'dateTime': timestamp,
        'dayOfWeek': dayOfWeek, // Add the day of the week
      });
      //Logger().i('Score data stored in Firestore');

      // Fetch the document that you just added
      var doc = await docRef.get();

      return doc.data() as Map<String, dynamic>;
    } on FirebaseException catch (e) {
      Logger().e(
          'Firestore operation failed: ${e.code}\nError Message: ${e.message}');
      return null;
    }
  }

  // TODO: check this function
  Future<double> getMoodCount(String mood, String userEmail, DateTime startDate,
      DateTime endDate) async {
    QuerySnapshot<Map<String, dynamic>> moodCount = await _firestore
        .collection('mood')
        .where('mood', isEqualTo: mood)
        .where('email', isEqualTo: userEmail)
        .where('dateTime', isGreaterThanOrEqualTo: startDate)
        .where('dateTime', isLessThanOrEqualTo: endDate)
        .get();
    QuerySnapshot totalMoodCount = await FirebaseFirestore.instance
        .collection('mood')
        .where('email', isEqualTo: userEmail)
        .where('dateTime', isGreaterThanOrEqualTo: startDate)
        .where('dateTime', isLessThanOrEqualTo: endDate)
        .get();

    if (totalMoodCount.docs.isEmpty) {
      return 0.0; // Avoid division by zero
    }

    //Logger().i('moodCount.size: ${moodCount.size}');
    //Logger().i('totalMoodCount.size: ${totalMoodCount.size}');
    //Logger().i(
    // 'moodCount.size / totalMoodCount.size: ${moodCount.size / totalMoodCount.size}');
    return moodCount.size / totalMoodCount.size;
  }

  Future<double> getDailyAverageScore(String userEmail, Timestamp timestamp,
      String dayOfWeek, String exerciseType) async {
    //Logger().i('Starting getDailyAverageScore');
    DateTime now = timestamp.toDate();
    int nowDayOfWeek = now.weekday; // Monday is 1, Sunday is 7
    List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    int targetDayOfWeek = daysOfWeek.indexOf(dayOfWeek) + 1;

    int diff = nowDayOfWeek - targetDayOfWeek;
    if (diff < 0) {
      diff += 7;
    } // If target day is after now, go to the previous week

    DateTime targetDate = now.subtract(Duration(days: diff));
    DateTime startOfDay =
        DateTime(targetDate.year, targetDate.month, targetDate.day, 0, 0, 0);
    DateTime endOfDay =
        DateTime(targetDate.year, targetDate.month, targetDate.day, 23, 59, 59);
    //Logger().i('Start of day: $startOfDay');
    //Logger().i('End of day: $endOfDay');
    //Logger().i('Fetching scores from Firestore');
    //Logger().i('User email: $userEmail');
    //Logger().i('Exercise type: $exerciseType');
    QuerySnapshot<Map<String, dynamic>> snapshots = await _firestore
        .collection('scores')
        .where('email', isEqualTo: userEmail)
        .where('exerciseType', isEqualTo: exerciseType)
        .where('dateTime',
            isGreaterThanOrEqualTo: startOfDay) // Start of target day
        .where('dateTime', isLessThan: endOfDay) // End of target day
        .get();

    if (snapshots.docs.isEmpty) {
      //Logger().i('No snapshots found');
      return 0.0; // Return 0 if no snapshots found
    }

    double totalScore = 0.0;
    int count = 0;
    for (var snapshot in snapshots.docs) {
      totalScore += snapshot.data()['score'];
      count++;
    }

    if (count == 0) {
      //Logger().i('No snapshots found for the given day of week');
      return 0.0; // Return 0 if no snapshots found for the given day of week
    }

    double averageScore = totalScore / count;
    //Logger().i('Average score: $averageScore');
    return averageScore;
  }

  Future<List<double>> getWeeklyAverageScores(
      String userEmail, Timestamp timestamp, String exerciseType) async {
    //Logger().i('Starting getWeeklyAverageScores');
    DateTime now = timestamp.toDate();
    List<double> weeklyScores = [];

    for (int i = 0; i < 4; i++) {
      DateTime startOfWeek =
          now.subtract(Duration(days: now.weekday - 1 + 7 * i));
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
      DateTime startOfDay = DateTime(
          startOfWeek.year, startOfWeek.month, startOfWeek.day, 0, 0, 0);
      DateTime endOfDay =
          DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);

      //Logger().i('Start of week: $startOfDay');
      //Logger().i('End of week: $endOfDay');
      //Logger().i('Fetching scores from Firestore');
      //Logger().i('User email: $userEmail');
      //Logger().i('Exercise type: $exerciseType');

      QuerySnapshot<Map<String, dynamic>> snapshots = await _firestore
          .collection('scores')
          .where('email', isEqualTo: userEmail)
          .where('exerciseType', isEqualTo: exerciseType)
          .where('dateTime',
              isGreaterThanOrEqualTo: startOfDay) // Start of target week
          .where('dateTime', isLessThan: endOfDay) // End of target week
          .get();

      if (snapshots.docs.isEmpty) {
        //Logger().i('No snapshots found for week $i');
        weeklyScores.add(0.0); // Add 0 if no snapshots found for the week
        continue;
      }

      double totalScore = 0.0;
      int count = 0;
      for (var snapshot in snapshots.docs) {
        totalScore += snapshot.data()['score'];
        count++;
      }

      if (count == 0) {
        //Logger().i('No snapshots found for week $i');
        weeklyScores.add(0.0); // Add 0 if no snapshots found for the week
        continue;
      }

      double averageScore = totalScore / count;
      //Logger().i('Average score for week $i: $averageScore');
      weeklyScores.add(averageScore);
    }

    return weeklyScores;
  }

  Future<List<double>> getMonthlyAverageScores(
      String userEmail, Timestamp timestamp, String exerciseType) async {
    //Logger().i('Starting getMonthlyAverageScores');
    DateTime now = timestamp.toDate();
    List<double> monthlyScores = [];

    for (int i = 0; i < 12; i++) {
      DateTime startOfMonth = DateTime(now.year, now.month - i, 1);
      DateTime endOfMonth = DateTime(now.year, now.month - i + 1, 0);

      //Logger().i('Start of month: $startOfMonth');
      //Logger().i('End of month: $endOfMonth');
      //Logger().i('Fetching scores from Firestore');
      //Logger().i('User email: $userEmail');
      //Logger().i('Exercise type: $exerciseType');

      QuerySnapshot<Map<String, dynamic>> snapshots = await _firestore
          .collection('scores')
          .where('email', isEqualTo: userEmail)
          .where('exerciseType', isEqualTo: exerciseType)
          .where('dateTime',
              isGreaterThanOrEqualTo: startOfMonth) // Start of target month
          .where('dateTime', isLessThan: endOfMonth) // End of target month
          .get();

      if (snapshots.docs.isEmpty) {
        //Logger().i('No snapshots found for month $i');
        monthlyScores.add(0.0); // Add 0 if no snapshots found for the month
        continue;
      }

      double totalScore = 0.0;
      int count = 0;
      for (var snapshot in snapshots.docs) {
        totalScore += snapshot.data()['score'];
        count++;
      }

      if (count == 0) {
        //Logger().i('No snapshots found for month $i');
        monthlyScores.add(0.0); // Add 0 if no snapshots found for the month
        continue;
      }

      double averageScore = totalScore / count;
      //Logger().i('Average score for month $i: $averageScore');
      monthlyScores.add(averageScore);
    }

    return monthlyScores;
  }

  Future<double> getExerciseAverageCount(
      String userEmail, String exerciseType) async {
    //Logger().i('Starting getExerciseAverageCount');

    QuerySnapshot<Map<String, dynamic>> exerciseSnapshots = await _firestore
        .collection('scores')
        .where('email', isEqualTo: userEmail)
        .where('exerciseType', isEqualTo: exerciseType)
        .get();

    double exerciseTotalQnNum = exerciseSnapshots.docs.fold(0, (sum, doc) {
      var totalQnNum = doc.data()['totalQnNum'];
      return sum + (totalQnNum ?? 0);
    });

    QuerySnapshot<Map<String, dynamic>> allSnapshots = await _firestore
        .collection('scores')
        .where('email', isEqualTo: userEmail)
        .get();

    double allTotalQnNum = allSnapshots.docs.fold(0, (sum, doc) {
      var totalQnNum = doc.data()['totalQnNum'];
      return sum + (totalQnNum ?? 0);
    });

    return allTotalQnNum == 0 ? 0.0 : exerciseTotalQnNum / allTotalQnNum;
  }
}
