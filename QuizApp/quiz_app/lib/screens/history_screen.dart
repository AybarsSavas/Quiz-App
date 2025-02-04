import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('History', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.indigo),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          return ListView.builder(
            itemCount: quizProvider.history.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                      'Quiz ${index + 1}: ${quizProvider.history[index]} Correct Answer'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
