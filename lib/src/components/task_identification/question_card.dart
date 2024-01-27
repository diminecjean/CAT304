import 'package:express_all/src/components/task_identification/option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:express_all/src/controllers/taskIdentificationExercise_controller.dart';
import 'package:express_all/src/models/taskIdentificationExerciseQuestions.dart';

import '../../config/style/constants.dart';

class QuestionCard extends StatelessWidget {
  QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final TaskIdentificationQuestions question;
  final List<int> selectedAns = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TaskIdentificationExerciseController controller =
        Get.put(TaskIdentificationExerciseController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Image.asset(
              question.image,
              height: 150,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                  top: kDefaultPadding,
                  left: kDefaultPadding / 3,
                  right: kDefaultPadding / 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      question.question,
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Obx(() => TextButton(
                        onPressed: controller.isAnswered
                            ? () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => _dialogBox(
                                      context,
                                      content: question.explanation),
                                );
                              }
                            : () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => _dialogBox(
                                      context,
                                      content:
                                          "Select an answer first to get some explanation ✨"),
                                );
                              },
                        child: const Icon(
                          Icons.lightbulb_circle,
                          color: primaryColor,
                          size: 30,
                        ),
                      ))
                ],
              )),
          SizedBox(
            height: screenHeight * 0.45,
            width: screenWidth * 0.9,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: kDefaultPadding / 3,
                children: List.generate(
                  question.options.length,
                  (index) => Option(
                    index: index,
                    image: question.optionImages[index],
                    text: question.options[index],
                    press: () {
                      selectedAns.add(index);
                      controller.onClick(index);
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 240, 154, 89)),
                elevation: MaterialStateProperty.all<double>(2),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                if (!controller.isAnswered) {
                  controller.checkAns(question, selectedAns);

                  Future.delayed(const Duration(seconds: 1), () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            _dialogBox(context, content: question.explanation));
                  });
                }
              },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }

  Widget _dialogBox(
    BuildContext context, {
    required String content,
  }) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: const Text(
        'Explanation 💡',
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "🔴Red: Wrongly Selected\n🟢Green: Correctly Selected\n🔵Blue: Correct Answer that should be selected.",
            style: TextStyle(
                color: Color(0xFF7C7C7C),
                fontSize: 10.0,
                fontWeight: FontWeight.w300),
          ),
          Text(
            content,
            style: const TextStyle(color: primaryColor),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK', style: TextStyle(color: primaryColor)),
        ),
      ],
    );
  }
}
