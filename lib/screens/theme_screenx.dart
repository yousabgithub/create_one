import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mealplus/myProvider/language_provider.dart';
import 'package:mealplus/myProvider/theme_provider.dart';
import 'package:mealplus/screens/my_drawer.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  static const route = 'ThemeScreenX_route';
  bool  fromOnBoarding;
  ThemeScreen({this.fromOnBoarding = false});
  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context,listen: true);

    var primaryColor = Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    return Directionality(
      textDirection: lan.isEn?  TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        drawer:fromOnBoarding?null: MyDrawer(),

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: fromOnBoarding?0:5,
              backgroundColor: fromOnBoarding? Theme.of(context).canvasColor :
              Theme.of(context).primaryColor,
              pinned:fromOnBoarding? false:true,
              title: fromOnBoarding? null:Text(lan.getText('theme-title',



              ),
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium!.copyWith(
                    color: useWhiteForeground(primaryColor)? Colors.white:Colors.black
                ),

              ),
              centerTitle: true,

            ),
            SliverList(delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  lan.getText('theme-txtBody1'),
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lan.getText('theme-txtBody2'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 10),
              buildRadioListTile(
                  ctx: context,
                  themeMode: ThemeMode.system,
                  txt:  lan.getText('theme-system')),
              buildRadioListTile(
                ctx: context,
                themeMode: ThemeMode.light,
                txt: lan.getText('theme-light'),
                icon: Icons.wb_sunny_outlined,
              ),
              buildRadioListTile(
                  ctx: context,
                  themeMode: ThemeMode.dark,
                  txt:lan.getText('theme-dark'),
                  icon: Icons.nightlight_round),
              buildListTile(context, lan.getText('theme-primary')),
              buildListTile(context, lan.getText('theme-accent')),
              SizedBox(height: fromOnBoarding ?   100:30,),
            ]))
          ],

        ),
      ),
    );
  }

  buildRadioListTile(
      { required BuildContext ctx,
       required ThemeMode themeMode,
       required String txt,
      IconData? icon}) {
    return RadioListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        activeColor: Theme.of(ctx).textTheme.titleMedium!.color,
        title: Text(
          txt,
          style: Theme.of(ctx).textTheme.titleMedium,
        ),
        secondary: Icon(
          icon,
          color: Theme.of(ctx).textTheme.titleMedium!.color,
        ),
        value: themeMode,
        groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
        onChanged: (newTheme) => Provider.of<ThemeProvider>(ctx, listen: false)
            .onChangeTheme(newTheme));
  }

  buildListTile(BuildContext ctx, String txt) {
    var lan=Provider.of<LanguageProvider>(ctx,listen: true);
    var primaryColor =
        Provider.of<ThemeProvider>(ctx, listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(ctx, listen: true).accentColor;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
      title: Text(
           txt   ,
        style: Theme.of(ctx).textTheme.titleMedium!.copyWith(fontSize: 20),
      ),
      trailing: CircleAvatar(
        radius: 15,
        //backgroundColor: txt == 'primary' ? primaryColor : accentColor,
        backgroundColor:lan.isEn? txt == 'Choose your primary color' ? primaryColor : accentColor
        :txt=='اختر لونك الأساسي'?primaryColor:accentColor,

      ),
      onTap: () {
        showDialog(
            context: ctx,
            builder: (_) => AlertDialog(
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor:lan.isEn? txt == 'Choose your primary color'
                          ? Provider.of<ThemeProvider>(ctx).primaryColor
                          : Provider.of<ThemeProvider>(ctx).accentColor:

                      txt=='اختر لونك الأساسي'?Provider.of<ThemeProvider>(ctx).primaryColor
                          : Provider.of<ThemeProvider>(ctx).accentColor
                      ,
                      onColorChanged: (newColor) =>
                          Provider.of<ThemeProvider>(ctx, listen: false)
                              .onChangeColor(
                                  newColor,lan.isEn? txt == 'Choose your primary color' ? 1 : 2:

                          txt=='اختر لونك الأساسي'?1:2

                          )


                      ,
                      colorPickerWidth: 300,
                      pickerAreaHeightPercent: 0.7,
                      displayThumbColor: true,
                      showLabel: false,
                    ),
                  ),
                ));
      },
    );
  }
}
