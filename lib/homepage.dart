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
      body: Container(
     
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
              Text('Title', style: 
              TextStyle(
                fontSize: 24,
              ),
              ),
    	  Container(
          alignment: Alignment.center,
            height: 225,
            width: 225,
            color: Colors.green,
// Here comes a image of a food item random selected
          child: Image.asset('assets/images/food.jpg'),
          
        ),
        SizedBox(height: 10), 
        //Here comes the description
        Container(

color: Colors.red,
          height: 50,
            width: 225,
          child: Text('Description'),

        )


            ],
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
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => ChooseMealScreen(),
              //   ),
              // );
              break;
            case 2:
              // Handle Lists tap
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
