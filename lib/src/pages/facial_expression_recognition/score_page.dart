import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/controllers/question_controller.dart';
import 'package:flutter_svg/svg.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.find<QuestionController>();
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              const Spacer(flex: 3),
              const Text("Score"),
              const Spacer(),
              Text(
                "${qnController.correctAns * 10}/${qnController.questions.length * 10}",
              ),
              const Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
