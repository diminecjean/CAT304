import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:express_all/src/controllers/prioritySettingExercise_controller.dart';

import '../../config/style/constants.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.image,
    required this.index,
  }) : super(key: key);
  final String text;
  final String image;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrioritySettingExerciseController>(
        init: PrioritySettingExerciseController(),
        builder: (qnController) {
          Color getTheRightBorderColor() {
            if (qnController.isAnswered) {
              if (qnController.selectedAns[index] ==
                  qnController.correctAns[index]) {
                return greenColor;
              } else {
                return redColor;
              }
            }
            return Colors.black;
          }

          return InkWell(
            // onTap: press,
            child: Container(
              margin: const EdgeInsets.only(top: kDefaultPadding / 2),
              padding: const EdgeInsets.all(kDefaultPadding / 3),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: getTheRightBorderColor() == Colors.black
                        ? Colors.transparent
                        : getTheRightBorderColor()),
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
                          padding: const EdgeInsets.all(0),
                          child: Image.asset(
                            image,
                            height: 100,
                          ),
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getTheRightBorderColor() == secondaryColor
                                ? primaryColor
                                : getTheRightBorderColor(),
                            fontSize: 16,
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
