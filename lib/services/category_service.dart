import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meals_app/models/category.dart';

class CategoryService {
  String baseUrl = 'https://www.themealdb.com/api/json/v1/1/categories.php';

  Future<List> getAll() async {
    final http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == HttpStatus.ok) {
      log(response.body);
      final jsonResponse = json.decode(response.body);
      final List maps = jsonResponse['categories'];
      return maps.map((map) => Category.fromJson(map)).toList();
    }
    return [];
  }
}
