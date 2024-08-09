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

  bool pressed = false;
    final StreamController<Meal> _mealStreamController = StreamController<Meal>();

late Stream<Meal> _mealStream;
@override 
void initState() {

    _mealStream = _mealStreamController.stream;

      _fetchNextmeal();

}
  



   

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


 Future<void> _fetchNextmeal()  async{


 }



    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        title: const Text('Choose a meal'),
        content: StreamBuilder<Meal>(
        stream: _mealStream,

          builder: ( context,  snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No meal available'));
          }
          else {

            final meal = snapshot.data;
            return Column(

            );
          }
          },
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
  // fetchNextMeal();

    }, child: Text('Next'))
  ],

  ),
        ],
      );
    }
  }