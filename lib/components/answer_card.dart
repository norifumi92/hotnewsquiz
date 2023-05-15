import 'package:flutter/material.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:hotnewsquiz/components/answer_option.dart';
import 'package:hotnewsquiz/models/question.dart';

class AnswerCard extends StatelessWidget {
  final Question question;

  const AnswerCard({required this.question, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          //Question Text
          Container(
            width: screenWidth * 0.8,
            color: Colors.white,
            child: NormalText(question.questionText,
                color: Colors.black, selectable: true),
          ),
          //Options
          for (var i = 0; i < question.options.length; i++)
            AnswerOption(question.options[i], i),
        ],
      ),
    );
  }
}
