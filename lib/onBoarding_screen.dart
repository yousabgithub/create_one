import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mealplus/myProvider/language_provider.dart';

import 'package:mealplus/screens/filters.dart';
import 'package:mealplus/screens/tabs_screen.dart';
import 'package:mealplus/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoadringScreen extends StatefulWidget {
  @override
  State<OnBoadringScreen> createState() => _OnBoadringScreenState();
}

class _OnBoadringScreenState extends State<OnBoadringScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/assets/images/image.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          lan.getText('smart'),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: useWhiteForeground(Colors.white)
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                      Container(
                        padding:   EdgeInsets.symmetric(
                            vertical: 10, horizontal:isLandScape?5: 15),
                        margin:  EdgeInsets.only(

                          left:20 ,right:20 ,
                            bottom:isLandScape ? 40: 0 ,
                           ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black54),
                        child: Column(
                          children: [
                            Text(
                              lan.getText('choose-lan'),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: useWhiteForeground(Colors.white)
                                          ? Colors.black
                                          : Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  lan.getText('lan-2'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              useWhiteForeground(Colors.white)
                                                  ? Colors.black
                                                  : Colors.white),
                                ),
                                Switch(
                                  value: lan.isEn,
                                  onChanged: (newLan) {
                                    Provider.of<LanguageProvider>(context,
                                            listen: false)
                                        .onChangeLan(newLan);
                                  },
                                ),
                                Text(
                                  lan.getText('lan-1'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              useWhiteForeground(Colors.white)
                                                  ? Colors.black
                                                  : Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ThemeScreen(fromOnBoarding: true,),
                FiltersScreen(fromOnBoarding: true,),
              ],
              onPageChanged: (newIndex) => setState(() {
                _currentPage = newIndex;
              }),
            ),
            Builder(
                builder: (context) => Align(
                      alignment: const Alignment(0, 0.85),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                          ),
                          child: Text(
                            lan.getText('start'),
                            style: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () async{
                            Navigator.of(context)
                                .pushReplacementNamed(TabsScreen.route);

                            var pref=await SharedPreferences.getInstance();
                            pref.setBool('watch', true);
                          },
                        ),
                      ),
                    )),
            Indicator(_currentPage),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
 final int index;

   Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildCircle(context, 0),
          buildCircle(context, 1),
          buildCircle(context, 2),
        ],
      ),
    );
  }

  buildCircle(BuildContext ctx, int i) {
    return index == i
        ? Icon(
            Icons.star,
            size: 18,
            color: Theme.of(ctx).primaryColor,
          )
        : Container(
            height: 15,
            width: 15,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(ctx).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
          );
  }
}
