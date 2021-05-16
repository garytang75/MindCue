import 'package:flutter/material.dart';

import './answers.dart';
import './questions.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  Quiz(
      {@required this.questions,
      @required this.answerQuestion,
      @required this.questionIndex});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Questions(questions[questionIndex]['questionText']),
        ...(questions[questionIndex]['answer'] as List<Map<String, Object>>)
            .map((answers) {
          return Answers(
              () => answerQuestion(answers['score']), answers['text']);
        }).toList()
      ],
    );
  }
}
