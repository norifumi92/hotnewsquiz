import 'package:flutter/material.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
// import 'package:hotnewsquiz/components/question_option.dart';
import 'package:hotnewsquiz/models/question.dart';

class AnswerCard extends StatelessWidget {
  final Question question;

  const AnswerCard({required this.question, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          NormalText(question.questionText,
              color: Colors.black, selectable: true),
          // for (var i = 0; i < question.options.length; i++)
          //   QuestionOption(question.options[i], i),
        ],
      ),
    );
  }
}
