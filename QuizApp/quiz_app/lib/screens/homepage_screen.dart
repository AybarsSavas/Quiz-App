import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
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
        title: Text("Home Page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                // Butona tıklanıldığında yapılacak işlemi buraya yazabilirsiniz
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              child: Text('Let\'s Start'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Good Luck', style: TextStyle(fontSize: 20)),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Icon(
                      Icons.favorite,
                      size: 30 + _animation.value,
                      color: Colors.red,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
