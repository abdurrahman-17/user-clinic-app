// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:user_clinic_token_app/main.dart';
//
// class MyAppTheme {
//   static myThemes(bool isDark, BuildContext context) {
//     return ThemeData(
//       appBarTheme:  AppBarTheme(
//         backgroundColor: isDark ? Colors.black : Color(0xff4889fd),
//       ),
//       scaffoldBackgroundColor: isDark ? Colors.grey.shade900 : Color(0xffe5e5e5),
//       iconTheme: isDark
//           ? IconThemeData(color: Colors.white)
//           : IconThemeData(color: Color(0xff4889fd)),
//       primaryColor: isDark ? Colors.black : Color(0xff4889fd),
//       primaryColorDark: isDark ? Colors.black : Color(0xff619AFF),
//       primaryColorLight: isDark ? Colors.white : Colors.black,
//       accentColor:isDark ? Colors.black : Colors.white ,
//       textSelectionColor: isDark ? Colors.white : Colors.white,
//       backgroundColor: isDark ? Colors.white : Color(0xff4889fd),
//       disabledColor: isDark ? Colors.grey.shade50 : Colors.grey,
//       colorScheme: isDark ? ColorScheme.dark() : ColorScheme.light(),
//       buttonColor: isDark ? Colors.tealAccent : Colors.redAccent,
//     );
//   }
// }
//
// class ThemeNotifier with ChangeNotifier{
//   late bool _isDark;
//
//   bool get isDark => _isDark;
//
//   ThemeNotifier(){
//     _isDark = false;
//     _loadFromPrefs();
//   }
//
//   toggleTheme(bool value){
//     _isDark = value;
//     notifyListeners();
//     _saveToPrefs();
//   }
//
//   _loadFromPrefs()async{
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     _isDark = preferences.getBool('theme') ?? false;
//     notifyListeners();
//     return _isDark;
//   }
//
//   _saveToPrefs() async{
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setBool('theme', _isDark);
//   }
// }