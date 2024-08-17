import 'dart:convert';
import 'package:http/http.dart' as http;

import '/post.dart'; 

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// Define the base URL for the API as a constant
const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/random.php';

class Controller {

Future<Meal> fetchMeals() async {

final url =  Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php');


final response = await http.get(url);

if (response.statusCode == 200) {      final data = json.decode(response.body);


   List<dynamic> mealsJson  = data['meals'];
      List<Meal> meals  = mealsJson
          .map((mealJson) => Meal.fromJson(mealJson))
          .toList();
      return meals[0];

} else {
  throw Exception('Failed to load meal');
}
}
}


