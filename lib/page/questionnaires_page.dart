import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_auth2/models/quiz.dart';
import 'package:flutter_auth2/models/results.dart';
import 'package:flutter_auth2/page/home_page.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

import '../fetch_data.dart';

//list in global to prevent overwriting when
//call function sendResult from another widget
List<int> scores = [];

class Questionnaires extends StatefulWidget {
  @override
  QuestionnairesState createState() => QuestionnairesState();
}

class QuestionnairesState extends State<Questionnaires> {
  final _questions = const [
    {
      'questionText': 'How are you feeling today?',
      'answer': [
        {'text': 'Excellent', 'score': 4},
        {'text': 'Good', 'score': 3},
        {'text': 'Meh', 'score': 2},
        {'text': 'Bad', 'score': 1},
      ],
    },
    {
      'questionText': 'Tell me about your energy level? ',
      'answer': [
        {'text': 'Full of energy', 'score': 4},
        {'text': 'Average', 'score': 3},
        {'text': 'Low', 'score': 2},
        {'text': 'Burnt out', 'score': 1}
      ],
    },
    {
      'questionText': 'Tell me about your concentration?',
      'answer': [
        {'text': 'Always ease to focus', 'score': 4},
        {'text': 'Usually ease ', 'score': 3},
        {'text': 'Sometimes hard ', 'score': 2},
        {'text': 'Very hard to focus', 'score': 1}
      ],
    },
    {
      'questionText': 'Tell me about your appetite?',
      'answer': [
        {'text': 'Excellent', 'score': 4},
        {'text': 'Good', 'score': 3},
        {'text': 'Meh', 'score': 2},
        {'text': 'Bad', 'score': 1},
      ],
    },
    {
      'questionText': 'Do you feel nervous, anxious, or on edge?',
      'answer': [
        {'text': 'Not at all', 'score': 4},
        {'text': 'Rare', 'score': 3},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Always', 'score': 1},
      ],
    },
    {
      'questionText':
          'How often do you feel being so restless that it is hard to sit still?',
      'answer': [
        {'text': 'Not at all', 'score': 4},
        {'text': 'Rare', 'score': 3},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Always', 'score': 1},
      ],
    },
    {
      'questionText':
          'How often do you feel being afraid, as if something awful might happen?',
      'answer': [
        {'text': 'Not at all', 'score': 4},
        {'text': 'Rare', 'score': 3},
        {'text': 'Sometimes', 'score': 2},
        {'text': 'Always', 'score': 1},
      ],
    },
    {
      'questionText':
          'Are you able to control the important things in your life?',
      'answer': [
        {'text': 'Always', 'score': 4},
        {'text': 'Most of the time', 'score': 3},
        {'text': 'Sometimes out of control', 'score': 2},
        {'text': 'Hard to control', 'score': 1},
      ],
    },
    {
      'questionText': 'Are things going your way?',
      'answer': [
        {'text': 'Always', 'score': 4},
        {'text': 'Sometimes', 'score': 3},
        {'text': 'Rare', 'score': 2},
        {'text': 'Never', 'score': 1},
      ],
    },
    {
      'questionText': 'How do you feel about overcoming difficulties?',
      'answer': [
        {'text': 'Easy to overcome', 'score': 4},
        {'text': 'Usually ease', 'score': 3},
        {'text': 'Sometimes hard', 'score': 2},
        {'text': 'Very hard', 'score': 1}
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;
  var _resultTip = "";
  var num = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _resultTip = "";
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
      // print('We have more questions!');
    } else {
      // print('No more questions!');
    }
    scores.insert(num, score); //add answer values to the list
    num++;

    print(_totalScore);
  }

  //function sends result to backend
  Future<String> sendResult() async {
    String userId = await Fetch().fetchUserId();
    var dateTime = DateTime.now().toString(); //date and time for DB
    try {
      RestOptions options = RestOptions(
          path: '/test/add_user',
          body: Uint8List.fromList('{'
                  '\'q1\':\'"${scores[0]}"\','
                  '\'q2\':\'${scores[1]}\','
                  '\'q3\':\'${scores[2]}\','
                  '\'q4\':\'${scores[3]}\','
                  '\'q5\':\'${scores[4]}\','
                  '\'q6\':\'${scores[5]}\','
                  '\'q7\':\'${scores[6]}\','
                  '\'q8\':\'${scores[7]}\','
                  '\'q9\':\'${scores[8]}\','
                  '\'q10\':\'${scores[9]}\','
                  '\'id\':\'$userId\','
                  '\'date\':\'$dateTime\''
                  '}'
              .codeUnits));
      RestOperation restOperation = Amplify.API.post(restOptions: options);
      RestResponse response = await restOperation.response;
      print('POST call sendResult succeeded');
      var finalres = json.decode(String.fromCharCodes(response.data));
      // print(new String.fromCharCodes(response.data));

      _resultTip = finalres["text"];
    } on ApiException catch (e) {
      print('POST call sendResult failed: $e');
    }
    return _resultTip;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xFFCEE2EE),
        ),
        accentColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Questionnaire',
            style: TextStyle(color: Colors.grey[850]),
          ),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Results(
                _resultTip,
                _totalScore,
                _resetQuiz,
                _goMain,
              ),
      ),
    );
  }
}
