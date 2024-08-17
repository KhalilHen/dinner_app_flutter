import 'package:dinnerapp/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// Import your Meal model here
import '../post.dart';
import 'add_meal_to_list.dart';
import '/controllers/fetch_controller.dart';
class ChooseMealDialog extends StatefulWidget {
  const ChooseMealDialog({Key? key}) : super(key: key);

  @override
  _ChooseMealDialogState createState() => _ChooseMealDialogState();
}

class _ChooseMealDialogState extends State<ChooseMealDialog> {
  late StreamController<Meal> _mealStreamController;
  late Stream<Meal> _mealStream;

final controller = FetchController();


  @override
  void initState() {
    super.initState();
    _mealStreamController = StreamController<Meal>();
    _mealStream = _mealStreamController.stream;
    _fetchNextMeal();
  }
  Future<void> _fetchNextMeal() async {
    await controller.fetchNextMeal(_mealStreamController);
  }



 

  @override
  void dispose() {
    _mealStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose a meal'),
      content: StreamBuilder<Meal>(
        stream: _mealStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No meal available'));
          } else {
            final meal = snapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(meal.idMeal),
                Text(meal.strMeal),
                Text('Category: ${meal.strCategory}'),
                Image.network(meal.strMealThumb),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {  
                        return AddMealDialog(idMeal: meal.idMeal, name: meal.strMeal);
                      },
                    );
                  },
                  child: Text('Pick'),
                ),
              ],
            );
          }
        },
      ),
      actions: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _fetchNextMeal();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}
