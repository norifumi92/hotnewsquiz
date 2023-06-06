import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    Question question;
    try {
      question = Question(
        questionText: data['question'].runtimeType != double //Detect Nan value
            ? data['question']
            : "Error",
        options: List<String>.from(data['options'].runtimeType != double
            ? data['options']
            : ["Error"]),
        answer: data['answer'].runtimeType != double //Detect Nan value,
            ? data['answer']
            : "99",
        publishedDate: data['published_date'],
        summary:
            data['article_content'].runtimeType != double //Detect Nan value,
                ? data['article_content']
                : "Error",
      );
    } catch (e) {
      print(e);
      question = Question(
          questionText: "Error",
          options: List<String>.from(["Error"]),
          answer: "Error",
          publishedDate: "2019-01-01",
          summary: "Error");
    }
    return question;
  }
}
