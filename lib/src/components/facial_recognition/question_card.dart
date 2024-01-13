import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:express_all/src/controllers/faceExpressionExercise_controller.dart';
import 'package:express_all/src/models/faceExpressionExerciseQuestions.dart';

import '../../config/style/constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);

  final FaceExpressionExerciseQuestions question;

  @override
  Widget build(BuildContext context) {
    FaceExpressionExerciseController controller =
        Get.put(FaceExpressionExerciseController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      // decoration: BoxDecoration(
      //   color: Colors.transparent,
      //   borderRadius: BorderRadius.circular(25),
      // ),
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
            child: Text(
              question.question,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding / 3),
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () => controller.checkAns(question, index),
            ),
          ),
        ],
      ),
    );
  }
}
