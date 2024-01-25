import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:express_all/src/models/prioritySettingExerciseQuestions.dart';
import 'package:express_all/src/controllers/exerciseController.dart';

// We use get package for our state management

class PrioritySettingExerciseController extends ExerciseController {
  late PageController _pageController;
  @override
  PageController get pageController => _pageController;

  final List<PrioritySettingQuestions> _questions = priority_setting_question
      .map(
        (question) => PrioritySettingQuestions(
            id: question['id'],
            question: question['question'],
            subtitle: question['subtitle'],
            explanation: question['explanation'],
            optionImages: question['optionImages'],
            options: question['options'],
            answer: question['answer_sequence']),
      )
      .toList();
  @override
  List<PrioritySettingQuestions> get questions => _questions;

  RxBool _isAnswered = false.obs;
  @override
  bool get isAnswered => _isAnswered.value;

  late List<int> _correctAns;
  @override
  List<int> get correctAns => _correctAns;

  late List<int> _selectedAns;
  @override
  List<int> get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  @override
  RxInt get questionNumber => _questionNumber;

  RxInt _numOfCorrectAns = 0.obs;
  @override
  int get numOfCorrectAns => _numOfCorrectAns.value;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  @override
  void checkAns(dynamic question, dynamic selectedSequence) {
    _isAnswered.value = true;
    _correctAns = question.answer;
    _selectedAns = selectedSequence;
    Logger().i(_correctAns);
    Logger().i(_selectedAns);
    Logger().i(listEquals(_correctAns, _selectedAns));
    if (listEquals(_correctAns, _selectedAns)) _numOfCorrectAns.value++;

    update();
  }

  @override
  void reset() {
    _isAnswered.value = false;
    // _numOfCorrectAns = 0;
    // _pageController.jumpToPage(0);
    // _animationController.reset();
    update();
  }

  @override
  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered.value = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 150), curve: Curves.ease);
    }
  }

  @override
  void previousQuestion() {
    if (_questionNumber.value != 1) {
      _isAnswered.value = false;
      _pageController.previousPage(
          duration: const Duration(milliseconds: 150), curve: Curves.ease);
    }
  }

  @override
  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  @override
  int getAnswerIndex(dynamic question) {
    return question.answer;
  }
}
