import 'package:flutter/material.dart';



class ChooseMealDialog extends StatefulWidget {
  const ChooseMealDialog({Key? key}) : super(key: key);

  @override
  _ChooseMealDialogState createState() => _ChooseMealDialogState();
}

class _ChooseMealDialogState extends State<ChooseMealDialog> {
    int mealIndex = 0;
int index = 0;

bool pressed = false;

List <String> meals = [ 'rice', 'beans', 'spaghetti', 'yam', 'potato', 'plantain', 'moi moi'];

var test = [];


// List meals.add('rice');
void increseIndex() {

mealIndex++;
}

  var  dinnermeal = ['rice', 'beans', 'spaghetti', 'yam', 'potato', 'plantain', 'moi moi'];


void addItems() {
  var  dinnermeal = [];

  dinnermeal.add('rice');
dinnermeal.add('beans');
dinnermeal.add('spaghetti');
dinnermeal.add('yam');
dinnermeal.add('potato');
dinnermeal.add('plantain');
dinnermeal.add('moi moi');
}
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose a meal'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

Container(

height: 100,
width: 300,
// color: Colors.green,
 
child: Text(
 
// if(pressed == true) {
 
// dinnermeal++;
 
// }

 
// else {
// }
  '$meals[i]',
  



    ),



  




        
),
//
//
          // ListTile(
          //   title: const Text('Breakfast'),
          //   onTap: () {
          //     Navigator.of(context).pop('Breakfast');
          //   },
          // ),
          // ListTile(
          //   title: const Text('Lunch'),
          //   onTap: () {
          //     Navigator.of(context).pop('Lunch');
          //   },
          // ),
          // ListTile(
          //   title: const Text('Dinner'),
          //   onTap: () {
          //     Navigator.of(context).pop('Dinner');
          //   },
          // ),
        ],
      ),
      actions: [

        Row(
  
 children: [
  ElevatedButton(
    onPressed: () {
      Navigator.of(context).pop('');
    },
    child: const Text('Cancel'),
  ),


  ElevatedButton(onPressed: null, child: Text('Pick'),
  ),

  ElevatedButton(onPressed:() {
addItems();
    increseIndex();

 print(dinnermeal[0]);
 print(dinnermeal[1]);
    bool pressed = true;
  }, child: Text('Next'))
 ],

),
      ],
    );
  }
}