import 'package:flutter/material.dart';
import 'package:hotnewsquiz/components/question_option.dart';
import 'package:hotnewsquiz/models/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final PageController pageController;

  const QuestionCard(
      {required this.question, required this.pageController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            question.questionText,
            style: TextStyle(color: Colors.black),
          ),
          QuestionOption(question.options[0], pageController),
          QuestionOption(question.options[1], pageController),
          QuestionOption(question.options[2], pageController),
        ],
      ),
    );
  }
}
