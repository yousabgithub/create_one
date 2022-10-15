import 'package:flutter/material.dart';
import 'package:mealplus/myProvider/meal_provider.dart';

import 'package:provider/provider.dart';


import '../widgets/categories_item.dart';

class CategoriesScreen extends StatelessWidget {
  static const route = 'CategoriesScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView(
          //scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          children: Provider.of<MealProvider>(context)
              .availableCategories
              .map(
                (catData) => CategoriesItem(
                    color: catData.color,  id: catData.id),
              )
              .toList(),
        ),
      ),
    );
  }
}
