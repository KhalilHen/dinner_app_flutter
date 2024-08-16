import 'package:dinnerapp/dialogs/controllers.dart/log_out_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddMealDialog extends StatefulWidget {
  const AddMealDialog({
    Key? key,
    required this.idMeal,
    required this.name,
  }) : super(key: key);

  final String idMeal;
  final String name;

  @override
  _AddMealDialogState createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  final _listNameController = TextEditingController();
late  String mealName;
late String mealId;


//TODO Later turn this into a seperate file and call the method from that file
//TODO And other files where this is used
    final user = FirebaseAuth.instance.currentUser;

  @override
void initState() {
  
  super.initState();
    mealName = widget.name;
    mealId = widget.idMeal;
}


void retrieveUsersList() async {

    var user = FirebaseAuth.instance.currentUser;
    var userLinkedList = FirebaseFirestore.instance.collection('list').where('userId', isEqualTo: user!.uid).get();


    print('User List: $userLinkedList');


}
void retrievePickedMeal() {



print("mealId: ${widget.idMeal}");
print("MealName${widget.name}");

}

  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('To which list would you like to add this meal?'),

  
      
      content: Column(
        children: 
        
        
        
        [
    Text("Meal ID: $mealId"),
          Text("Meal Name: $mealName"),          
           Form(
        


          
          child: DropdownButtonFormField(

            items: [
              DropdownMenuItem(
                
                child: Text('Breakfast'),
                value: 'Breakfast',
              ),
              DropdownMenuItem(
                child: Text('Lunch'),
                value: 'Lunch',
              ),
              DropdownMenuItem(
                child: Text('Dinner'),
                value: 'Dinner',
              ),
            ],   
            // controller: _listNameController,
       onChanged: (value) {

       },
          ),
          
        ),
        ],
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
            // Add logic to handle adding the meal to the list here
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }

}