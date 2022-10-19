import 'package:flutter/material.dart';

import '../onBoarding_screen.dart';

import '../screens/categories_screen.dart';
import '../screens/category_meals.dart';
import '../screens/filters.dart';
import '../screens/meal_information_screen.dart';
import '../screens/tabs_screen.dart';

import '../screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'myProvider/language_provider.dart';
import 'myProvider/meal_provider.dart';
import 'myProvider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var pref = await SharedPreferences.getInstance();

  var mainScreen =
      pref.getBool('watch') ?? false ? TabsScreen() : OnBoadringScreen();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (ctx) => MealProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (ctx) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (ctx) => LanguageProvider(),
        )
      ],
      child: MyApp(mainScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;

  MyApp(this.mainScreen);

  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;
    return MaterialApp(
      themeMode: tm,
      darkTheme: ThemeData(
        unselectedWidgetColor: Colors.white70,
        cardColor: const Color.fromARGB(255, 93, 93, 60),
        canvasColor: const Color.fromARGB(255, 0, 0, 51),
        textTheme: ThemeData.dark().textTheme.copyWith(
              titleSmall: const TextStyle(
                ///ThemeData.dark().textTheme.copyWith(
                color: Colors.white70, //  mealName
                fontSize: 25,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.fade,
              ),
              titleMedium: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: 'Style1',
                color: Colors.white70,
                // color: useWhiteForeground(primaryColor)? Colors.white:Colors.black
              ),
              titleLarge: const TextStyle(
                color: Colors.white70,

                ///MealsDrawer And All Attribute
                fontSize: 25,
                fontWeight: FontWeight.w600,
                fontFamily: 'RobotoCondensed',
              ),
              bodySmall: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w300,
                fontFamily: 'Style1',
              ),
              bodyLarge: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w300,
                fontFamily: 'RobotoCondensed',
              ),
              labelSmall: const TextStyle(
                /// SubTitle Filters
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
            .copyWith(secondary: accentColor),
      ),
      theme: ThemeData(
        primarySwatch: primaryColor,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
            .copyWith(secondary: accentColor),
        canvasColor: const Color.fromARGB(255, 255, 179, 179),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                fontFamily: 'RobotoCondensed',
              ),
              titleMedium: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: 'Style1',
                color: Colors.black,
              ),
              titleSmall: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Style1',
                  color: Colors.white),
              bodySmall: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Style1',
                  color: Colors.black),
              bodyLarge: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w300,
                fontFamily: 'RobotoCondensed',
              ),
              labelSmall: const TextStyle(
                /// SubTitle Filters
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
      ),
      routes: {
        '/': (context) => mainScreen,
        TabsScreen.route: (context) => TabsScreen(),
        FiltersScreen.route: (context) => FiltersScreen(),
        CategoryMeals.route: (context) => CategoryMeals(),
        MealInformationScreen.route: (context) => MealInformationScreen(),
        ThemeScreen.route: (context) => ThemeScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Categories', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: CategoriesScreen(),
    );
  }
}
