import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:express_all/src/models/taskSequencingExerciseQuestions.dart';
import 'package:express_all/src/controllers/exerciseController.dart';

// We use get package for our state management

class TaskSequencingExerciseController extends ExerciseController {
  late PageController _pageController;
  @override
  PageController get pageController => _pageController;

  final List<TaskSequencingQuestions> _questions = task_sequencing_question
      .map(
        (question) => TaskSequencingQuestions(
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
  List<TaskSequencingQuestions> get questions => _questions;

  final RxBool _isAnswered = false.obs;
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

  final RxInt _numOfCorrectAns = 0.obs;
  @override
  int get numOfCorrectAns => _numOfCorrectAns.value;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  // called just before the Controller is deleted from memory
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
    Logger().i("Correct ans: $_correctAns");
    Logger().i("Selected ans: $_selectedAns");
    Logger().i(listEquals(_correctAns, _selectedAns));
    if (listEquals(_correctAns, _selectedAns)) _numOfCorrectAns.value++;
    Logger().i(_numOfCorrectAns);
    update();
  }

  @override
  void reset() {
    _isAnswered.value = false;
    _numOfCorrectAns.value = 0;
    _questionNumber.value = 1;
    _pageController = PageController();
    Logger().i("Task Sequencing controller resetting");
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
