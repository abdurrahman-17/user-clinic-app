// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:user_clinic_token_app/utils/provider/theme_provider.dart';
//
//
//
// class ChangeThemeButtonWidget extends StatelessWidget {
//   const ChangeThemeButtonWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeNotifier>(
//       builder: (context, notifier, _) {
//         return Switch.adaptive(
//           value: notifier.isDark,
//           onChanged: (value) {
//             notifier.toggleTheme(value);
//           },
//         );
//       },
//     );
//   }
// }