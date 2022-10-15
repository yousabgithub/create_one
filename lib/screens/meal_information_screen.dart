
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mealplus/dummy_data.dart';
import 'package:mealplus/myProvider/language_provider.dart';
import 'package:mealplus/myProvider/meal_provider.dart';
import 'package:provider/provider.dart';

class MealInformationScreen extends StatefulWidget {
  static const route = 'MealInformationScreen';

  @override
  State<MealInformationScreen> createState() => _MealInformationScreenState();
}

class _MealInformationScreenState extends State<MealInformationScreen> {
late  String mealID;
 // String mealTitle;
  dynamic mealElement;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dataReception =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    mealID = dataReception['id']!;
    // mealTitle = dataReception['title'];

    mealElement = DUMMY_MEALS.firstWhere((element) => element.id == mealID);
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    List<String> ingredientsLan =
        lan.getText('ingredients-$mealID') as List<String>;

    var stepsLan = lan.getText('steps-$mealID') as List<String>;
    var liIngredient = ListView.builder(
      /// itemCount: mealElement.ingredients.length,
      padding: const EdgeInsets.all(0),
      itemCount: ingredientsLan.length,
      itemBuilder: (ctx, index) => Card(
        margin: const EdgeInsets.all(5),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color.fromARGB(255, 102, 0, 51),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            ingredientsLan[index],
            //mealElement.ingredients[index],
            style: Theme.of(ctx)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white70),
          ),
        ),
      ),
    );

    var liSteps = ListView.builder(
      //  itemCount: mealElement.steps.length,
      padding: const EdgeInsets.all(0),
      itemCount: stepsLan.length,
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(3),
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: const Color.fromARGB(255, 102, 0, 51),
              child: Text('# ${index + 1}'),
            ),
            title: Text(
              stepsLan[index],
              // mealElement.steps[index],
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Divider(
            color: Theme.of(context).textTheme.bodySmall!.color,
          ),
        ],
      ),
    );

    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Provider.of<MealProvider>(context, listen: true)
                  .isMealFavorite(mealID)
              ? Icons.star
              : Icons.star_border),
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .setFavorite(mealID),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: isLandscape ? 200 : 300,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                    color:useWhiteForeground(Theme.of(context).primaryColor)? Colors.white38:Colors.black54,
                  ),
                  child: Text(
                    lan.getText('meal-$mealID'),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color:Theme.of(context).textTheme.titleMedium!.color

                    )  ,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
                centerTitle: true,
                background: Hero(
                  tag: mealID,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      placeholder:
                          const AssetImage('assets/assets/images/a2.png'),
                      image: NetworkImage(
                        mealElement.imageUrl,
                      ),
                      fit: BoxFit.cover,
                      height: isLandscape ? 200 : 300,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        buildText(lan.getText('ingredient'), context),
                        const SizedBox(height: 10),
                        buildContainer(liIngredient, context),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        buildText(lan.getText('steps'), context),
                        buildContainer(liSteps, context),
                      ],
                    )
                  ],
                ),
              if (!isLandscape)
                Column(
                  children: [
                    buildText(lan.getText('ingredient'), context),
                    const SizedBox(height: 10),
                    buildContainer(liIngredient, context),
                    buildText(lan.getText('steps'), context),
                    buildContainer(liSteps, context),
                  ],
                ),
              const SizedBox(height: 50),
            ])),
          ],
        ),
      ),
    );
  }

  buildContainer(Widget widget, BuildContext ctx) {
    var isLandscape = MediaQuery.of(ctx).orientation == Orientation.landscape;
    var dW = MediaQuery.of(ctx).size.width;
    var dH = MediaQuery.of(ctx).size.height;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(7),

      ///(dW * 0.5 - 30)== 30 هي مجموع المارجن مرتين ع شان انا استدعيتها مرتين + مجموع
      width: isLandscape ? (dW * 0.5 - 30) : dW,
      height: isLandscape ? (dH * 0.5) : (dH * .25),
      decoration: BoxDecoration(
        color: Theme.of(ctx).textTheme.titleSmall!.color,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: widget,
    );
  }

  buildText(String text, BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.titleMedium,
      ),
    );
  }
}
