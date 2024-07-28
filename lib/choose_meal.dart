import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'homepage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange.shade700,
      ),
      home: const ChooseMeal(),
    );
  }
}

class ChooseMeal extends StatefulWidget {
  const ChooseMeal({Key? key}) : super(key: key);

  @override
  _ChooseMealState createState() => _ChooseMealState();
}

class _ChooseMealState extends State<ChooseMeal> {
  int _currentIndex = 1 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Meal'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Homepage(),
              ),
            );
          },
          child: const Text('Go to Homepage'),
        ),
      ),
    );
  }
}
