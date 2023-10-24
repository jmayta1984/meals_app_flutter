import 'package:flutter/material.dart';
import 'package:meals_app/services/meal_service.dart';

class MealList extends StatefulWidget {
  const MealList({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<MealList> createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  MealService? _mealService;
  List? _meals;

  initialize() async {
    _meals = await _mealService?.getAll(widget.categoryName) ?? [];
    setState(() {
      _meals = _meals;
    });
  }

  @override
  void initState() {
    _mealService = MealService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _meals?.length ?? 0,
          itemBuilder: ((context, index) => Text(_meals?[index].name ?? ''))),
    );
  }
}
