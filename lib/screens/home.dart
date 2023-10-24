import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CategoryList() ,
    );
  }
}