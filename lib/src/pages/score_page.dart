import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/controllers/exerciseController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:express_all/src/controllers/faceExpressionExercise_controller.dart';
import 'package:express_all/src/controllers/prioritySettingExercise_controller.dart';
import 'package:express_all/src/controllers/taskIdentificationExercise_controller.dart';
import 'package:express_all/src/controllers/taskSequencingExercise_controller.dart';
import 'package:logger/logger.dart';

class ScoreScreen extends StatefulWidget {
  final String questionType;
  const ScoreScreen({Key? key, required this.questionType}) : super(key: key);

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late ExerciseController controller;

  @override
  void initState() {
    super.initState();
    if (widget.questionType == "FacialExpression") {
      controller = Get.put(FaceExpressionExerciseController());
    } else if (widget.questionType == "TaskIdentification") {
      controller = Get.put(TaskIdentificationExerciseController());
    } else if (widget.questionType == "TaskSequencing") {
      controller = Get.put(TaskSequencingExerciseController());
    } else if (widget.questionType == "PrioritySetting") {
      controller = Get.put(PrioritySettingExerciseController());
    } else {
      controller = Get.put(FaceExpressionExerciseController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseController>(
        init: controller,
        builder: (qnController) {
          String getTheRightHeader() {
            String header = "";
            double score =
                qnController.numOfCorrectAns / qnController.questions.length;
            if (score < 0.3) {
              header = "Room for Improvement~";
            } else if (score < 0.7) {
              header = "Well Done Buddy!";
            } else {
              header = "Great Job There!";
            }
            return header;
          }

          String getTheRightImage() {
            String image = "";
            Logger().i(qnController.numOfCorrectAns);
            double score =
                qnController.numOfCorrectAns / qnController.questions.length;
            if (score < 0.3) {
              image = "assets/images/score_page/1-star.png";
            } else if (score < 0.7) {
              image = "assets/images/score_page/2-star.png";
            } else {
              image = "assets/images/score_page/3-star.png";
            }
            return image;
          }

          return Scaffold(
            appBar: AppBar(),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          getTheRightHeader(),
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                        const SizedBox(height: 30),
                        Image.asset(
                          getTheRightImage(),
                          height: 120,
                        ),
                        Text(
                          "Your score is ${qnController.numOfCorrectAns} out of ${qnController.questions.length}",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: primaryColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: orangeColor,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  fixedSize: const Size(280, 65),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                              onPressed: () =>
                                  {debugPrint("Next stage to be developed")},
                              child: const Text(
                                "Next Stage",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: orangeColor,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  fixedSize: const Size(280, 65),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                              onPressed: () {
                                qnController.reset();
                              },
                              child: const Text(
                                "Play Again",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: orangeColor,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  fixedSize: const Size(280, 65),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                              onPressed: () {
                                Navigator.pushNamed(context, "/MainMenu");
                              },
                              child: const Text(
                                "Main Menu",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }
}
