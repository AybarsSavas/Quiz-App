import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/homepage_screen.dart';
import '../providers/quiz_provider.dart';
import 'quiz_screen.dart';
import 'history_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Correct Answer: ${quizProvider.correctAnswers}',
                style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 40,
                ),
              ),
              onPressed: () {
                quizProvider.resetQuiz();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              child: Text('Try Again'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 40,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
              child: Text('History'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 40,
                ),
              ),
              onPressed: () {
                quizProvider.resetQuiz();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
