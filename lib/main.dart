import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/Router.dart';
import 'package:user_clinic_token_app/core/request_response/Add%20Appointment/add_Appointment_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/Get_report_By_Id/Get_Report_Byid_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/Notification%20API/notification_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/Otp_verify/Otp_verify_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/Pharmacy/Pharmacy_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/Upcoming%20Appointment/upp_ComingApp_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/about%20Us/about_Us_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/add_family_member/add_family_member_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/carousel/DoctorList_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/change_new_password/Change_new_pass_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/edit%20Family%20Member/edit_Family_Member_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/email_change/email_change_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/email_otp_request/Email_Otp_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/family%20Member%20Delete/family_Member_Delete_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/filter%20Using%20Name/filter_Using_name_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/gender&age/age&gender_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/get%20Appointment%20Filter/get_Appointment_Filter_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/get%20Doctor%20Schedule/get_Doctor_schedule_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/get%20Token%20Response/get_Token_Schedule_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/get%20report%20filter/get_Report_filter_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/get_report/Get_Report_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/list_family_member/list_family_member_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/login/loginNotifier.dart';
import 'package:user_clinic_token_app/core/request_response/my%20Doctor/my_Doctor_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/no%20Image/no_Image_Response_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/no_of_appointment/No_of_appointment_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/notification_Count/notification_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/notification_on_off/notification_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/password_change_setting/password_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/past%20Appointment/past_App_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/pin_OTP_Verification/pin_OTP_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/pin_OTP_verify/pin_OTP_verify_and_set_new_pin_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/privacyPolicy/privacyPolicy_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/profile/dr_profile_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/profile/profile_notifer.dart';
import 'package:user_clinic_token_app/core/request_response/register/registerNotifier.dart';
import 'package:user_clinic_token_app/core/request_response/terms%20And%20Conditions/termsAndConditions_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/update_appointment/update_Appointment_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/update_patient_profile/updatePatientProfileNotifier.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/localization/locale_constant.dart';
import 'package:user_clinic_token_app/utils/provider/theme_provider.dart';
import 'package:user_clinic_token_app/view/onboard_screens/SignedUp_Screen.dart';
import 'package:user_clinic_token_app/view/password_Screen/password_Screen.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
//   print(message.data.toString()+'irfan');
//   flutterLocalNotificationsPlugin.show(
//       message.data.hashCode,
//       message.data['title'],
//       message.data['body'],
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: 'This channel is used for important notifications',
//         ),
//       ));
// }
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   importance: Importance.high,
// );
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();


Future<void> backgroundhandler(RemoteMessage message)async{
  print(message.data.toString());
  print(message.notification!.title);
}
void main() {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    setUpRealLocator();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(backgroundhandler);
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //     AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);
    runApp(MyApp());
    // RemoteMessage? initialMessage =
    // await FirebaseMessaging.instance.getInitialMessage();
    // if (initialMessage != null) {
    //   // App received a notification when it was killed
    // }
  }
  );
}

class MyApp extends StatefulWidget{

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }
}
class _MyAppState extends State<MyApp> {
  String apikey = '';
  late Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  getapi() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      apikey = prefs.getString("token").toString();
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      // var initialzationSettingsAndroid =
      // AndroidInitializationSettings('@mipmap/ic_launcher');
      // var initializationSettings =
      // InitializationSettings(android: initialzationSettingsAndroid);
      //
      // flutterLocalNotificationsPlugin.initialize(initializationSettings);
      // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   RemoteNotification? notification = message.notification;
      //   AndroidNotification? android = message.notification?.android;
      //   if (notification != null && android != null) {
      //     flutterLocalNotificationsPlugin.show(
      //         notification.hashCode,
      //         notification.title,
      //         notification.body,
      //         NotificationDetails(
      //           android: AndroidNotificationDetails(
      //             channel.id,
      //             channel.name,
      //             channelDescription: 'This channel is used for important notifications',
      //             icon: android.smallIcon,
      //           ),
      //         ));
      //   }
      // });
      getapi();
    }

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      final GlobalKey<NavigatorState> navigatorKey = GlobalKey<
          NavigatorState>();

      //SharedPref _prefs = locator.get<SharedPref>();
      return OverlaySupport.global(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LoginNotifier()),
            ChangeNotifierProvider(create: (_) => RegisterNotifier()),
            // ChangeNotifierProvider(create: (_) => ThemeNotifier()),
            ChangeNotifierProvider(create: (_) => EmailotpNotifier()),
            ChangeNotifierProvider(create: (_) => OTP_Notifier()),
            ChangeNotifierProvider(create: (_) => Change_new_Pass_Notifier()),
            ChangeNotifierProvider(create: (_) => age_number_Notifier()),
            ChangeNotifierProvider(create: (_) => Doctor()),
            ChangeNotifierProvider(create: (_) => Profile_Notifier()),
            ChangeNotifierProvider(create: (_) => NotificationNotifier()),
            ChangeNotifierProvider(create: (_) => Password_setting_Notifier()),
            ChangeNotifierProvider(create: (_) => Email_change_Notifier()),
            ChangeNotifierProvider(create: (_) => Add_Family_Member_Notifier()),
            ChangeNotifierProvider(create: (_) => DrProfileNotifier()),
            ChangeNotifierProvider(create: (_) => No_of_appointment()),
            ChangeNotifierProvider(create: (_) => List_family_Member()),
            ChangeNotifierProvider(create: (_) => Pharmacy_Notifier()),
            ChangeNotifierProvider(create: (_) => GEt_Report_Notifier()),
            ChangeNotifierProvider(create: (_) => Get_Report_Id_Notifier()),
            ChangeNotifierProvider(create: (_) => GEt_Report_Filter_Notifier()),
            ChangeNotifierProvider(create: (_) => Get_Appointment_Filter_Notifier()),
            ChangeNotifierProvider(create: (_) => UpdatePatientProfileNotifier()),
            ChangeNotifierProvider(create: (_) => get_Doctor_Schedule_Notifier()),
            ChangeNotifierProvider(create: (_) => add_Appointment_Notifier()),
            ChangeNotifierProvider(create: (_) => get_Doctor_Token_Schedule_Notifier()),
            ChangeNotifierProvider(create: (_) => TermsAndCondition_Notifier()),
            ChangeNotifierProvider(create: (_) => Privacy_Policy_Notifier()),
            ChangeNotifierProvider(create: (_) => Upcoming_App_Notifier()),
            ChangeNotifierProvider(create: (_) => Past_App_Notifier()),
            ChangeNotifierProvider(create: (_) => About_Us_Notifier()),
            ChangeNotifierProvider(create: (_) => Family_Member_Delete_Notifier()),
            ChangeNotifierProvider(create: (_) => UpdateFamilyProfileNotifier()),
            ChangeNotifierProvider(create: (_) => Get_Filter_Name_Notifier()),
            ChangeNotifierProvider(create: (_) => No_Image()),
            ChangeNotifierProvider(create: (_) => pin_emila_send_OTP_Notfier()),
            ChangeNotifierProvider(create: (_) => pin_OTP_Notifier()),
            ChangeNotifierProvider(create: (_) => My_Doctor_Notifier()),
            ChangeNotifierProvider(create: (_) => ALL_Notification_Notifier()),
            ChangeNotifierProvider(create: (_) => Notification_Count_Notifier()),
            ChangeNotifierProvider(create: (_) => add_Appointment_Notifier()),
            ChangeNotifierProvider(create: (_) => update_Appointment_Notifier()),
          ],
          child: GetMaterialApp(
                  // STEP 3. Add navigator key from Catcher. It will be used to navigate user to report page or to show dialog.
                  //   navigatorKey: Catcher.navigatorKey,
                  //theme: MyAppTheme.myThemes(notifier.isDark, context),
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: MyRouter.generateRoute,
                  home: apikey == 'null' ? SignedUpScreen() : password_Screen(),


          ),

        ),

      );


      /*ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      builder: (context, child) {
        return Consumer<ThemeNotifier>(builder: (context , notifier, _){
           return MaterialApp(
          //   builder:(context,navigator){
          //     var lang=Localizations.localeOf(context).languageCode;
          //
          //     return Theme(data:ThemeData(textTheme: Theme.of(context).textTheme.apply(
          //     )), child: navigator!);
          //   },
            debugShowCheckedModeBanner: false,
            locale: _locale,
            supportedLocales: [
              Locale('en', ''),
              Locale('ta', ''),
              Locale('hi', '')
            ],
            localizationsDelegates: [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode &&
                    supportedLocale.countryCode == locale?.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            theme: MyAppTheme.myThemes(notifier.isDark, context),
            // routes: {
            //   RoutePaths.HOME:(context)=>const SignUpPage(),
            //   RoutePaths.FORGOT:(context)=>const ForgetScreen(),
            //   RoutePaths.CHANGENEWPASSWORD:(context)=>const ChangeNewPassword(),
            //   RoutePaths.LOGIN:(context)=>const Login(),
            //   RoutePaths.SIGNUP:(context)=>const SignUpPage(),
            //   RoutePaths.OTPVERIFICATION:(context)=>const OtpVerification(),
            //   RoutePaths.BOTTOMNAVIGATION:(context)=>const NavigationScreen(),
            //   RoutePaths.FAMILYMEMEBER: (context) => const FamilyMember(),
            //   RoutePaths.APPOINTMENTSCREEN: (context) => const TokenAppointment(),
            //   RoutePaths.PROFILE:(context)=>DrProfile(),
            //   RoutePaths.Appointment:(context)=>Appointment(),
            //   RoutePaths.Appointment_Done:(context)=>Appointment_done(),
            //   RoutePaths.Token:(context)=>TokenAppointment(),
            //   RoutePaths.Token_Done:(context)=>token_done_page(),
            //   RoutePaths.Doctor_Profile_token:(context)=>DrProfile_token(),
            //   RoutePaths.Pin_Set:(context)=>Pin_Set_Up(),
            // },
             //
              onGenerateRoute: MyRouter.generateRoute,
            home: Login()
             //SignedUpScreen(),

          );
        });
      },
    );*/
    }
  }

