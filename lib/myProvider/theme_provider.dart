import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;
  var tm = ThemeMode.system;
  dynamic themeText = 's';

  onChangeTheme(newTheme) async {
    tm = newTheme;

    _getThemeModePref(tm);

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('themeText', themeText);



    notifyListeners();
  }

  onChangeColor(newColor, n) async {
    n == 1
        ? primaryColor = _toMaterialColor(newColor.hashCode)
        : accentColor = _toMaterialColor(newColor.hashCode);
    notifyListeners();


    var pref=await SharedPreferences.getInstance();

    pref.setInt('primaryColor', primaryColor.value);
    pref.setInt('accentColor', accentColor.value);
  }
  getColorModePref()async{
    var pref=await SharedPreferences.getInstance();

   primaryColor=_toMaterialColor(pref.getInt('primaryColor')?? 0xFFE91E63 );
   accentColor=_toMaterialColor(pref.getInt('accentColor')?? 0xFFFFC107);
   notifyListeners();
  }


  _toMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: const Color(0xFFFCE4EC),
        100: const Color(0xFFF8BBD0),
        200: const Color(0xFFF48FB1),
        300: const Color(0xFFF06292),
        400: const Color(0xFFEC407A),
        500: Color(colorVal),
        600: const Color(0xFFD81B60),
        700: const Color(0xFFC2185B),
        800: const Color(0xFFAD1457),
        900: const Color(0xFF880E4F),
      },
    );
  }

  _getThemeModePref(ThemeMode tm) {
    if (tm == ThemeMode.system) {
      themeText = 's';
    } else if (tm == ThemeMode.light) {
      themeText = 'l';
    } else if (tm == ThemeMode.dark) {
      themeText = 'd';
    }

  }

  getThemeModePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    themeText = pref.get('themeText') ?? 's' ;


     if (themeText == 'd') {
    tm = ThemeMode.dark;
    }

     else if (themeText == 's') {
      tm = ThemeMode.system;
    }
     else if (themeText == 'l') {
      tm = ThemeMode.light;
    }

     notifyListeners();
  }
}
