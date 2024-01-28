import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Report'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // User info and mood chart
            UserInfoSection(),
            MoodChartSection(),
            // Practice chart
            PracticeChartSection(),
          ],
        ),
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    // This section contains the user info, like the name and profile picture
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            child: Icon(Icons.child_care),
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

  MoodChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment
          .stretch, // Ensure the title stretches to the width of the chart
      mainAxisSize:
          MainAxisSize.min, // To control the space that the Column occupies
      children: [
        const Text(
          'Mood Chart',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, // Center align the text
        ),
        const SizedBox(
            height: 8), // Add some space between the text and the chart
        SizedBox(
          height: 200, // Fixed height for the chart
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            title: const ChartTitle(text: 'Weekly Mood'), // Chart title
            series: <ColumnSeries<MoodData, String>>[
              // Renders bar chart
              ColumnSeries<MoodData, String>(
                dataSource: moodData,
                xValueMapper: (MoodData data, _) => data.mood,
                yValueMapper: (MoodData data, _) => data.count,
              )
            ],
          ),
        ),
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

  PracticeChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Practice Chart',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 200, // Fixed height for the chart
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            title: const ChartTitle(
                text: 'Daily Questions Solved'), // Internal Chart Title
            series: <ColumnSeries<PracticeData, String>>[
              ColumnSeries<PracticeData, String>(
                dataSource: practiceData,
                xValueMapper: (PracticeData data, _) => data.day,
                yValueMapper: (PracticeData data, _) => data.questions,
                enableTooltip: true,
              )
            ],
          ),
        ),
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
