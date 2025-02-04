import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int? _selectedOption;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  void _nextQuestion() {
    _controller.reverse().then((_) {
      setState(() {
        _selectedOption = null;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          final question = quizProvider.currentQuestion;
          return SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                key: ValueKey(quizProvider.currentQuestionIndex),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      question.question,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      child: ListView.builder(
                        itemCount: question.options.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<int>(
                            title: Text(
                              question.options[index],
                              style: TextStyle(fontSize: 18),
                            ),
                            value: index,
                            groupValue: _selectedOption,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                            activeColor: Colors.blueAccent,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
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
                    onPressed: _selectedOption != null
                        ? () {
                            quizProvider.answerQuestion(
                                _selectedOption!, context);
                            _nextQuestion();
                          }
                        : null,
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
