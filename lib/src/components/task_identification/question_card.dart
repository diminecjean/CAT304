import 'package:express_all/src/components/task_identification/option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:express_all/src/controllers/taskIdentificationExercise_controller.dart';
import 'package:express_all/src/models/taskIdentificationQuestions.dart';

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
            padding: EdgeInsets.only(
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
          ElevatedButton(
              onPressed: () => controller.checkAns(question, selectedAns),
              child: const Text("Submit")),
        ],
      ),
    );
  }
}
