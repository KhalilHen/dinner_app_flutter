import 'package:dinnerapp/controllers/log_out_controller.dart';
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
  late String mealName;
  late String mealId;
  String? selectedList;
  String? selectedListId;

  final user = FirebaseAuth.instance.currentUser;
  List<DropdownMenuItem<String>> _dropdownItems = [];

  @override
  void initState() {
    super.initState();
    mealName = widget.name;
    mealId = widget.idMeal;
    retrieveUsersList();
  }

  Future<void> retrieveUsersList() async {
    var user = FirebaseAuth.instance.currentUser;
    var userLinkedList = FirebaseFirestore.instance
        .collection('list')
        .where('userId', isEqualTo: user!.uid);

    var querySnapshot = await userLinkedList.get();
    List<DropdownMenuItem<String>> items = [];

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      var data = queryDocumentSnapshot.data();
      var title = data['title'];
      var listId = queryDocumentSnapshot.id; // Get the document ID

      items.add(DropdownMenuItem(
        child: Text(title), 
        value: listId, // Store the list ID as the value
      ));
    }

    setState(() {
      _dropdownItems = items;
    });
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
        mainAxisSize: MainAxisSize.min, // Adjust column to wrap content
        children: [
          Text("Meal ID: $mealId"),
          Text("Meal Name: $mealName"),
          DropdownButtonFormField<String>(
            items: _dropdownItems,
            hint: Text('Select a list'),
            value: selectedListId,
            onChanged: (String? newValue) {
              setState(() {
                selectedListId = newValue;
                selectedList = _dropdownItems.firstWhere(
                    (item) => item.value == newValue).child.toString();
              });
            },
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
            if (selectedListId != null) {


              FirebaseFirestore.instance.collection('list').doc(selectedListId).collection('mealItem').add({
                'mealId': mealId,
                'mealName': mealName,
              });

              print('Selected List Name: $selectedList');
              print('Selected List ID: $selectedListId');
              print('Meal ID: $mealId');
              print('Meal Name: $mealName');
            }

            // Add logic to handle adding the meal to the list here
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
