class FaceExpressionExerciseQuestions {
  final int id, answer;
  final String question, image, answerImage, explanation;
  final List<String> options;

  FaceExpressionExerciseQuestions(
      {required this.id,
      required this.image,
      required this.answerImage,
      required this.explanation,
      required this.question,
      required this.answer,
      required this.options});
}

const List face_expression_exercise_question = [
  {
    "id": 1,
    "image":
        "assets/images/emotion_gesture_recognition/face_expressions/q1_question_image.jpg",
    "answerImage":
        "assets/images/emotion_gesture_recognition/face_expressions/q1_answer_image.jpg",
    "question": "What is the emotion displayed above?",
    "explanation":
        "Fear and surprise facial expressions differ in eye widening, mouth movement, and eyebrow arch, crucial for distinguishing the emotions.",
    "options": ['Scared', 'Happy', 'Sad'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "image":
        "assets/images/emotion_gesture_recognition/face_expressions/q2_question_image.jpg",
    "answerImage":
        "assets/images/emotion_gesture_recognition/face_expressions/q2_answer_image.jpg",
    "question": "What is the emotion displayed above?",
    "explanation":
        "A Duchenne smile, denoting genuine happiness, involves the zygomatic major muscle for lip movement and distinctive eye-related muscle actions.",
    "options": ['Angry', 'Sad', 'Happy'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "image":
        "assets/images/emotion_gesture_recognition/face_expressions/q3_question_image.jpg",
    "answerImage":
        "assets/images/emotion_gesture_recognition/face_expressions/q3_answer_image.jpg",
    "question": "What is the emotion displayed above?",
    "explanation":
        "Muscle movements in the lips, around the eyes, and in the brow signify aggression, threat, or frustration, potentially serving as protective expressions during conflicts.",
    "options": ['Angry', 'Happy', 'Worried'],
    "answer_index": 0,
  },
  {
    "id": 4,
    "image":
        "assets/images/emotion_gesture_recognition/face_expressions/q4_question_image.jpg",
    "answerImage":
        "assets/images/emotion_gesture_recognition/face_expressions/q4_answer_image.jpg",
    "question": "What is the emotion displayed above?",
    "explanation":
        "Embarrassed individuals often avert their gaze by moving their head down and to the side, exposing the neck, accompanied by a tightly pressed smile indicating restraint or inhibition.q",
    "options": ['Bored', 'Confused', 'Embarrased'],
    "answer_index": 2,
  },
];
