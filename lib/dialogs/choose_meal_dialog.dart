import 'package:flutter/material.dart';



class ChooseMealDialog extends StatefulWidget {
  const ChooseMealDialog({Key? key}) : super(key: key);

  @override
  _ChooseMealDialogState createState() => _ChooseMealDialogState();
}

class _ChooseMealDialogState extends State<ChooseMealDialog> {
final    int mealIndex = 0;


  var  dinnermeal = [];


void addItems() {

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
color: Colors.green,

child: ListView.builder(
  itemCount: dinnermeal.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(dinnermeal[index]),
    );
  },



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
    
print(dinnermeal[mealIndex]);
  }, child: Text('Next'))
 ],

),
      ],
    );
  }
}