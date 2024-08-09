import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_options.dart';

import 'package:cloud_firestore/cloud_firestore.dart';  


class CreateListDialog extends StatefulWidget {
  const CreateListDialog({Key? key}) : super(key: key);

  @override
  _CreateListDialogState createState() => _CreateListDialogState();
}

class _CreateListDialogState extends State<CreateListDialog> {
  final ListTitleController = TextEditingController();
  final mealName = TextEditingController();
  final mealDescription = TextEditingController();


  
  final mealImg = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

final db = FirebaseFirestore.instance;



  Future<void> _createList() async {
    if (_key.currentState!.validate()) {

final  title =  ListTitleController.text;

      
CollectionReference  createListTitle = FirebaseFirestore.instance.collection('list');
try {

createListTitle.add({

  'title': title,

  
}).then((__)


{
Navigator.of(context).pop();
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Created list: $title')));


}
);
}

 catch (e) {
        print('Sign up failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up failed: $e')));
      }




      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
  return Dialog(

    child: Form(
      key: _key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: ListTitleController,
              decoration: const InputDecoration(
                labelText: 'List name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a list name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _createList,
              child: const Text('Create list'),
            ),
          ),
        ],
      ),
    ),
  );
  }
}