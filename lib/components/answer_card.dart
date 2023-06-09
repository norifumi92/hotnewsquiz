import 'package:flutter/material.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:hotnewsquiz/components/answer_option.dart';
import 'package:hotnewsquiz/models/question.dart';

class AnswerCard extends StatelessWidget {
  final Question question;
  final int selectedAnswer;

  const AnswerCard(
      {required this.question, required this.selectedAnswer, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (question.summary != null) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('${question.publishedDate} 解説'),
                  content: SingleChildScrollView(
                    child: NormalText(question.summary.toString(),
                        color: Colors.black, selectable: true, size: 18),
                  ),
                );
              });
        }
      },
      child: Container(
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
                  color: Colors.black, selectable: false),
            ),
            //Options
            for (var i = 0; i < question.options.length; i++)
              AnswerOption(question.options[i],
                  optionId: i,
                  trueAnswer: question.answer,
                  selectedAnswer: selectedAnswer),
          ],
        ),
      ),
    );
  }
}
