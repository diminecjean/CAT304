import 'package:express_all/src/components/facial_recognition/body.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/controllers/faceExpressionExercise_controller.dart';
import 'package:express_all/src/pages/score_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class FacialExpressionPage extends StatelessWidget {
  const FacialExpressionPage({super.key});

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
                  'Facial Expression Identification Practice',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  'assets/images/emotion_gesture_recognition/facial_expression-1.png',
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
                                const FacialExpressionExercisePage())),
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

class FacialExpressionExercisePage extends StatelessWidget {
  const FacialExpressionExercisePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FaceExpressionExerciseController questionController =
        Get.put(FaceExpressionExerciseController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Questions ${questionController.questionNumber.value}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: primaryColor)),
              Text(
                  "(${questionController.questionNumber.value}/${questionController.questions.length})",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: primaryColor)),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Body(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
              ),
              onPressed: questionController.previousQuestion,
              child: const Text("Back")),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
            ),
            onPressed: () {
              if (questionController.questionNumber.value !=
                  questionController.questions.length) {
                Logger().i('Next Question');
                questionController.nextQuestion();
              } else {
                Logger().i('Score Screen');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScoreScreen(
                              questionType: "FacialExpression",
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
