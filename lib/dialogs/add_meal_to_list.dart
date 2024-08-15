  import 'package:flutter/material.dart';

import 'choose_meal_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';




 class AddMealDialog extends StatefulWidget {
    const AddMealDialog({Key? key,
    
    required this.id,
    required this.name
    }) : super(key: key);

    @override
    _AddMealDialogState createState() => _AddMealDialogState();
  }

  class _AddMealDialogState extends State<AddMealDialog> {

final int id;
final string name;
  bool pressed = false;

// final int id;
@override 
void initState() {
 super.initState();



mealName = widget.str;
mealId = widget.id
}
  



    @override
    Widget build(BuildContext context) {
      return AlertDialog(

        title: Text('To which list would you like to add this meal?'),
        

        content: Form(
child: TextFormField(

  decoration: InputDecoration(
    labelText: 'List name',
  ),
),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      );
    }

  }

  