import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  


class CreateListItemDialog extends StatefulWidget {
  final String docId;
  const CreateListItemDialog({Key? key, required this.docId}) : super(key: key);





@override
  
  _CreateListItemDialogState createState () => _CreateListItemDialogState();


}
class _CreateListItemDialogState extends State<CreateListItemDialog> {

    final user = FirebaseAuth.instance.currentUser;

@override  
Widget build(BuildContext context) {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final description =  TextEditingController();
  //TODO Adjust this later
  final img = TextEditingController();

final mealName = TextEditingController();
final db = FirebaseFirestore.instance;


// void pickImage() async {

//    FilePickerResult? result = await FilePicker.platform.pickFiles();

// if (result != null) {
//   Uint8List fileBytes = result.files.first.bytes;
//   String fileName = result.files.first.name;
  
//   // Upload file
//   await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
// }
// }



 Future<void>  retrieveSubcollection() async {
        if (_key.currentState!.validate()) {
final mealTitle = mealName.text;
    //  db.collection('list').doc(widget.docId).collection('mealItem').get();

try {

db.collection('list').doc(widget.docId).collection('mealItem').add({
  'mealname': mealTitle,

  // TODO Adjust this later 
  'mealDescription': 'This is a meal8',
  'mealImg': 'null', 
  'mealId': '3',

}).then((__) {
  Navigator.of(context).pop();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Created meal: $mealTitle')));
});

    
}
catch(e)

{
  print(e);
}
        }
    // Access the subcollection under the document with widget.docId
     db.collection('list').doc(widget.docId).collection('mealItem').snapshots();
  }
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
              controller:  mealName,
              decoration: const InputDecoration(
                labelText: 'Meal name',
                hintText: 'Kapsalon',
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
            child: TextFormField(
              controller:  description,
              decoration: const InputDecoration(
                labelText: 'Meal description',
                hintText: 'Kapsalon is a delicious dutch dish',
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
            child: TextFormField(
              controller:  img,
              decoration: const InputDecoration(
                labelText: 'Meal img (optional)',
                hintText: 'img_of_a_kapsalon.jpg',
                
                              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a list name';
                }
                return null;
              },
            ),
          ),
         
        ],
      ),
    ),
  actions: [
ElevatedButton(
            onPressed: () => retrieveSubcollection(),
           
              child: const Text('Create list'),
            ) ,

  ],
  );
}
}
