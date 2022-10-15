import 'package:flutter/material.dart';
import 'package:mealplus/models/meal.dart';
import 'package:mealplus/screens/meal_information_screen.dart';
import 'package:provider/provider.dart';

import '../myProvider/language_provider.dart';

class Meals extends StatelessWidget {
  final String id;
//  final String title;

  final String imageUrl;
  final int duration;
  final Affordability affordability;
  final Complexity complexity;

  Meals({
     required this.id,
 //   @required this.title,
    required this.imageUrl,
     required this.duration,
     required this.affordability,
     required this.complexity,
  });

  // String get affordabilityText {
  //   switch (affordability) {
  //     case Affordability.Affordable:
  //       return 'Affordable';
  //       break;
  //     case Affordability.Pricey:
  //       return 'Pricey';
  //       break;
  //     case Affordability.Luxurious:
  //       return 'Luxurious';
  //       break;
  //     default:
  //       return 'Unknown';
  //   }
  // }
  //
  // String get complextityText {
  //   switch (complexity) {
  //     case Complexity.Simple:
  //       return 'Simple';
  //       break;
  //     case Complexity.Challenging:
  //       return 'Challenging';
  //       break;
  //     case Complexity.Hard:
  //       return 'Hard';
  //       break;
  //     default:
  //       return 'Unknown';
  //   }
  // }

  selctMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealInformationScreen.route, arguments: {
      'id': id,
     // 'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () => selctMeal(context),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const SizedBox(
              width: 10,
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Hero(
                    tag: id,
                    child: FadeInImage(
                      placeholder:const AssetImage('assets/assets/images/a2.png'),
                      image: NetworkImage(
                        imageUrl,

                      ),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 15,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black54),
                    child: Text(
                      lan.getText('meal-$id'),
                      style: Theme.of(context).textTheme.titleSmall,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded,
                          color: Colors.black, size: 30),
                      if (duration <= 10)
                        Text(
                          ' $duration ' + lan.getText('min1'),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          textWidthBasis: TextWidthBasis.parent,
                        ),
                      if (duration > 10)
                        Text(
                          ' $duration ' + lan.getText('min2'),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                    ],
                  ),
                  const SizedBox(width: 3),
                  Row(
                    children: [
                      const Icon(Icons.work, color: Colors.black, size: 30),
                      Text(
                        lan.getText('$complexity'),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(width: 3),
                  Row(
                    children: [
                      const Icon(Icons.attach_money_rounded,
                          color: Colors.black, size: 30),
                      Text(
                        lan.getText('$affordability'),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
