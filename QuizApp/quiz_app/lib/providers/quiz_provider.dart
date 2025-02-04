import 'package:flutter/material.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  List<int> _history = [];

  final List<Question> _questions = [
    Question("What is the capital of France?",
        ["Berlin", "Paris", "Madrid", "Rome"], 1),
    Question("What is the capital of Ukraine?",
        ["Washington", "London", "Kyiv", "Ryiadh"], 2),
    Question("What is the capital of Turkiye?",
        ["Vienna", "Belgrad", "Brussels", "Ankara"], 3),
    Question("What is the capital of Bulgaria?",
        ["Sofia", "Tallinn", "Athens", "Budapest"], 0),
    Question("What is the capital of Denmark?",
        ["Tbilisi", "Reykjavik", "Copenhagen", "Zagreb"], 2),
  ];

  int get currentQuestionIndex => _currentQuestionIndex;
  int get correctAnswers => _correctAnswers;
  List<int> get history => _history;
  Question get currentQuestion => _questions[_currentQuestionIndex];

  void answerQuestion(int selectedIndex, BuildContext context) {
    if (selectedIndex == currentQuestion.answer) {
      _correctAnswers++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _saveResult();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen()),
      );
    }
    notifyListeners();
  }

  void _saveResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _history.add(_correctAnswers);
    prefs.setStringList('history', _history.map((e) => e.toString()).toList());
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _correctAnswers = 0;
    notifyListeners();
  }

  void loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _history =
        prefs.getStringList('history')?.map((e) => int.parse(e)).toList() ?? [];
    notifyListeners();
  }
}
