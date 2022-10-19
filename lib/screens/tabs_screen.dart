import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mealplus/myProvider/language_provider.dart';
import 'package:mealplus/myProvider/meal_provider.dart';
import 'package:mealplus/myProvider/theme_provider.dart';
import 'package:mealplus/screens/categories_screen.dart';
import 'package:mealplus/screens/fovorite_screen.dart';
import 'package:mealplus/screens/my_drawer.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static const route = 'TabsScreen_route';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //late List<Map<String, Object>> _pages;

  int index = 0;

  selectPage(int count) {
    setState(() {
      index = count;
    });
  }

  @override
  void initState() {
    super.initState();

    Provider.of<MealProvider>(context, listen: false).getDataPref();

    Provider.of<ThemeProvider>(context, listen: false).getThemeModePref();
    Provider.of<ThemeProvider>(context, listen: false).getColorModePref();
    Provider.of<LanguageProvider>(context, listen: false).getLanguagePref();
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true),
        _pages = [
          {
            'page': CategoriesScreen(),
            'title': lan.getText('categories-title')
          },
          {
            'page': FavoriteScreen(),
            'title': lan.getText('favorites-title'),
          },
        ];
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(_pages[index]['title'],
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: useWhiteForeground(primaryColor)
                      ? Colors.white
                      : Colors.black)),
          centerTitle: true,
        ),
        body: _pages[index]['page'],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          backgroundColor: primaryColor,
          selectedFontSize: 22,
          selectedItemColor:
              useWhiteForeground(primaryColor) ? Colors.blue : Colors.black,
          unselectedItemColor:
              useWhiteForeground(primaryColor) ? Colors.white : Colors.black,
          onTap: selectPage,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.category,
                size: 18,
              ),
              label: lan.getText('tab-categories'),
            ),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.favorite,
                  size: 18,
                ),
                label: lan.getText('tab-favorites')),
          ],
        ),
      ),
    );
  }
}
