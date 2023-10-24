import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meals_app/models/meal.dart';

class MealService {
  final String baseUrl =
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=';

  Future<List> getAll(String categoryName) async {
    final http.Response response =
        await http.get(Uri.parse('$baseUrl$categoryName'));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final List meals = jsonResponse['meals'];
      return meals.map((map) => Meal.fromJson(map)).toList();
    }
    return [];
  }
}
