import 'package:express_all/src/config/style/constants.dart';
import 'package:flutter/material.dart';

class TaskManagementPage extends StatelessWidget {
  const TaskManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Management Practice',
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Task Identification
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/TaskIdentification");
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    leading: Image.asset(
                      'assets/images/task_management/task_identification.png',
                    ),
                    title: const Text(
                      'Task Identification',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                    subtitle: const Text(
                      'Identify tasks within a list of activities of a given scenario.',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Task Sequencing
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/TaskSequencing");
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    leading: Image.asset(
                      'assets/images/task_management/task_sequencing.png',
                    ),
                    title: const Text(
                      'Task Sequencing',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                    subtitle: const Text(
                      'Sequence tasks in a given scenario based on their order.',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Priority Setting
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/PrioritySetting");
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    leading: Image.asset(
                      'assets/images/task_management/priority_setting.png',
                    ),
                    title: const Text(
                      'Priority Setting',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                    subtitle: const Text(
                      'Prioritize tasks in a given scenario based on their importance.',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
