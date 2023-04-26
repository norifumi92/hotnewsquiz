import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizController {
  List<Map<String, dynamic>> questions = [];

  Future<void> getQuestions() async {
    final QuerySnapshot<Map<String, dynamic>> result =
        await FirebaseFirestore.instance.collection('quizzes').get();

    questions =
        result.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      final Map<String, dynamic> data = doc.data();
      return {
        'question': data['question'],
        'options': List<String>.from(data['options']),
        'answer': data['answer'],
      };
    }).toList();
  }
}
