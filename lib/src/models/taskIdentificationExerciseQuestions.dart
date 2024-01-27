class TaskIdentificationQuestions {
  final int id;
  final String question, image, explanation;
  final List<String> options, optionImages;
  final List<int> answer;

  TaskIdentificationQuestions(
      {required this.id,
      required this.image,
      required this.question,
      required this.explanation,
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
    "explanation":
        "To get ready for school, you need to brush your teeth, pack your backpack, eat breakfast, and wear your shoes. Watering plants and mopping the floor can be done after school, or at another time.",
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
  // {
  //   "id": 2,
  //   "image":
  //       "assets/images/emotion_gesture_recognition/face_expressions/boy-angry.jpg",
  //   "question": "Identify the tasks to get ready for school:",
  //   // TODO: Change this whole question
  //   "explanation":
  //       "To get ready for school, you need to brush your teeth, pack your backpack, eat breakfast, and wear your shoes. Watering plants and mopping the floor can be done after school, or at another time.",
  //   "optionImages": [
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //   ],
  //   "options": [
  //     'Brush Teeth',
  //     'Mop the Floor',
  //     'Pack Backpack',
  //     'Eat Breakfast',
  //     'Water the Plants',
  //     'Wear Shoes',
  //   ],
  //   "answer_index": [0, 2, 3, 5],
  // },
  // {
  //   "id": 3,
  //   "image":
  //       "assets/images/emotion_gesture_recognition/face_expressions/boy-sad.jpg",
  //   "question": "Identify the tasks to get ready for school:",
  //   "optionImages": [
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //   ],
  //   "options": [
  //     'Brush Teeth',
  //     'Mop the Floor',
  //     'Pack Backpack',
  //     'Eat Breakfast',
  //     'Water the Plants',
  //     'Wear Shoes',
  //   ],
  //   "answer_index": [0, 2, 3, 5],
  // },
  // {
  //   "id": 4,
  //   "image":
  //       "assets/images/emotion_gesture_recognition/face_expressions/boy-amazed.jpg",
  //   "question": "Identify the tasks to get ready for school:",
  //   "optionImages": [
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //     "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
  //   ],
  //   "options": [
  //     'Brush Teeth',
  //     'Mop the Floor',
  //     'Pack Backpack',
  //     'Eat Breakfast',
  //     'Water the Plants',
  //     'Wear Shoes',
  //   ],
  //   "answer_index": [0, 2, 3, 5],
  // },
];
