class GestureRecognitionExerciseQuestions {
  final int id, answer;
  final String question, image, explanation;
  final List<String> options;

  GestureRecognitionExerciseQuestions(
      {required this.id,
      required this.image,
      required this.question,
      required this.explanation,
      required this.answer,
      required this.options});
}

const List gesture_recognition_exercise_question = [
  {
    "id": 1,
    "image":
        "assets/images/emotion_gesture_recognition/gesture_recognition/bite_nails.png",
    "question": "What does this body language indicate?",
    "explanation":
        "Nail biting is a common body language behavior that helps some people relieve tension and anxiety during stressful situations.",
    "options": ['Nervous', 'Confident', 'Sad'],
    "answer_index": 0,
  },
  {
    "id": 2,
    "image":
        "assets/images/emotion_gesture_recognition/gesture_recognition/feet_point.png",
    "question":
        "When talking to someone, feet pointed towards you is a sign of mutual interest.",
    "explanation":
        "Feet pointing at you signals engagement and mutual interest, fostering positive and open communication.",
    "options": ['True', 'False'],
    "answer_index": 0,
  },
  {
    "id": 3,
    "image":
        "assets/images/emotion_gesture_recognition/gesture_recognition/scared.png",
    "question": "Which emotion is the most likely feeling?",
    "explanation":
        "Body language of being scared usually includes signs like wide eyes, a tense posture, and possibly a defensive stance.",
    "options": ['Sad', 'Disgusted', 'Scared'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "image":
        "assets/images/emotion_gesture_recognition/gesture_recognition/cross_arms.png",
    "question":
        "In a group setting, observing people with crossed arms might suggest:",
    "explanation":
        "It usually signals a person who is distant, insecure, defensive or anxious.",
    "options": ['Sad', 'Defensiveness', 'Openness'],
    "answer_index": 1,
  },
];
