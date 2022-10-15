import 'package:flutter/material.dart';
import 'package:mealplus/myProvider/language_provider.dart';
import 'package:mealplus/screens/category_meals.dart';
import 'package:provider/provider.dart';

class CategoriesItem extends StatelessWidget {
  // static const route='CategoriesItem_route';
  final String id;
 // final String title;
  final Color color;

  const CategoriesItem({
     required this.id,
 //   @required this.title,
     required this.color,
  });

  selectCategorie(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMeals.route, arguments: {
      'id': id,
  //    'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context);
    return InkWell(
      onTap: () => selectCategorie(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius:BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(lan.getText('cat-$id'),
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
