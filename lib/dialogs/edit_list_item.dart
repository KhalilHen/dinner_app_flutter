import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class EditListItemDialog extends StatefulWidget {
  final String docId;
  final String itemId;
  final String mealName;
  final String mealDescription;
  final String mealImage;
  const EditListItemDialog({
    Key? key,
    required this.docId,
    required this.itemId,
    required this.mealName,
    required this.mealDescription,
    required this.mealImage,
  }) : super(key: key);

  @override
  _EditListItemDialogState createState() => _EditListItemDialogState();
}

class  _EditListItemDialogState  extends State<EditListItemDialog> {
  final key = GlobalKey<FormState>();
  final description = TextEditingController();
  final img = TextEditingController();
  final mealName = TextEditingController();
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    description.text = widget.mealDescription;
    img.text = widget.mealImage;
    mealName.text = widget.mealName;
  }

  Future<void> updateMealItem() async {
    if (key.currentState!.validate()) {
      final mealTitle = mealName.text;
      final mealDescription = description.text;
      final mealImage = img.text;

      await db
          .collection('list')
          .doc(widget.docId)
          .collection('mealItem')
          .doc(widget.itemId)
          .update({
        'mealName': mealTitle,
        'mealDescription': mealDescription,
        'mealImage': mealImage,
      });

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Meal Item'),
      content: Form(
        key: key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: mealName,
              decoration: InputDecoration(
                labelText: 'Meal Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a meal name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: description,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: img,
              decoration: InputDecoration(
                labelText: 'Image ',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an image ';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: updateMealItem,
          child: Text('Update'),
        ),
      ],
    );
  }
}