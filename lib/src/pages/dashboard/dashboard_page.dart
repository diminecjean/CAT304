import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Report'),
      ),
      body: Column(
        children: <Widget>[
          // User info and mood chart
          UserInfoSection(),
          MoodChartSection(),
          // Practice chart
          PracticeChartSection(),
        ],
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This section contains the user info, like the name and profile picture
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            child: Icon(Icons.child_care),
            radius: 30,
          ),
          SizedBox(width: 16),
          Text(
            'Brendan',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class MoodChartSection extends StatelessWidget {
  // Dummy data for the mood chart
  final List<MoodData> moodData = [
    MoodData('Happy', 5),
    MoodData('Angry', 1),
    MoodData('Neutral', 2),
    MoodData('Sad', 1),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        // Renders bar chart
        ColumnSeries<MoodData, String>(
          dataSource: moodData,
          xValueMapper: (MoodData data, _) => data.mood,
          yValueMapper: (MoodData data, _) => data.count,
        )
      ],
    );
  }
}

class PracticeChartSection extends StatelessWidget {
  // Dummy data for the practice chart
  final List<PracticeData> practiceData = [
    PracticeData('Mon', 20),
    PracticeData('Tue', 30),
    PracticeData('Wed', 10),
    PracticeData('Thu', 40),
    PracticeData('Fri', 30),
    PracticeData('Sat', 0),
    PracticeData('Sun', 0),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        // Renders column chart
        ColumnSeries<PracticeData, String>(
          dataSource: practiceData,
          xValueMapper: (PracticeData data, _) => data.day,
          yValueMapper: (PracticeData data, _) => data.questions,
          // Enables the tooltip
          enableTooltip: true,
        )
      ],
    );
  }
}

class MoodData {
  MoodData(this.mood, this.count);
  final String mood;
  final int count;
}

class PracticeData {
  PracticeData(this.day, this.questions);
  final String day;
  final int questions;
}
