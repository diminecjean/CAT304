import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:express_all/src/components/custom_dropdown.dart';
import 'package:express_all/src/components/toast.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/services/auth/firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
              height: 360,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PracticeChartSection(
                userEmail: userEmail,
              ),
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
      case 'Normal':
        return "I feel neutral. 😀";
      default:
        return "I don't know how I'm feeling today...";
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
      case 'Normal':
        return Color(0xFF86C9FF);
      default:
        return secondaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    Logger().i('User email: $userEmail');
    DateTime timestamp = DateTime.now();
    DateTime startOfDay =
        DateTime(timestamp.year, timestamp.month, timestamp.day);
    DateTime startOfNextDay = startOfDay.add(Duration(days: 1));

    Logger().i('startOfDay: ${Timestamp.fromDate(startOfDay)}');
    Logger().i('startOfNextDay: ${Timestamp.fromDate(startOfNextDay)}');
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
          Logger().e('Error: ${snapshot.error}');
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

          final docs = snapshot.data!.docs;
          final anyFulfillsCondition = docs.any((document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return data['dateTime']
                        .compareTo(Timestamp.fromDate(startOfNextDay)) <
                    0 &&
                data['dateTime'].compareTo(Timestamp.fromDate(startOfDay)) >= 0;
          });

          if (anyFulfillsCondition) {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  Logger().i('Data: $data');
                  Logger().i('dateTime: ${data['dateTime']}');
                  return (data['dateTime'].compareTo(
                                  Timestamp.fromDate(startOfNextDay)) <
                              0 &&
                          data['dateTime']
                                  .compareTo(Timestamp.fromDate(startOfDay)) >=
                              0)
                      ? Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/menu_5_profile_pic.png",
                                    height: 60,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    data['username'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  BubbleSpecialTwo(
                                    text: getTextBasedOnMood(
                                      data['mood'],
                                    ),
                                    isSender: false,
                                    color: getColorBasedOnMood(data['mood']),
                                    tail: true,
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color:
                                          const Color.fromARGB(255, 82, 64, 64),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                      DateTime.now()
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.grey)),
                                ],
                              )
                            ],
                          ))
                      : Container();
                }).toList(),
              ),
            );
          } else {
            // If no document fulfills the condition, return a single Container
            // that contains the error message
            final firstDocument = snapshot.data!.docs.first;
            Map<String, dynamic> data =
                firstDocument.data() as Map<String, dynamic>;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/menu_5_profile_pic.png",
                          height: 60,
                        ),
                        SizedBox(width: 10),
                        Text(
                          data['username'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        BubbleSpecialTwo(
                          text: "I don't know how\n I'm feeling today...",
                          isSender: false,
                          color: secondaryColor,
                          tail: true,
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 82, 64, 64),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(DateTime.now().toString().substring(0, 10),
                            style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
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
    final FirebaseFirestoreService _firestore = FirebaseFirestoreService();
    DateTime endDate = DateTime.now();
    DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
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
            FutureBuilder<double>(
              future: _firestore.getMoodCount("Happy", userEmail, startDate,
                  endDate), // your Future function
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // or some other widget while waiting
                } else {
                  if (snapshot.hasError) {
                    Logger().e('Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return VerticalBarIndicator(
                      width: 20,
                      height: 60,
                      percent:
                          snapshot.data!, // use the data from the Future here
                      header: '😁',
                      footer: 'Happy',
                      color: [
                        Color.fromARGB(173, 60, 232, 97),
                        Color.fromARGB(255, 79, 197, 104)
                      ],
                    );
                  }
                }
              },
            ),
            SizedBox(width: 20),
            FutureBuilder<double>(
              future: _firestore.getMoodCount("Angry", userEmail, startDate,
                  endDate), // your Future function
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // or some other widget while waiting
                } else {
                  if (snapshot.hasError) {
                    Logger().e('Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return VerticalBarIndicator(
                      width: 20,
                      height: 60,
                      percent:
                          snapshot.data!, // use the data from the Future here
                      header: '😡',
                      footer: 'Angry',
                      color: [
                        Color.fromARGB(141, 255, 33, 17),
                        Color.fromARGB(193, 181, 35, 24),
                      ],
                    );
                  }
                }
              },
            ),
            SizedBox(width: 20),
            FutureBuilder<double>(
              future: _firestore.getMoodCount("Normal", userEmail, startDate,
                  endDate), // your Future function
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // or some other widget while waiting
                } else {
                  if (snapshot.hasError) {
                    Logger().e('Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return VerticalBarIndicator(
                      width: 20,
                      height: 60,
                      percent: snapshot.data!,
                      header: '😀',
                      footer: 'Neutral',
                      color: [
                        Color.fromARGB(204, 54, 134, 255),
                        Color.fromARGB(204, 38, 103, 200),
                      ],
                    );
                  }
                }
              },
            ),
            SizedBox(width: 20),
            FutureBuilder<double>(
              future: _firestore.getMoodCount(
                  "Sad", userEmail, startDate, endDate), // your Future function
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // or some other widget while waiting
                } else {
                  if (snapshot.hasError) {
                    Logger().e('Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return VerticalBarIndicator(
                      width: 20,
                      height: 60,
                      header: '😢',
                      footer: 'Sad',
                      percent:
                          snapshot.data!, // use the data from the Future here
                      color: [
                        Color(0xC5FF5E00),
                        Color.fromARGB(197, 192, 81, 17)
                      ],
                    );
                  }
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class PracticeChartSection extends StatefulWidget {
  final String userEmail;
  PracticeChartSection({Key? key, required this.userEmail}) : super(key: key);

  @override
  _PracticeChartSectionState createState() => _PracticeChartSectionState();
}

class _PracticeChartSectionState extends State<PracticeChartSection> {
  final FirebaseFirestoreService _firestore = FirebaseFirestoreService();
  List<PracticeData> dailyData = [];
  List<PracticeData> weeklyData = [];
  List<PracticeData> monthlyData = [];
  String? exerciseType = "FacialExpression";

  @override
  void initState() {
    super.initState();
    getDailyAverageScores();
    getWeeklyAverageScores();
    getMonthlyAverageScores();
  }

  void getDailyAverageScores() async {
    dailyData.clear();
    Map<String, String> daysOfWeek = {
      'Monday': 'Mon',
      'Tuesday': 'Tue',
      'Wednesday': 'Wed',
      'Thursday': 'Thu',
      'Friday': 'Fri',
      'Saturday': 'Sat',
      'Sunday': 'Sun'
    };
    Logger().i('exerciseType: $exerciseType, email: ${widget.userEmail}');
    for (var day in daysOfWeek.keys) {
      double score = await _firestore.getDailyAverageScore(
        widget.userEmail,
        Timestamp.fromDate(DateTime.now()),
        day,
        exerciseType!,
      );
      setState(() {
        dailyData.add(PracticeData(daysOfWeek[day]!, score, dashboardOrange));
      });
    }
  }

  void getWeeklyAverageScores() async {
    weeklyData.clear();
    Logger().i('exerciseType: $exerciseType, email: ${widget.userEmail}');
    List<double> scores = await _firestore.getWeeklyAverageScores(
      widget.userEmail,
      Timestamp.fromDate(DateTime.now()),
      exerciseType!,
    );
    for (int i = 0; i < scores.length; i++) {
      // if (i == scores.length - 1) {
      //   setState(() {
      //     weeklyData
      //         .add(PracticeData('Current Week', scores[i], dashboardOrange));
      //   });
      // } else {
      setState(() {
        weeklyData
            .add(PracticeData('Week ${i + 1}', scores[i], dashboardOrange));
      });
      // }
    }
  }

  void getMonthlyAverageScores() async {
    monthlyData.clear();
    Logger().i('exerciseType: $exerciseType, email: ${widget.userEmail}');
    List<double> scores = await _firestore.getMonthlyAverageScores(
      widget.userEmail,
      Timestamp.fromDate(DateTime.now()),
      exerciseType!,
    );
    for (int i = 0; i < scores.length; i++) {
      // if (i == scores.length - 1) {
      //   setState(() {
      //     monthlyData
      //         .add(PracticeData('Current Month', scores[i], dashboardOrange));
      //   });
      // } else {
      setState(() {
        monthlyData.add(PracticeData('${i + 1}', scores[i], dashboardOrange));
      });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Practice \nPerformance",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                CustomDropdown<int>(
                  child: Text(
                    'Face Expression',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  onChange: (int value, int index) {
                    setState(() {
                      exerciseType = [
                        'FacialExpression',
                        'GestureRecognition',
                        'TaskIdentification',
                        'TaskSequencing',
                        'PrioritySetting',
                      ][index];
                      getDailyAverageScores();
                      getWeeklyAverageScores();
                      getMonthlyAverageScores();
                    });
                    print(exerciseType);
                  },
                  dropdownButtonStyle: DropdownButtonStyle(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    width: 140,
                    height: 40,
                    elevation: 1,
                    backgroundColor: Colors.white,
                    primaryColor: Colors.black87,
                  ),
                  dropdownStyle: DropdownStyle(
                    borderRadius: BorderRadius.circular(2),
                    elevation: 6,
                    padding: const EdgeInsets.all(2),
                  ),
                  items: [
                    'Face Expression',
                    'Gesture Recognition',
                    'Task Identification',
                    'Task Sequencing',
                    'Priority Setting',
                  ]
                      .asMap()
                      .entries
                      .map(
                        (item) => DropdownItem<int>(
                          value: item.key + 1,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(item.value,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10)),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            )),
        Container(
          height: 250, // Adjust this value as needed
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
                          child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              height: 180, // Fixed height for the chart
                              child: SfCartesianChart(
                                primaryXAxis: const CategoryAxis(),
                                title: const ChartTitle(
                                    text: 'Daily Average Score',
                                    textStyle: TextStyle(
                                        fontSize: 10)), // Internal Chart Title
                                series: <ColumnSeries<PracticeData, String>>[
                                  ColumnSeries<PracticeData, String>(
                                      dataSource: dailyData,
                                      xValueMapper: (PracticeData data, _) =>
                                          data.day,
                                      yValueMapper: (PracticeData data, _) =>
                                          data.score,
                                      pointColorMapper:
                                          (PracticeData data, _) => data.color,
                                      enableTooltip: true,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true))
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                      Container(
                          child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              height: 180, // Fixed height for the chart
                              child: SfCartesianChart(
                                primaryXAxis: const CategoryAxis(),
                                title: const ChartTitle(
                                    text: 'Weekly Average Score',
                                    textStyle: TextStyle(
                                        fontSize: 10)), // Internal Chart Title
                                series: <ColumnSeries<PracticeData, String>>[
                                  ColumnSeries<PracticeData, String>(
                                    dataSource: weeklyData,
                                    xValueMapper: (PracticeData data, _) =>
                                        data.day,
                                    yValueMapper: (PracticeData data, _) =>
                                        data.score,
                                    pointColorMapper: (PracticeData data, _) =>
                                        data.color,
                                    enableTooltip: true,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                      Container(
                          child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              height: 180, // Fixed height for the chart
                              child: SfCartesianChart(
                                primaryXAxis: const CategoryAxis(),
                                title: const ChartTitle(
                                    text: 'Monthly Average Score',
                                    textStyle: TextStyle(
                                        fontSize: 10)), // Internal Chart Title
                                series: <ColumnSeries<PracticeData, String>>[
                                  ColumnSeries<PracticeData, String>(
                                    dataSource: monthlyData,
                                    xValueMapper: (PracticeData data, _) =>
                                        data.day,
                                    yValueMapper: (PracticeData data, _) =>
                                        data.score,
                                    pointColorMapper: (PracticeData data, _) =>
                                        data.color,
                                    enableTooltip: true,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Center(
            child: TextButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: dashboardOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        18.0), // Rounded corners for the button
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PracticeDetails(userEmail: widget.userEmail)),
                  );
                },
                child: Text('View Details')))
      ],
    ));
  }
}

class PracticeDetails extends StatefulWidget {
  final String userEmail;
  // final String exerciseType;

  PracticeDetails({required this.userEmail});

  @override
  _PracticeDetailsState createState() => _PracticeDetailsState();
}

class _PracticeDetailsState extends State<PracticeDetails> {
  final FirebaseFirestoreService _firestore = FirebaseFirestoreService();
  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    fillChartData();
  }

  void fillChartData() async {
    List<String> exerciseTypes = [
      'FacialExpression',
      'GestureRecognition',
      'TaskIdentification',
      'TaskSequencing',
      'PrioritySetting'
    ];

    List<ChartData> data = [];

    for (String exerciseType in exerciseTypes) {
      double averageCount = await _firestore.getExerciseAverageCount(
          widget.userEmail, exerciseType);
      Logger().i("average count: $averageCount");
      data.add(ChartData(exerciseType, averageCount));
    }

    setState(() {
      chartData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Practice Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Brendan's Progress",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )),
                      Text("Practice Done 5/5",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearPercentIndicator(
                      width: 292.0,
                      lineHeight: 18.0,
                      percent: 1,
                      // center: Text(
                      //   "50.0%",
                      //   style: TextStyle(fontSize: 12.0),
                      // ),
                      barRadius: Radius.circular(20),
                      backgroundColor: Colors.grey,
                      progressColor: dashboardOrange),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("National Average",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )),
                      Text("Practice Done 3/5",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearPercentIndicator(
                      width: 292.0,
                      lineHeight: 18.0,
                      percent: 0.85,
                      // center: Text(
                      //   "50.0%",
                      //   style: TextStyle(fontSize: 12.0),
                      // ),
                      barRadius: Radius.circular(20),
                      backgroundColor: Colors.grey,
                      progressColor: dashboardOrange),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Distribution of Answered Exercises",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            const SizedBox(height: 10),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: SizedBox(
                    height: 430,
                    child: SfCircularChart(
                      series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) =>
                                data.exerciseType,
                            yValueMapper: (ChartData data, _) => data.count,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.inside,
                              useSeriesColor: true,
                            ),
                            // Segments will explode on tap
                            explode: true,
                            // First segment will be exploded on initial rendering
                            explodeIndex: 1)
                      ],
                      backgroundColor: const Color.fromARGB(46, 255, 255, 255),
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                        orientation: LegendItemOrientation.vertical,
                        height: '100',
                      ),
                    )))
          ],
        ));
  }
}

class ChartData {
  ChartData(this.exerciseType, this.count);

  final String exerciseType;
  final double count;
}

class MoodData {
  MoodData(this.mood, this.count);
  final String mood;
  final int count;
}

class PracticeData {
  PracticeData(this.day, this.score, this.color);
  final String day;
  final double score;
  final Color? color;
}
