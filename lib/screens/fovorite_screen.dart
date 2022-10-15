import 'package:flutter/material.dart';
import 'package:mealplus/models/meal.dart';
import 'package:mealplus/myProvider/meal_provider.dart';
import 'package:mealplus/widgets/meals.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Meal> favoriteMeals =
        Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    bool isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    var dW=MediaQuery.of(context).size.width;
    return Scaffold(


      body: favoriteMeals.isEmpty
          ? Center(
              child: Text(
                'Your list of favorite meals is empty..',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                   ,
                textAlign: TextAlign.center,
              ),
            )
          : GridView.builder(

             gridDelegate:   SliverGridDelegateWithMaxCrossAxisExtent(
               maxCrossAxisExtent :dW<=400? 400:500  ,
               childAspectRatio:  isLandscape? dW/(dW*.7): dW/(dW*.7),

             ),
              itemCount: favoriteMeals.length,
              itemBuilder: (ctx, index) => Meals(
                id: favoriteMeals[index].id,
               // title: favoriteMeals[index].title,
                imageUrl: favoriteMeals[index].imageUrl,
                duration: favoriteMeals[index].duration,
                affordability: favoriteMeals[index].affordability,
                complexity: favoriteMeals[index].complexity,
              ),
            ),
    );
  }
}
