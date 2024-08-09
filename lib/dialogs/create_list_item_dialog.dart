import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';  



class CreateListItemDialog extends StatefulWidget {

  const CreateListItemDialog({Key? key}) :super(key: key);


@override
  
  _CreateListItemDialogState createState () => _CreateListItemDialogState();


}
class _CreateListItemDialogState extends State<CreateListItemDialog> {

@override  
Widget build(BuildContext context) {

  final ListTitleController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

final db = FirebaseFirestore.instance;
  return AlertDialog(


    title: Text('Add your own meals'),

    
    content: Form(
      key: _key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // controller: ListTitleController,
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
              // onPressed: _createList,
              onPressed: null,
              child: const Text('Create list'),
            ),
          ),
        ],
      ),
    ),
  );
}
}
