class TaskSequencingQuestions {
  final int id;
  final String question, subtitle;
  final List<String> options, optionImages;
  final List<int> answer;

  TaskSequencingQuestions({
    required this.id,
    required this.question,
    required this.subtitle,
    required this.answer,
    required this.options,
    required this.optionImages,
  });
}

const List task_sequencing_question = [
  {
    "id": 1,
    "question": "Situation: Cooking Pasta",
    "subtitle": "Drag and drop to arrange the tasks in the correct order.",
    "optionImages": [
      "assets/images/task_management/task_sequencing/Q1_option1-cook-for-10-mins.png",
      "assets/images/task_management/task_sequencing/Q1_option2-add-salt-and-pasta.png",
      "assets/images/task_management/task_sequencing/Q1_option3-boil-water.png",
      "assets/images/task_management/task_sequencing/Q1_option4-serve-pasta.png",
      "assets/images/task_management/task_sequencing/Q1_option5-drain-pasta.png",
    ],
    "options": [
      'Cook for 10 minutes',
      'Add salt and pasta',
      'Boil water',
      'Serve pasta',
      'Drain pasta',
    ],
    "answer_sequence": [2, 1, 0, 4, 3],
  },
  {
    "id": 2,
    "question": "Situation: Cooking Pasta",
    "subtitle": "Drag and drop to arrange the tasks in the correct order.",
    "optionImages": [
      "assets/images/task_management/task_sequencing/Q1_option1-cook-for-10-mins.png",
      "assets/images/task_management/task_sequencing/Q1_option2-add-salt-and-pasta.png",
      "assets/images/task_management/task_sequencing/Q1_option3-boil-water.png",
      "assets/images/task_management/task_sequencing/Q1_option4-serve-pasta.png",
      "assets/images/task_management/task_sequencing/Q1_option5-drain-pasta.png",
    ],
    "options": [
      'Cook for 10 minutes',
      'Add salt and pasta',
      'Boil water',
      'Serve pasta',
      'Drain pasta',
    ],
    "answer_sequence": [2, 1, 0, 4, 3],
  },
];
