import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// Import your Meal model here
import '../post.dart';
import 'add_meal_to_list.dart';

class ChooseMealDialog extends StatefulWidget {
  const ChooseMealDialog({Key? key}) : super(key: key);

  @override
  _ChooseMealDialogState createState() => _ChooseMealDialogState();
}

class _ChooseMealDialogState extends State<ChooseMealDialog> {
  late StreamController<Meal> _mealStreamController;
  late Stream<Meal> _mealStream;

  @override
  void initState() {
    super.initState();
    _mealStreamController = StreamController<Meal>();
    _mealStream = _mealStreamController.stream;
    _fetchNextMeal();
  }

  Future<void> _fetchNextMeal() async {
    try {
      final meal = await fetchMeals();
      _mealStreamController.add(meal);
    } catch (e) {
      _mealStreamController.addError('Failed to fetch meal: $e');
    }
  }

  Future<Meal> fetchMeals() async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> mealsJson = data['meals'];
      List<Meal> meals = mealsJson.map((mealJson) => Meal.fromJson(mealJson)).toList();
      return meals[0];
    } else {
      throw Exception('Failed to load meal');
    }
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
