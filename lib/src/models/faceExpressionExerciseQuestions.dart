class FaceExpressionExerciseQuestions {
  final int id, answer;
  final String question, image;
  final List<String> options;

  FaceExpressionExerciseQuestions(
      {required this.id,
      required this.image,
      required this.question,
      required this.answer,
      required this.options});
}

const List face_expression_exercise_question = [
  {
    "id": 1,
    "image":
        "assets/images/emotion_gesture_recognition/face_expressions/boy-happy.jpg",
    "question": "What is the emotion displayed above?",
    "options": ['Scared', 'Happy', 'Sad'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "image":
        "assets/images/emotion_gesture_recognition/face_expressions/boy-angry.jpg",
    "question": "What is the emotion displayed above?",
    "options": ['Excited', 'Sad', 'Angry'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "image":
        "assets/images/emotion_gesture_recognition/face_expressions/boy-sad.jpg",
    "question": "What is the emotion displayed above?",
    "options": ['Sad', 'Happy', 'Worried'],
    "answer_index": 0,
  },
  {
    "id": 4,
    "image":
        "assets/images/emotion_gesture_recognition/face_expressions/boy-amazed.jpg",
    "question": "What is the emotion displayed above?",
    "options": ['Bored', 'Confused', 'Amazed'],
    "answer_index": 2,
  },
];
