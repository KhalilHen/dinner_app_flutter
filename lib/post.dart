// lib/models/meals.dart
class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String strCategory;
  final String strInstructions;

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.strCategory,
    required this.strInstructions,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      strCategory: json['strCategory'],
      strInstructions: json['strInstructions'],
    );
  }
}
