import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:mealplus/models/meal.dart';
import 'package:mealplus/myProvider/language_provider.dart';
import 'package:mealplus/myProvider/meal_provider.dart';
import 'package:mealplus/myProvider/theme_provider.dart';
import 'package:mealplus/widgets/meals.dart';
import 'package:provider/provider.dart';

class CategoryMeals extends StatefulWidget {
  static const route = 'CategoryMeals_route';

  @override
  State<CategoryMeals> createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
 late Map<String, String> dataReception;

late  String catID ;
  List<Meal> mealsList=<Meal>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dataReception =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    catID = dataReception['id']!;
   // catTitle = dataReception['title'];
    final List<Meal> availableMeal =
        Provider.of<MealProvider>(context).availableMeal;
    mealsList = availableMeal
        .where((element) => element.categories.contains(catID))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;

    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dW = MediaQuery.of(context).size.width;

    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
           lan.getText('cat-$catID'),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: useWhiteForeground(primaryColor)
                      ? Colors.white
                      : Colors.black,
                ),
          ),
          centerTitle: true,
        ),
        body: InteractiveViewer(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: dW <= 400 ? 400 : 500,
              // childAspectRatio: isLandScape ? 2.4 / 2 : 2.65 / 2,
              childAspectRatio: isLandScape ? dW / (dW * .8) : dW / (dW * .7),
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            itemCount: mealsList.length,
            itemBuilder: (ctx, index) => Meals(
              id: mealsList[index].id,
              //title: mealsList[index].title,
              imageUrl: mealsList[index].imageUrl,
              duration: mealsList[index].duration,
              affordability: mealsList[index].affordability,
              complexity: mealsList[index].complexity,
            ),
          ),
        ),
      ),
    );
  }
}
