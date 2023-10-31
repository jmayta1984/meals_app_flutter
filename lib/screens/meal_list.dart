import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/repositories/meal_repository.dart';
import 'package:meals_app/services/meal_service.dart';
import 'package:readmore/readmore.dart';

class MealList extends StatefulWidget {
  const MealList({super.key, required this.category});
  final Category category;

  @override
  State<MealList> createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  MealService? _mealService;
  List? _meals;

  initialize() async {
    _meals = await _mealService?.getAll(widget.category.name) ?? [];
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
    return ListView.builder(
        itemCount: _meals == null ? 0 : _meals!.length + 1,
        itemBuilder: ((context, index) {
          return index == 0
              ? CategoryHeader(category: widget.category)
              : MealItem(meal: _meals?[index - 1]);
        }));
  }
}

class CategoryHeader extends StatefulWidget {
  const CategoryHeader({super.key, required this.category});

  final Category category;

  @override
  State<CategoryHeader> createState() => _CategoryHeaderState();
}

class _CategoryHeaderState extends State<CategoryHeader> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReadMoreText(
        widget.category.description,
        trimLines: 2,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ));
  }
}

class MealItem extends StatefulWidget {
  const MealItem({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  bool _favorite = false;
  MealRepository? _repository;

  initialize() async {
    _favorite = await _repository?.isFavorite(widget.meal) ?? false;
    if (mounted) {
      setState(() {
        _favorite = _favorite;
      });
    }
  }

  @override
  void initState() {
    _repository = MealRepository();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final image = Image.network(widget.meal.imageUrl);
    final icon = _favorite
        ? const Icon(
            Icons.favorite,
            color: Colors.red,
          )
        : const Icon(
            Icons.favorite,
            color: Colors.grey,
          );
    return Card(
        child: ListTile(
      leading: image,
      title: Text(
        widget.meal.name,
      ),
      trailing: IconButton(
        icon: icon,
        onPressed: () {
          if (mounted) {
            setState(() {
              _favorite = !_favorite;
            });
          }
          _favorite
              ? _repository?.insert(widget.meal)
              : _repository?.delete(widget.meal);
        },
      ),
    ));
  }
}
