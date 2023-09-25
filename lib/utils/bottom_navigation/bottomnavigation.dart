// import 'package:flutter/material.dart';
// import 'package:flutter_screen_lock/flutter_screen_lock.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:user_clinic_token_app/utils/Theme/change_theme_button.dart';
// import 'package:user_clinic_token_app/utils/bottom_navigation_pages/doctors_list.dart';
// import 'package:user_clinic_token_app/utils/common/app_images.dart';
// import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
// import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
// import 'package:user_clinic_token_app/utils/localization/locale_constant.dart';
// import 'package:user_clinic_token_app/utils/model/language_data.dart';
// import 'package:user_clinic_token_app/view/homescreen/homescreen.dart';
//
// class NavigationScreen extends StatefulWidget {
//   const NavigationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NavigationScreen> createState() => _NavigationScreenState();
// }
//
// class _NavigationScreenState extends State<NavigationScreen> {
//   Future<void> localAuth(BuildContext context) async {
//     final localAuth = LocalAuthentication();
//     final didAuthenticate = await localAuth.authenticateWithBiometrics(
//       localizedReason: 'Please authenticate',
//     );
//     if (didAuthenticate) {
//       Future.delayed(Duration.zero).then((_){
//         Navigator.pop(context);
//     });
//           }
//   }
//
//   int _selectedIndex = 0;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     Doctor_list(),
//     Text(
//       'Index 2: Notification',
//     ),
//     Text(
//       'Index 3: Settings',
//     ),
//   ];
//
//   @override
//   void initState() {
//     Future.delayed(Duration(microseconds: 1000),(){
//       fingerprint();
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Stack(
//         children: [
//           Scaffold(
//             appBar: AppBar(
//               elevation: 0,
//               actions: [
//                 IconButton(onPressed: (){Navigator.pushNamed(context, RoutePaths.Notification);}, icon: Icon(Icons.notifications_none,color: Colors.white,))
//               ],
//             ),
//             key: _scaffoldKey,
//             drawer: buildDrawer(context),
//             extendBody: true,
//
//             body: Center(
//               child: _widgetOptions.elementAt(_selectedIndex),
//             ),
//
//             bottomNavigationBar: bottomNavigationBar(context),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget bottomNavigationBar(context) {
//     return Container(
//       height: 75,
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(35),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, 0),
//             blurRadius: 15,
//             color: Theme.of(context).primaryColorLight.withOpacity(0.20),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(35),
//         child: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 AppImages.SETHOSCOPE,
//                 height: 25,
//                 width: 22,
//                 color: _selectedIndex == 0 ? Colors.blueAccent : Colors.white,
//               ),
//
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 AppImages.CHART,
//                 height: 31,
//                 width: 31,
//                 color: _selectedIndex == 0 ? Colors.blueAccent : Colors.white,
//               ),
//
//               label: 'Doctor\'s List',
//             ),
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 AppImages.NOTIFICATION,
//                 height: 31,
//                 width: 31,
//                 color: _selectedIndex == 0 ? Colors.blueAccent : Colors.white,
//               ),
//               label: 'Notification',
//             ),
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 AppImages.SETTING,
//                 height: 31,
//                 width: 31,
//                 color: _selectedIndex == 0 ? Colors.blueAccent : Colors.white,
//               ),
//               label: 'School',
//             ),
//           ],
//           type: BottomNavigationBarType.fixed,
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           backgroundColor: _selectedIndex == 0 ? Colors.white : Theme.of(context).primaryColor,
//           showUnselectedLabels: false,
//           showSelectedLabels: false,
//         ),
//       ),
//     );
//   }
//   Widget buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//             ),
//             child: Text(
//               'Drawer Header',
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text(
//               'Dark Mode',
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//             trailing: ChangeThemeButtonWidget(),
//             onTap: () {},
//           ),
//           ListTile(
//             title: Text(
//               'Language',
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//             trailing: _createLanguageDropDown(),
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   _createLanguageDropDown() {
//     return DropdownButton<LanguageData>(
//       iconSize: 30,
//       hint: Text(Languages
//           .of(context)!
//           .labelSelectLanguage),
//       onChanged: (LanguageData? language) {
//         changeLanguage(context, language!.languageCode);
//       },
//       items: LanguageData.languageList()
//           .map<DropdownMenuItem<LanguageData>>(
//             (e) =>
//             DropdownMenuItem<LanguageData>(
//               value: e,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Text(e.name)
//                 ],
//               ),
//             ),
//       )
//           .toList(),
//     );
//   }
//
//   void fingerprint()=>screenLock<void>(
//     context: context,
//     correctString: '5555',
//     canCancel: false,
//     didUnlocked:() {
//       Navigator.pop(context);
//     },
//     customizedButtonChild: const Icon(
//       Icons.fingerprint,
//     ),
//     customizedButtonTap: () async {
//       await localAuth(context);
//     },
//     didOpened: () async {
//       await localAuth(context);
//     },
//   );
//
// }
//   // Widget buildDrawer(BuildContext context) {
//   //   return Drawer(
//   //     child: ListView(
//   //       padding: EdgeInsets.zero,
//   //       children: [
//   //         DrawerHeader(
//   //           decoration: BoxDecoration(
//   //             color: Theme
//   //                 .of(context)
//   //                 .primaryColor,
//   //           ),
//   //           child: Text(
//   //             'Drawer Header',
//   //             style: TextStyle(
//   //               fontSize: 20,
//   //             ),
//   //           ),
//   //         ),
//   //         ListTile(
//   //           title: Text(
//   //             'Dark Mode',
//   //             style: TextStyle(
//   //               fontSize: 20,
//   //             ),
//   //           ),
//   //           trailing: ChangeThemeButtonWidget(),
//   //           onTap: () {},
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
