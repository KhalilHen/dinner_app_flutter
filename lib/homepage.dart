import 'package:flutter/material.dart';
// import 'choose_meal.dart';
// import 'package:beta_app/pages/choosemeal.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange.shade700,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final primaryBackgroundColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
    );
  }
}
