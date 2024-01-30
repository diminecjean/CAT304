import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:express_all/src/components/toast.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/services/auth/firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class DashboardPage extends StatelessWidget {
  final String userEmail;
  const DashboardPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text('Progress Report',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            // User info and mood chart
            UserInfoSection(
              userEmail: userEmail,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              width: 280,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 10,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ],
              ),
              child: MoodChartSection(
                userEmail: userEmail,
              ),
            ),

            // Practice chart
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PracticeChartSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  final String userEmail;
  const UserInfoSection({super.key, required this.userEmail});

  String getTextBasedOnMood(String mood) {
    switch (mood) {
      case 'Happy':
        return "I'm happy today! 😁";
      case 'Sad':
        return "I'm feeling down..😢";
      case 'Angry':
        return "I'm kinda angry 😡";
      case 'Neutral':
        return "I'm feel normal as usual. 😀";
      default:
        return "I dunno how I'm feeling today...";
    }
  }

  Color getColorBasedOnMood(String mood) {
    switch (mood) {
      case 'Happy':
        return Color.fromARGB(173, 125, 224, 128);
      case 'Sad':
        return Color.fromARGB(255, 255, 229, 134);
      case 'Angry':
        return Color(0xFFE1847D);
      case 'Neutral':
        return Color(0xFF86C9FF);
      default:
        return secondaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    Logger().i('User email: $userEmail');
    // This section contains the user info, like the name and profile picture
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('mood')
          .where('email', isEqualTo: userEmail)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data!.docs.isEmpty) {
          showToast(message: 'Error: ${snapshot.error}');
          Logger().i('No child found');
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('⚠️ No child found',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ],
          );
        } else {
          Logger().i('child found');
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                Logger().i('Data: $data');
                return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/menu_5_profile_pic.png",
                              height: 70,
                            ),
                            SizedBox(width: 16),
                            Text(
                              data['username'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        Column(children: <Widget>[
                          BubbleSpecialTwo(
                            text: getTextBasedOnMood(
                              data['mood'],
                            ),
                            isSender: false,
                            color: getColorBasedOnMood(data['mood']),
                            tail: true,
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 82, 64, 64),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(DateTime.now().toString().substring(0, 10),
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey)),
                        ]),
                      ],
                    ));
              }).toList(),
            ),
          );
        }
      },
    );
  }
}

class MoodChartSection extends StatelessWidget {
  final String userEmail;
  const MoodChartSection({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Mood Chart",
          style: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          mainAxisSize:
              MainAxisSize.min, // To control the space that the Column occupies
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VerticalBarIndicator(
              width: 20,
              height: 80,
              percent: 0.3,
              // header: '90%',
              footer: 'Happy',
              color: [
                Color.fromARGB(173, 60, 232, 97),
                Color.fromARGB(255, 79, 197, 104)
              ],
            ),
            SizedBox(width: 20),
            VerticalBarIndicator(
              width: 20,
              height: 80,
              percent: 0.5,
              // header: '50%',
              footer: 'Angry',
              color: [
                Color.fromARGB(141, 255, 33, 17),
                Color.fromARGB(193, 181, 35, 24),
              ],
            ),
            SizedBox(width: 20),
            VerticalBarIndicator(
              width: 20,
              height: 80,
              percent: 0.7,
              // header: '50%',
              footer: 'Neutral',
              color: [
                Color.fromARGB(204, 54, 134, 255),
                Color.fromARGB(204, 38, 103, 200),
              ],
            ),
            SizedBox(width: 20),
            VerticalBarIndicator(
              width: 20,
              height: 80,
              percent: 0.8,
              // header: '50%',
              footer: 'Sad',
              color: [Color(0xC5FF5E00), Color.fromARGB(197, 192, 81, 17)],
            ),
          ],
        ),
      ],
    );
  }

  // Future<double> _moodCount(String mood) async {
  //   final FirebaseFirestoreService _firestore = FirebaseFirestoreService();
  //   DateTime endDate = DateTime.now();
  //   DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  //   int count = 0, totalCount = 0;

  //   QuerySnapshot querySnapshot =
  //       await _firestore.getMoodData(userEmail, startDate, endDate);
  //   querySnapshot.docs.forEach((doc) {
  //     totalCount++;
  //     if (doc["mood"] == mood) {
  //       count++;
  //     }
  //   });

  //   if (totalCount == 0) {
  //     return 0.0; // Avoid division by zero
  //   }

  //   return count / totalCount;
  // }
}

class PracticeChartSection extends StatefulWidget {
  PracticeChartSection({Key? key}) : super(key: key);

  @override
  _PracticeChartSectionState createState() => _PracticeChartSectionState();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _PracticeChartSectionState extends State<PracticeChartSection> {
  final List<PracticeData> practiceData = [
    PracticeData('Mon', 20, dashboardOrange),
    PracticeData('Tue', 30, dashboardOrange),
    PracticeData('Wed', 10, dashboardOrange),
    PracticeData('Thu', 40, dashboardOrange),
    PracticeData('Fri', 30, dashboardOrange),
    PracticeData('Sat', 0, dashboardOrange),
    PracticeData('Sun', 0, dashboardOrange),
  ];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                Text("Practice Performance",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                // Container(
                //   height: 10,
                //   child: DropdownMenu<String>(
                //     initialSelection: list.first,
                //     onSelected: (String? value) {
                //       setState(() {
                //         dropdownValue = value!;
                //       });
                //     },
                //     dropdownMenuEntries:
                //         list.map<DropdownMenuEntry<String>>((String value) {
                //       return DropdownMenuEntry<String>(
                //           value: value, label: value);
                //     }).toList(),
                //   ),
                // )
              ],
            )),
        Container(
          height: 380, // Adjust this value as needed
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: <Widget>[
                TabBar(
                  overlayColor: MaterialStateProperty.all<Color>(
                      dashboardOrange.withOpacity(0.1)),
                  labelColor: dashboardOrange,
                  indicatorColor: dashboardOrange,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: const [
                    Tab(text: 'Daily'),
                    Tab(text: 'Weekly'),
                    Tab(text: 'Monthly'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Replace these with your actual widgets
                      Container(
                          child: Center(
                        child: SizedBox(
                          height: 200, // Fixed height for the chart
                          child: SfCartesianChart(
                            primaryXAxis: const CategoryAxis(),
                            title: const ChartTitle(
                                text: 'Daily Questions Solved',
                                textStyle: TextStyle(
                                    fontSize: 10)), // Internal Chart Title
                            series: <ColumnSeries<PracticeData, String>>[
                              ColumnSeries<PracticeData, String>(
                                dataSource: practiceData,
                                xValueMapper: (PracticeData data, _) =>
                                    data.day,
                                yValueMapper: (PracticeData data, _) =>
                                    data.questions,
                                pointColorMapper: (PracticeData data, _) =>
                                    data.color,
                                enableTooltip: true,
                              )
                            ],
                          ),
                        ),
                      )),
                      Container(child: Center(child: Text('Weekly'))),
                      Container(child: Center(child: Text('Monthly'))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class MoodData {
  MoodData(this.mood, this.count);
  final String mood;
  final int count;
}

class PracticeData {
  PracticeData(this.day, this.questions, this.color);
  final String day;
  final int questions;
  final Color? color;
}
