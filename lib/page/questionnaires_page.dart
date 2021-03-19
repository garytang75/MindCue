import 'package:flutter/material.dart';
import 'package:flutter_auth2/models/quiz.dart';
import 'package:flutter_auth2/models/results.dart';
import 'package:flutter_auth2/page/home_page.dart';

class Questionnaires extends StatefulWidget {
  @override
  _QuestionnairesState createState() => _QuestionnairesState();
}

class _QuestionnairesState extends State<Questionnaires> {
  final _questions = const [
    {
      'questionText': 'How are you feeling today?',
      'answer': [
        {'text': 'Excellent', 'score': 10},
        {'text': 'Good', 'score': 7},
        {'text': 'Bad', 'score': 4},
        {'text': 'Horrible', 'score': 1},
      ],
    },
    {
      'questionText': 'How tired are you? ',
      'answer': [
        {'text': 'Not at all', 'score': 10},
        {'text': 'A little', 'score': 7},
        {'text': 'Very Tired', 'score': 3},
        {'text': 'Exhausted', 'score': 1}
      ],
    },
    {
      'questionText': 'Do you feel productive today?',
      'answer': [
        {'text': 'I accomplished a lot', 'score': 10},
        {'text': 'I accomplished a little', 'score': 6},
        {'text': 'I accomplished very little', 'score': 4},
        {'text': 'I am a couch potato', 'score': 1}
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _goMain() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Questionnaires'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Results(
                _totalScore,
                _resetQuiz,
                _goMain,
              ),
      ),
    );
  }
}
