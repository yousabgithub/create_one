import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mealplus/myProvider/theme_provider.dart';

import 'package:mealplus/screens/tabs_screen.dart';

import 'package:mealplus/screens/theme_screen.dart';
import 'package:provider/provider.dart';

import '../myProvider/language_provider.dart';
import 'filters.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;

    var lanT = Provider.of<LanguageProvider>(context, listen: true);
    var lanF = Provider.of<LanguageProvider>(context, listen: false);
    return Directionality(
      textDirection: lanT.isEn? TextDirection.ltr:TextDirection.rtl,
      child: Drawer(
        child: ListView(
          children: [
            Image.asset(
              'assets/assets/images/iDrawer.jpg',
              //  width: double.infinity,
            ),
            const SizedBox(height: 20),
            buildListTile(context, lanT.getText('drawer_item1'), Icons.no_meals_outlined, () {
              Navigator.pushReplacementNamed(context, TabsScreen.route);
            }),
            Divider(
              color:
                  useWhiteForeground(primaryColor) ? primaryColor : Colors.black,
              height: 3,
            ),
            buildListTile(context, lanT.getText('drawer_item2'), Icons.settings, () {
              Navigator.pushReplacementNamed(context, FiltersScreen.route);
            }),
            Divider(
              color:
                  useWhiteForeground(primaryColor) ? primaryColor : Colors.black,
              height: 3,
            ),
            buildListTile(context, lanT.getText('drawer_item3'), Icons.color_lens, () {
              Navigator.pushReplacementNamed(context, ThemeScreen.route);
            }),
            Divider(
              color:
                  useWhiteForeground(primaryColor) ? primaryColor : Colors.black,
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  lanT.getText('lan-2'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Switch(
                    inactiveThumbColor:
                        Provider.of<ThemeProvider>(context).tm == ThemeMode.dark
                            ? null
                            : Colors.black,
                    activeColor: primaryColor,
                    value: lanT.isEn,
                    onChanged: (newLan) => lanF.onChangeLan(newLan),
                  ),
                  Text(
                    lanT.getText('lan-1'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildListTile(
      BuildContext ctx, String text, IconData iconData, Function() function) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Text(
        text,
        style: Theme.of(ctx).textTheme.titleLarge,
      ),
      leading: Icon(iconData,
          size: 20, color: Theme.of(ctx).textTheme.titleLarge!.color),
      trailing: Icon(Icons.arrow_forward_ios_outlined,
          size: 20, color: Theme.of(ctx).textTheme.titleLarge!.color),
      onTap: function,
    );
  }
}
