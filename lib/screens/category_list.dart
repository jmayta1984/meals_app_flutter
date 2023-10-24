import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meal_list.dart';
import 'package:meals_app/services/category_service.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  CategoryService? _categoryService;
  List? _categories;

  initialize() async {
    _categories = await _categoryService?.getAll() ?? [];
    setState(() {
      _categories = _categories;
    });
  }

  @override
  void initState() {
    _categoryService = CategoryService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: _categories?.length ?? 0,
          itemBuilder: (context, index) {
            return CategoryItem(category: _categories?[index]);
          }),
    );
  }
}

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key, required this.category});
  final Category category;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    final image = Image.network(widget.category.imageUrl);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MealList(categoryName: widget.category.name);
        }));
      },
      child: Card(
        child: Column(
          children: [
            image,
            Text(widget.category.name),
          ],
        ),
      ),
    );
  }
}
