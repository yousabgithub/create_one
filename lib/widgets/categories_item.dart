import 'package:flutter/material.dart';
import '../myProvider/language_provider.dart';
import '../screens/category_meals.dart';
import 'package:provider/provider.dart';

class CategoriesItem extends StatelessWidget {
  final String id;

  final Color color;

  const CategoriesItem({
    required this.id,
    required this.color,
  });

  selectCat(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMeals.route, arguments: {
      'id': id,
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return InkWell(
      onTap: () => selectCat(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(12),
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
          child: Text(
            lan.getText('cat-$id'),
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'Style1',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
