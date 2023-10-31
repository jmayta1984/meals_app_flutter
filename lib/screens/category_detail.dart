import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meal_list.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({super.key, required this.category});
  final Category category;

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    final image = Image.network(widget.category.imageUrl);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.category.name),
                  background: Hero(tag: widget.category.id, child: image)),
            ),
          ];
        },
        body: MealList(category: widget.category),
      ),
    );
  }
}
