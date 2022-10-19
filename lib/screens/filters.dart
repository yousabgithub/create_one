import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mealplus/myProvider/language_provider.dart';
import 'package:mealplus/myProvider/meal_provider.dart';
import 'package:mealplus/myProvider/theme_provider.dart';
import 'package:mealplus/screens/my_drawer.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  static const route = 'FiltersScreen_route';
 final bool fromOnBoarding;

  FiltersScreen({this.fromOnBoarding = false});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    var filter = Provider.of<MealProvider>(context).filter;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: widget.fromOnBoarding ? null : MyDrawer(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: widget.fromOnBoarding ? false : true,
                elevation: widget.fromOnBoarding ? 0 : 5,
                backgroundColor: widget.fromOnBoarding
                    ? Theme.of(context).canvasColor
                    : Theme.of(context).primaryColor,
                title: widget.fromOnBoarding
                    ? null
                    : Text(
                        lan.getText('filter-title'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: useWhiteForeground(primaryColor)
                                    ? Colors.white
                                    : Colors.black),
                      ),
                centerTitle: true,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    lan.getText('filter-txtBody'),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                buildSwitchListTile(
                    context: context,
                    title: lan.getText('gluten-title'),
                    sub: lan.getText('gluten-subTitle'),
                    val: filter['gluten']!,
                    onChange: (newVal) => setState(() {
                          filter['gluten'] = newVal;
                          Provider.of<MealProvider>(context, listen: false)
                              .setFilter();
                        })),
                buildSwitchListTile(
                    context: context,
                    title: lan.getText('lactose-title'),
                    sub: lan.getText('lactose-subTitle'),
                    val: filter['lactose']!,
                    onChange: (newVal) => setState(() {
                          filter['lactose'] = newVal;
                          Provider.of<MealProvider>(context, listen: false)
                              .setFilter();
                        })),
                buildSwitchListTile(
                    context: context,
                    title: lan.getText('vegan-title'),
                    sub: lan.getText('vegan-subTitle'),
                    val: filter['vegan']!,
                    onChange: (newVal) => setState(() {
                          filter['vegan'] = newVal;
                          Provider.of<MealProvider>(context, listen: false)
                              .setFilter();
                        })),
                buildSwitchListTile(
                    context: context,
                    title: lan.getText('vegetarian-title'),
                    sub: lan.getText('vegetarian-subTitle'),
                    val: filter['vegetarian']!,
                    onChange: (newVal) => setState(() {
                          filter['vegetarian'] = newVal;
                          Provider.of<MealProvider>(context, listen: false)
                              .setFilter();
                        })),

                const SizedBox(
                  height: 100,
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }

  SwitchListTile buildSwitchListTile({
    required BuildContext context,
    required String title,
    required String sub,
    required bool val,
    required Function(bool x) onChange,
  }) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.blueGrey,
      activeColor: Colors.blue,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: 30, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(sub, style: Theme.of(context).textTheme.labelSmall),
      value: val,
      onChanged: onChange,
    );
  }
}
