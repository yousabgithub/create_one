import 'package:flutter/material.dart';
import 'package:mealplus/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  List<Meal> availableMeal = DUMMY_MEALS;
  List<Category> availableCategories = DUMMY_CATEGORIES;
  List<Meal> favoriteMeals = [];
  List<String> prefMealId = [];
  Map<String, bool> filter = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  setFilter() async {
    availableMeal = DUMMY_MEALS.where((meal) {
      if (filter['gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if (filter['lactose'] !&& !meal.isLactoseFree) {
        return false;
      }
      if (filter['vegan'] !&& !meal.isVegan) {
        return false;
      }
      if (filter['vegetarian'] !&& !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac = [];
    availableMeal.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((categoryId) {
          if (catId == categoryId.id) {
            // if( ac.any((categoryId))  => false)   ;
            if (!ac.any((categoryId) => catId == categoryId.id)) ac.add(categoryId);
          }
        });
      });
    });
    availableCategories = ac;

    notifyListeners();

    var pref = await SharedPreferences.getInstance();

    pref.setBool('gluten', filter['gluten']!);
    pref.setBool('lactose', filter['lactose']!);
    pref.setBool('vegan', filter['vegan']!);
    pref.setBool('vegetarian', filter['vegetarian']!);
  }

  getDataPref() async {
    var pref = await SharedPreferences.getInstance();

    filter['gluten'] = pref.getBool('gluten') ?? false;
    filter['lactose'] = pref.getBool('lactose') ?? false;
    filter['vegan'] = pref.getBool('vegan') ?? false;
    filter['vegetarian'] = pref.getBool('vegetarian') ?? false ;
    setFilter();
    prefMealId = pref.getStringList('prefMealId') ?? [];

    for (var mealId in prefMealId) {
      int existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);

      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }
    List<Meal> fm=[];
    favoriteMeals.forEach((favMeals) {
     availableMeal.forEach((avaMeal) {
       if(favMeals.id==avaMeal.id) fm.add(favMeals);
     });

    });
    favoriteMeals=fm;

    notifyListeners();
  }



  setFavorite(String mealID) async {
    var pref = await SharedPreferences.getInstance();

    int existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealID);

    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefMealId.remove(mealID);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealID));
      prefMealId.add(mealID);
    }

    pref.setStringList('prefMealId', prefMealId);
    notifyListeners();
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }
}
