import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Question {
  String questionText;
  List<String> options;
  String answer;
  String publishedDate;
  String? summary;

  Question(
      {required this.questionText,
      required this.options,
      required this.answer,
      required this.publishedDate,
      this.summary});

  factory Question.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Question(
        questionText: data['question'],
        options: List<String>.from(data['options']),
        answer: data['answer'],
        publishedDate: data['published_date'],
        summary: data['article_content']);
  }
}
