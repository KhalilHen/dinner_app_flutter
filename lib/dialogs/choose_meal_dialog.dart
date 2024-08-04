import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// import 'package:beta_app/models/meal.dart';
import '../post.dart'; 

class ChooseMealDialog extends StatefulWidget {
  const ChooseMealDialog({Key? key}) : super(key: key);

  @override
  _ChooseMealDialogState createState() => _ChooseMealDialogState();
}

class _ChooseMealDialogState extends State<ChooseMealDialog> {
    int mealIndex = 0;
int index = 0;

bool pressed = false;

List <String> meals = [ 'rice', 'beans', 'spaghetti', 'yam', 'potato', 'plantain', 'moi moi'];

var test = [];

//
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

// List meals.add('rice');
void increseIndex() {

mealIndex++;
}

  var  dinnermeal = ['rice', 'beans', 'spaghetti', 'yam', 'potato', 'plantain', 'moi moi'];


void addItems() {
  var  dinnermeal = [];

  dinnermeal.add('rice');
dinnermeal.add('beans');
dinnermeal.add('spaghetti');
dinnermeal.add('yam');
dinnermeal.add('potato');
dinnermeal.add('plantain');
dinnermeal.add('moi moi');
}
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose a meal'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

 FutureBuilder<Meal>(

future: fetchMeals(),
builder: (context, snapshot) {
  

if(snapshot.hasData) {

  return Column(
    children: [

      Text(snapshot.data!.strMeal),

      Text('Difficulty: ${snapshot.data!.strCategory}'),
      Image.network(snapshot.data!.strMealThumb),
    ],
  );
}
else {
 return Center(
                child: CircularProgressIndicator(),
              );
}

},

 

),



        ],
    ),



  




        

//
//
          // ListTile(
          //   title: const Text('Breakfast'),
          //   onTap: () {
          //     Navigator.of(context).pop('Breakfast');
          //   },
          // ),
          // ListTile(
          //   title: const Text('Lunch'),
          //   onTap: () {
          //     Navigator.of(context).pop('Lunch');
          //   },
          // ),
          // ListTile(
          //   title: const Text('Dinner'),
          //   onTap: () {
          //     Navigator.of(context).pop('Dinner');
          //   },
          // ),
        
      
      actions: [

        Row(
  
 children: [
  ElevatedButton(
    onPressed: () {
      Navigator.of(context).pop('');
    },
    child: const Text('Cancel'),
  ),


  ElevatedButton(onPressed: null, child: Text('Pick'),
  ),

  ElevatedButton(onPressed:() {

// It should here fetch another meal from the api


  }, child: Text('Next'))
 ],

),
      ],
    );
  }
}