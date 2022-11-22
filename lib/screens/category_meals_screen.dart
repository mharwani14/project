import 'package:flutter/material.dart';

import 'package:meals/widgets/meal_item.dart';

import '../models/meal.dart';

class Categorymeals extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  Categorymeals(this.availableMeals);

  @override
  State<Categorymeals> createState() => _CategorymealsState();
}

class _CategorymealsState extends State<Categorymeals> {
  // final String catId;
  String? categoryTitle;
  List<Meal>? displayedMeals;
  var loadedInitValue = false;
  @override
  void initState() {
    //...

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!loadedInitValue) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      loadedInitValue = true;
    }
    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(() {
      displayedMeals!.removeWhere((meal) {
        return meal.id == mealId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle as String),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: displayedMeals![index].id,
              title: displayedMeals![index].title,
              imageUrl: displayedMeals![index].imageUrl,
              duration: displayedMeals![index].duration,
              complexity: displayedMeals![index].complexity,
              affordability: displayedMeals![index].affordability,
              );
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}
