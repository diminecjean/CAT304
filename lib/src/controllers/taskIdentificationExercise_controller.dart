import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:express_all/src/models/taskIdentificationExerciseQuestions.dart';
import 'package:express_all/src/controllers/exerciseController.dart';
// We use get package for our state management

class TaskIdentificationExerciseController extends ExerciseController {
  late PageController _pageController;
  @override
  PageController get pageController => _pageController;

  final List<TaskIdentificationQuestions> _questions =
      task_identification_question
          .map(
            (question) => TaskIdentificationQuestions(
                id: question['id'],
                image: question['image'],
                question: question['question'],
                explanation: question['explanation'],
                optionImages: question['optionImages'],
                options: question['options'],
                answer: question['answer_index']),
          )
          .toList();
  @override
  List<TaskIdentificationQuestions> get questions => _questions;

  final RxBool _isAnswered = false.obs;
  @override
  bool get isAnswered => _isAnswered.value;

  final List<int> _clickedAns = <int>[];
  List<int> get clickedAns => _clickedAns;

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

  void onClick(int index) {
    if (_clickedAns.contains(index)) {
      _clickedAns.remove(index);
    } else {
      _clickedAns.add(index);
    }
    update();
  }

  @override
  void checkAns(dynamic question, dynamic selectedIndex) {
    _clickedAns.clear();
    _isAnswered.value = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;
    _selectedAns.sort();
    Logger().i(_correctAns);
    Logger().i(_selectedAns);
    Logger().i(listEquals(_correctAns, _selectedAns));
    if (listEquals(_correctAns, _selectedAns)) _numOfCorrectAns.value++;

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
  void reset() {
    _isAnswered.value = false;
    _questionNumber.value = 1;
    _numOfCorrectAns.value = 0;
    _pageController = PageController();
    Logger().i("Task Identification controller resetting");
    update();
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
