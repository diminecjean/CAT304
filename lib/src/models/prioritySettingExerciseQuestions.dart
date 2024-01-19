class PrioritySettingQuestions {
  final int id;
  final String question, subtitle;
  final List<String> options, optionImages;
  final List<int> answer;

  PrioritySettingQuestions({
    required this.id,
    required this.question,
    required this.subtitle,
    required this.answer,
    required this.options,
    required this.optionImages,
  });
}

const List priority_setting_question = [
  {
    "id": 1,
    "question": "Tasks to complete after school",
    "subtitle": "Prioritize them based on importance or urgency.",
    "optionImages": [
      "assets/images/task_management/priority_setting/Q1_option1-play-games.png",
      "assets/images/task_management/priority_setting/Q1_option2-do-homework.png",
      "assets/images/task_management/priority_setting/Q1_option3-piano-practice.png",
    ],
    "options": [
      'Play Games',
      'Do Homework',
      'Piano Practice',
    ],
    "answer_sequence": [2, 1, 0],
  },
  {
    "id": 2,
    "question": "Tasks to complete after school",
    "subtitle": "Prioritize them based on importance or urgency.",
    "optionImages": [
      "assets/images/task_management/priority_setting/Q1_option1-play-games.png",
      "assets/images/task_management/priority_setting/Q1_option2-do-homework.png",
      "assets/images/task_management/priority_setting/Q1_option3-piano-practice.png",
    ],
    "options": [
      'Play Games',
      'Do Homework',
      'Piano Practice',
    ],
    "answer_sequence": [2, 1, 0],
  },
];
