import 'package:express_all/src/components/quiz/body.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/controllers/question_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  'assets/images/facial_expression-1.png',
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

// class FacialExpressionExercise extends StatefulWidget {
//   const FacialExpressionExercise({Key? key}) : super(key: key);
//   @override
//   _FacialExpressionExerciseState createState() =>
//       _FacialExpressionExerciseState();
// }

// class _FacialExpressionExerciseState extends State<FacialExpressionExercise> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Facial Expression Identification'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: const EdgeInsets.all(20),
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: <Widget>[
//               Text(
//                 'Facial Expression Identification',
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: Theme.of(context).primaryColor),
//                 textAlign: TextAlign.center,
//               ),
//               Image.asset(
//                 'assets/images/facial_expression-1.png',
//                 height: 350,
//               ),
//               Text(
//                 'What is the facial expression of the person in the picture?',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Theme.of(context).primaryColor),
//                 textAlign: TextAlign.center,
//               ),
//               Text(
//                 'Choose the correct answer from the options below.',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Theme.of(context).primaryColor),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class FacialExpressionExercisePage extends StatelessWidget {
  const FacialExpressionExercisePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Question ${_questionController.questionNumber.value}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: primaryColor)),
              Text(
                  "(${_questionController.questionNumber.value}/${_questionController.questions.length})",
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
              onPressed: _questionController.previousQuestion,
              child: const Text("Back")),
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
              ),
              onPressed: _questionController.nextQuestion,
              child: const Text("Next")),
        ],
      ),
    );
  }
}
