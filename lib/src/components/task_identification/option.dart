import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:express_all/src/controllers/taskIdentificationExercise_controller.dart';

import '../../config/style/constants.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.image,
    required this.index,
    required this.press,
    // required this.color,
  }) : super(key: key);
  final String text;
  final String image;
  final int index;
  final VoidCallback press;
  // final Color color;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskIdentificationExerciseController>(
        init: TaskIdentificationExerciseController(),
        builder: (qnController) {
          Color getTheRightBorderColor() {
            if (qnController.isAnswered) {
              if (qnController.selectedAns.contains(index) &&
                  qnController.correctAns.contains(index)) {
                return greenColor;
              } else if (qnController.selectedAns.contains(index) &&
                  !qnController.correctAns.contains(index)) {
                return redColor;
              } else if (!qnController.selectedAns.contains(index) &&
                  qnController.correctAns.contains(index)) {
                return orangeColor;
              }
            }
            return Colors.black;
          }

          Color getTheRightColor() {
            if (qnController.clickedAns.contains(index)) {
              return secondaryColor;
            } else {
              return Colors.white;
            }
          }

          return InkWell(
            onTap: press,
            child: Container(
              margin: const EdgeInsets.only(top: kDefaultPadding),
              padding: const EdgeInsets.all(kDefaultPadding / 3),
              width: 150,
              decoration: BoxDecoration(
                color: getTheRightColor(),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: getTheRightBorderColor()),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            image,
                            height: 60,
                          ),
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getTheRightBorderColor() == secondaryColor
                                ? primaryColor
                                : getTheRightBorderColor(),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
