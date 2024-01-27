class TaskSequencingQuestions {
  final int id;
  final String question, subtitle, explanation;
  final List<String> options, optionImages;
  final List<int> answer;

  TaskSequencingQuestions({
    required this.id,
    required this.question,
    required this.subtitle,
    required this.explanation,
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
    "explanation":
        "To cook pasta, you need to boil water, add salt and pasta, cook for 10 minutes, drain pasta, and serve pasta.",
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
    //TODO: Change this whole question
    "explanation":
        "To cook pasta, you need to boil water, add salt and pasta, cook for 10 minutes, drain pasta, and serve pasta.",
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
