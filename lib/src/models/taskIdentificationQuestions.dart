class TaskIdentificationQuestions {
  final int id;
  final String question, image;
  final List<String> options, optionImages;
  final List<int> answer;

  TaskIdentificationQuestions(
      {required this.id,
      required this.image,
      required this.question,
      required this.answer,
      required this.options,
      required this.optionImages});
}

const List task_identification_question = [
  {
    "id": 1,
    "image":
        "assets/images/task_management/task_identification/Q1_go-to-school.png",
    "question": "Identify the tasks to get ready for school:",
    "optionImages": [
      "assets/images/task_management/task_identification/Q1_option1-brush-teeth.png",
      "assets/images/task_management/task_identification/Q1_option2-mop-the-floor.png",
      "assets/images/task_management/task_identification/Q1_option3-pack-backpack.png",
      "assets/images/task_management/task_identification/Q1_option4-eat-breakfast.png",
      "assets/images/task_management/task_identification/Q1_option5-water-the-plants.png",
      "assets/images/task_management/task_identification/Q1_option6-wear-shoes.png",
    ],
    "options": [
      'Brush Teeth',
      'Mop the Floor',
      'Pack Backpack',
      'Eat Breakfast',
      'Water the Plants',
      'Wear Shoes',
    ],
    "answer_index": [0, 2, 3, 5],
  },
  {
    "id": 2,
    "image": "assets/images/face_expressions/boy-angry.jpg",
    "question": "Identify the tasks to get ready for school:",
    "optionImages": [
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
    ],
    "options": [
      'Brush Teeth',
      'Mop the Floor',
      'Pack Backpack',
      'Eat Breakfast',
      'Water the Plants',
      'Wear Shoes',
    ],
    "answer_index": [0, 2, 3, 5],
  },
  {
    "id": 3,
    "image": "assets/images/face_expressions/boy-sad.jpg",
    "question": "Identify the tasks to get ready for school:",
    "optionImages": [
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
    ],
    "options": [
      'Brush Teeth',
      'Mop the Floor',
      'Pack Backpack',
      'Eat Breakfast',
      'Water the Plants',
      'Wear Shoes',
    ],
    "answer_index": [0, 2, 3, 5],
  },
  {
    "id": 4,
    "image": "assets/images/face_expressions/boy-amazed.jpg",
    "question": "Identify the tasks to get ready for school:",
    "optionImages": [
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
      "assets/images/face_expressions/boy-happy.jpg",
    ],
    "options": [
      'Brush Teeth',
      'Mop the Floor',
      'Pack Backpack',
      'Eat Breakfast',
      'Water the Plants',
      'Wear Shoes',
    ],
    "answer_index": [0, 2, 3, 5],
  },
];
