import 'package:flutter/material.dart';
import 'homepage.dart'; 

import './dialogs/choose_meal_dialog.dart';
class ChooseMealPage extends StatefulWidget {
  const ChooseMealPage({Key? key}) : super(key: key);

  @override
  _ChooseMealPageState createState() => _ChooseMealPageState();
}

class _ChooseMealPageState extends State<ChooseMealPage> {
  int _currentIndex = 0;
 var  dinnermeal = [];






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
  Text(' \$title'),




ElevatedButton( onPressed: () {
  
  
 showDialog(context: context, builder: (context) {

return ChooseMealDialog();

 } ); 
},

    // style: ElevatedButton.styleFrom(
    //                     foregroundColor: Colors.green,
    //                   ),


                      style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
 child: Text('Click here to choose a meal', 
style: 
TextStyle(               
   color: Colors.black,
  

),

)),

// Row(
//   children: [

//     ElevatedButton(onPressed: null, child: Text('cane')),

//         ElevatedButton(onPressed: null, child: Text('')),


//     ElevatedButton(onPressed: null, child: Text('')),

//   ],

// ),
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
