import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String quizText;
  String quizKey;

  Quiz({
    required this.quizText,
    required this.quizKey,
  });
}
