import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/homepage_screen.dart';
import 'providers/quiz_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizProvider()..loadHistory(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
