import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

abstract class ExerciseController<T> extends GetxController
    with GetSingleTickerProviderStateMixin {
  late PageController _pageController;
  PageController get pageController => _pageController;

  final List<T> _questions = [];
  List<T> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late dynamic _correctAns;
  dynamic get correctAns => _correctAns;

  late dynamic _selectedAns;
  dynamic get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  void checkAns(T question, dynamic selectedIndex) {
    _isAnswered = true;
    _correctAns = getAnswerIndex(question);
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    Logger().i(_numOfCorrectAns);
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

  void reset() {
    _isAnswered = false;
    _questionNumber.value = 1;
    _numOfCorrectAns = 0;
    _pageController = PageController();
  }

  int getAnswerIndex(T question);
}
