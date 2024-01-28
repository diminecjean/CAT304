import 'package:express_all/src/components/task_sequencing/option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:express_all/src/controllers/taskSequencingExercise_controller.dart';
import 'package:express_all/src/models/taskSequencingExerciseQuestions.dart';
import 'package:reorderables/reorderables.dart';
import '../../config/style/constants.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final TaskSequencingQuestions question;

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  List<int> selectedSequence = [];
  late List<Widget> _options;

  @override
  void initState() {
    super.initState();
    _options = List<Widget>.generate(
      widget.question.options.length,
      (index) => Option(
        index: index,
        image: widget.question.optionImages[index],
        text: widget.question.options[index],
      ),
    );
    selectedSequence =
        List<int>.generate(widget.question.options.length, (index) => index);
  }

  @override
  Widget build(BuildContext context) {
    void onReorder(int oldIndex, int newIndex) {
      setState(() {
        // reorder the position of the moved widget
        Widget row = _options.removeAt(oldIndex);
        _options.insert(newIndex, row);
        // update the sequence of the selected answer
        final int removedItem = selectedSequence.removeAt(oldIndex);
        selectedSequence.insert(newIndex, removedItem);
      });
    }

    var wrap = ReorderableWrap(
        spacing: 8.0,
        runSpacing: 4.0,
        padding: const EdgeInsets.all(8),
        onReorder: onReorder,
        onNoReorder: (int index) {
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
        },
        onReorderStarted: (int index) {
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
          debugPrint(_options.toString());
        },
        children: _options);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TaskSequencingExerciseController controller =
        Get.put(TaskSequencingExerciseController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: kDefaultPadding / 3,
                          right: kDefaultPadding / 3),
                      child: Text(
                        widget.question.question,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: kDefaultPadding,
                          left: kDefaultPadding / 3,
                          right: kDefaultPadding / 3),
                      child: Text(
                        widget.question.subtitle,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => TextButton(
                    onPressed: controller.isAnswered
                        ? () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => _dialogBox(
                                  context,
                                  content: widget.question.explanation),
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
          ),
          SizedBox(
            height: screenHeight * 0.6,
            width: screenWidth * 0.95,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: wrap,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
                  onPressed: () => controller.reset(),
                  child: const Text("Restart",
                      style: TextStyle(color: Colors.white))),
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
                      controller.checkAns(widget.question, selectedSequence);

                      Future.delayed(const Duration(seconds: 1), () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => _dialogBox(
                                context,
                                content: widget.question.explanation));
                      });
                    }
                  },
                  child: const Text("Submit",
                      style: TextStyle(color: Colors.white))),
            ],
          )
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
          const Text(
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
