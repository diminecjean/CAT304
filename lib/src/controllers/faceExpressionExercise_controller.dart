import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:express_all/src/models/faceExpressionExerciseQuestions.dart';
import 'package:express_all/src/controllers/exerciseController.dart';

// We use get package for our state management

class FaceExpressionExerciseController extends ExerciseController {
  late PageController _pageController;
  @override
  PageController get pageController => _pageController;

  final List<FaceExpressionExerciseQuestions> _questions =
      face_expression_exercise_question
          .map(
            (question) => FaceExpressionExerciseQuestions(
                id: question['id'],
                image: question['image'],
                answerImage: question['answerImage'],
                question: question['question'],
                explanation: question['explanation'],
                options: question['options'],
                answer: question['answer_index']),
          )
          .toList();
  @override
  List<FaceExpressionExerciseQuestions> get questions => _questions;

  final RxBool _isAnswered = false.obs;

  @override
  bool get isAnswered => _isAnswered.value;

  late int _correctAns;
  @override
  int get correctAns => _correctAns;

  late int _selectedAns;
  @override
  int get selectedAns => _selectedAns;

  // for more about obs please check documentation
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
  void checkAns(dynamic question, dynamic selectedIndex) {
    _isAnswered.value = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns.value++;
    Logger().i(_numOfCorrectAns.value);

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
  void reset() {
    _isAnswered.value = false;
    _questionNumber.value = 1;
    _numOfCorrectAns.value = 0;
    _pageController = PageController();
    Logger().i("Face Expression controller resetting");
  }

  @override
  int getAnswerIndex(dynamic question) {
    return question.answer;
  }
}
