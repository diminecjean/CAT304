import 'package:express_all/src/controllers/taskIdentificationExercise_controller.dart';
import 'package:express_all/src/pages/score_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../components/task_identification/body.dart';
import '../../config/style/constants.dart';

class TaskIdentificationPage extends StatelessWidget {
  const TaskIdentificationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'Task Identification',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  'assets/images/task_management/timeline.png',
                  height: 350,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 240, 154, 89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TaskIdentificationExercisePage())),
                    label: const Text(
                      'Start Now',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class TaskIdentificationExercisePage extends StatelessWidget {
  TaskIdentificationExercisePage({Key? key}) : super(key: key);
  final TaskIdentificationExerciseController _questionController =
      Get.put(TaskIdentificationExerciseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Question ${_questionController.questionNumber.value}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: primaryColor)),
              Text(
                  "(${_questionController.questionNumber.value}/${_questionController.questions.length})",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: primaryColor)),
            ],
          ),
        ),
      ),
      body: const Body(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
              ),
              onPressed: _questionController.previousQuestion,
              child: const Text("Back")),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
            ),
            onPressed: () {
              if (_questionController.questionNumber.value !=
                  _questionController.questions.length) {
                Logger().i('Next Question');
                _questionController.nextQuestion();
              } else {
                Logger().i('Score Screen');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScoreScreen(
                              questionType: "TaskIdentification",
                            )));
              }
            },
            child: const Text("Next"),
          )
        ],
      ),
    );
  }
}
