import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:express_all/src/controllers/gestureRecognitionExercise_controller.dart';
import 'package:express_all/src/models/gestureRecognitionExerciseQuestions.dart';

import '../../config/style/constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);

  final GestureRecognitionExerciseQuestions question;

  @override
  Widget build(BuildContext context) {
    GestureRecognitionExerciseController controller =
        Get.put(GestureRecognitionExerciseController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: kDefaultPadding / 2),
            width: double.infinity,
            color: Colors.white,
            child: Image.asset(
              question.image,
              height: 200,
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
          const SizedBox(height: kDefaultPadding / 3),
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () {
                if (!controller.isAnswered) {
                  controller.checkAns(question, index);
                }
              },
            ),
          ),
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
      content: Text(
        content,
        style: const TextStyle(color: primaryColor),
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
