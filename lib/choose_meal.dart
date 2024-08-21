import 'package:flutter/material.dart';
import 'homepage.dart'; 
  import '../post.dart'; 

import './dialogs/choose_meal_dialog.dart';
import 'list.dart';


import '/controllers/fetch_controller.dart';


import './dialogs/add_meal_to_list.dart';


import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';



class ChooseMealPage extends StatefulWidget {
  const ChooseMealPage({Key? key,

  
  }) : super(key: key);

  @override
  _ChooseMealPageState createState() => _ChooseMealPageState();
}

class _ChooseMealPageState extends State<ChooseMealPage> {
  int _currentIndex = 2;

  late StreamController<Meal> _mealStreamController;

 late Stream<Meal> _mealStream;

 final controller = FetchController();



@override
  void initState() {
    super.initState();
    _mealStreamController = StreamController<Meal>();
    _mealStream = _mealStreamController.stream;
    _fetchNextMeal();
  }
  Future<void> _fetchNextMeal() async {
    await controller.fetchNextMeal(_mealStreamController);
  }



 

  @override
  void dispose() {
    _mealStreamController.close();
    super.dispose();
  }
  


  @override
  Widget build(BuildContext context) {
    final primaryBackgroundColor = Color(0xFFE0CDB4);



  

    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        
        backgroundColor: Colors.grey,
        title: Text(
          'Choose meal',
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
             IconButton(

            onPressed: () {
            //  Log out logic
            },
            icon: Icon(Icons.logout ),
          ),
        ],
      ),
          body: Container(
            height: MediaQuery.of(context).size.height * 0.7,
           width: MediaQuery.of(context).size.width * 0.9,
child:  Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

    Text('Choose Meal Page', style: TextStyle(fontSize: 20),),


  Container(
    height: MediaQuery.of(context).size.height * 0.2,
child: Column(
 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.center,
children: [

       StreamBuilder<Meal>(
        stream: _mealStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No meal available'));
          } else {
            final meal = snapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(meal.idMeal),
                Text(meal.strMeal),
                Text('Category: ${meal.strCategory}'),
                Image.network(meal.strMealThumb),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {  
                        return AddMealDialog(idMeal: meal.idMeal, name: meal.strMeal);
                      
                      },
                    );
                  },
                  child: Text('Pick'),
                ),
              ],
            );
          }
        },
      ),

ElevatedButton( onPressed: () {
  
  
 showDialog(context: context, builder: (context) {

return ChooseMealDialog();

 } ); 
},

    

                      style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
 child: Text('Click here to choose a meal', 
style: 
TextStyle(               
   color: Colors.black,
  

),

)),


],

),

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
