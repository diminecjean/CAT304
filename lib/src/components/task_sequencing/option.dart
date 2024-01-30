import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:express_all/src/controllers/taskSequencingExercise_controller.dart';
import 'package:logger/logger.dart';

import '../../config/style/constants.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.image,
    required this.index,
    // required this.sequence,
  }) : super(key: key);
  final String text;
  final String image;
  final int index;
  // final int sequence;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskSequencingExerciseController>(
        init: TaskSequencingExerciseController(),
        builder: (qnController) {
          Color getTheRightBorderColor() {
            if (qnController.isAnswered) {
              // Logger().i("sequence: $sequence, index: $index");
              Logger()
                  .i("selectedAns $index: ${qnController.selectedAns[index]}");
              Logger()
                  .i("correctAns $index: ${qnController.correctAns[index]}");
              Logger().i(
                  "Index $index : Compare ${qnController.correctAns[qnController.selectedAns[index]]}");
              Logger().i(
                  "compared : ${qnController.correctAns[qnController.selectedAns[index]] == index}");
              if (index ==
                  qnController.correctAns[qnController.selectedAns[index]]) {
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
              margin: const EdgeInsets.only(top: kDefaultPadding),
              padding: const EdgeInsets.all(kDefaultPadding / 3),
              width: 140,
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
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            image,
                            height: 70,
                          ),
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getTheRightBorderColor() == secondaryColor
                                ? primaryColor
                                : getTheRightBorderColor(),
                            fontSize: 11,
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
