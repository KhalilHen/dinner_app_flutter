import 'package:dinnerapp/choose_meal.dart';
import 'package:flutter/material.dart';
// import 'choose_meal.dart';
// import 'package:beta_app/pages/choosemeal.dart';
import 'list.dart';
import 'post.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dialogs/controllers.dart/fetch_controller.dart';  // Import the fetch controller

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
}class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late Future<Meal> _futureMeal; // Define Future as a state variable



    final user = FirebaseAuth.instance.currentUser;


  final Controller _fetchController = Controller(); // Create an instance of FetchController

  @override
  void initState() {
    super.initState();
    _futureMeal = _fetchController.fetchMeals(); // Initialize Future in initState
  }



Future pickMeal() async { 


}
  @override
  Widget build(BuildContext context) {
    final primaryBackgroundColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'Homepage',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle notification button press
            },
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              // Handle help button press
            },
            icon: Icon(Icons.help),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<Meal>(
          future: _futureMeal, // Use the Future variable
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 1.8,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Welcome ${user!.email}" ?? 'Guest', style: TextStyle(
                        fontSize: 24,
                      ),),  
                      Text(
                        'Today\'s suggestion:',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      Text(snapshot.data!.strMeal, style: 
                      TextStyle(
                        fontSize: 24,
                      ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 400,
                        width: 400,
                        color: Colors.green,
                        child: Image.network(snapshot.data!.strMealThumb),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 400,
                        width: 400,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          snapshot.data!.strInstructions,
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          softWrap: true,
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Welcome \$user", style: TextStyle(
                        fontSize: 24,
                      ),),
                      Text(
                        'Today\'s suggestion:',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      Text('Error: ${snapshot.error}', style: 
                      TextStyle(
                        fontSize: 24,
                      ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 225,
                        width: 225,
                        color: Colors.green,
                        child: Image.asset('assets/images/food.jpg'),
                      ),
                      SizedBox(height: 10), 
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureMeal = _fetchController.fetchMeals();
                          });
                        },
                        child: Text('Add to list ', style: TextStyle(
                          fontSize: 24,
                        ),),
                      ),

                      
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Homepage(),
                ),
              );
              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChooseMealPage(),
                ),
              );
              break;
            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ListPage(),
                ),
              );
              break;
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lunch_dining),
            label: 'Choose',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lists',
          ),
        ],
      ),
    );
  }
}
