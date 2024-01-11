import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:express_all/src/models/taskIdentificationQuestions.dart';

// We use get package for our state management

class TaskIdentificationExerciseController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  final List<TaskIdentificationQuestions> _questions =
      task_identification_question
          .map(
            (question) => TaskIdentificationQuestions(
                id: question['id'],
                image: question['image'],
                question: question['question'],
                optionImages: question['optionImages'],
                options: question['options'],
                answer: question['answer_index']),
          )
          .toList();
  List<TaskIdentificationQuestions> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late List<int> _correctAns;
  List<int> get correctAns => _correctAns;

  late List<int> _selectedAns;
  List<int> get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(TaskIdentificationQuestions question, List<int> selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;
    _selectedAns.sort();
    Logger().i(_correctAns);
    Logger().i(_selectedAns);
    Logger().i(listEquals(_correctAns, _selectedAns));
    if (listEquals(_correctAns, _selectedAns)) _numOfCorrectAns++;

    // It will stop the counter
    _animationController.stop();
    update();
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 150), curve: Curves.ease);
    }
  }

  void previousQuestion() {
    if (_questionNumber.value != 1) {
      _isAnswered = false;
      _pageController.previousPage(
          duration: const Duration(milliseconds: 150), curve: Curves.ease);
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
