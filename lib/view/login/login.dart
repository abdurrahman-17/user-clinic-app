import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/login/loginNotifier.dart';
import 'package:user_clinic_token_app/utils/common/app_font.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_validators.dart';
import 'dart:io' show Platform;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Future<void> localAuth(BuildContext context) async {

    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticateWithBiometrics(
      localizedReason: 'Please authenticate',
    );
    if (didAuthenticate) {
      Navigator.pushNamed(context, RoutePaths.BOTTOMNAVIGATION);
    }
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _isObscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late LoginNotifier? loginNotifier;
  final _keyScaffold = GlobalKey<ScaffoldState>();
  String devicetype='';
  String FCMkey='';

  @override
  void initState() {
    if (Platform.isAndroid) {
      devicetype='Android';
      print('Android');
      // Android-specific code
    } else if (Platform.isIOS) {
      devicetype='IOS';
      print('IOS');
      // iOS-specific code
    }
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getToken().then((newToken) {
      FCMkey=newToken.toString();
      print("FCM Token $newToken");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog();
          });
    });
  }

  // Future<void> initializePreference() async {
  //   genderage = await SharedPreferences.getInstance();
  //   genderage?.setString('mail', emailController.text);
  // }
  // @override
  // void initState() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   print('irfan');
  //   print(prefs.get('token'));
  //   print('irfan');
  //   // TODO: implement initState
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {


    if (!kReleaseMode) {}
    return Consumer<LoginNotifier>(
        builder: (context, provider, _) {
          return ModalProgressHUD(
            inAsyncCall: provider.isLoading,
            child: SafeArea(
              child: Scaffold(
                  key: _keyScaffold,
                  backgroundColor: Color(0XffF3F3F3),
                  body: _buildBody(context)),
            ),
          );
        }
    );
  }
  Widget _buildBody(BuildContext context){
    loginNotifier =
        Provider.of<LoginNotifier?>(context, listen: false)!;
    return SingleChildScrollView(
      child: Stack(
        children: [
          buildBackgroundDesignAndWidgets(context),
          Column(children: [
            buildEntry(context),
            buildbackgroundcolorAndTextfields(context, loginNotifier!),
          ]),
        ],
      ),
    );
  }
  Widget buildBackgroundDesignAndWidgets(BuildContext context) {
    return  CustomPaint(
        painter: MyPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
        ));
  }

  Widget buildbackgroundcolorAndTextfields(BuildContext context, LoginNotifier notifier) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          buildLogintitle(context),
          Form(
            key: _key,
            child: Column(
              children: [
                buildEmail(context),
                buildPassword(context),
              ],
            ),
          ),
          buildForgotPass(context),
          buildLoginButton(context,loginNotifier!),
          buildYouhaveanac(context),
        ],
      ),
    );
  }

  Widget buildEntry(BuildContext context) {
    return

      Padding(
        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.11,bottom: MediaQuery.of(context).size.height*0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome',
          style: TextStyle(fontWeight: AppFont.fontWeightMedium,fontSize: 35,color: Colors.white)),
            Text('Login',
                style: TextMainHeading(context)),
            // Text(Languages.of(context)!.Welcomebacktoclinic,
            //     style: TextMainHeading(context)),
            // Text(
            //   Languages.of(context)!.Welcomebacktoclinic2,
            //   style: TextMainHeading(context),
            // )
          ],
          //     ),
          //   ),
        ),
      );
  }

  Widget buildLogintitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Center(
          child: Text('Login',
            // Languages.of(context)!.login,
            style: TextMainsubtitle(context),
          )),
    );
  }

  Widget buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.08,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: emailController,
        validator: validateEmail,
        decoration: InputDecoration(
          fillColor:Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(AppImages.SMS),
          ),
          hintText:'Email',
          //Languages.of(context)!.email,

          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: passwordController,
        validator: validatePassword,
        obscureText: _isObscure,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(AppImages.KEYSQUARE),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: IconButton(
                icon:
                Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
            hintText:'Password',

            //Languages.of(context)!.password,
            hintStyle: GoogleFonts.quicksand(
                textStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ))),
      ),
    );
  }

  Widget buildForgotPass(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          right: MediaQuery.of(context).size.width * 0.04),
      child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.FORGOT);
              },
              child: Text('Forgot Password?',
                // Languages.of(context)!.forgotPassword,
                style: GoogleFonts.roboto(
                    textStyle:
                    const TextStyle(color: Colors.grey, fontSize: 14)),
              ))),
    );
  }

  Widget buildLoginButton(BuildContext context,LoginNotifier notifier) {
    return Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.08,
            bottom: MediaQuery.of(context).size.height * 0.01),
        child: SizedBox(
            width: 235,
            height: 50,
            child: ElevatedButton(
              style: getButtonStyle(context),
              onPressed: () {
                if (_key.currentState!.validate() ) {
                  notifier.PatientLogin(emailController.text.trim(),
                      passwordController.text.trim(),devicetype,FCMkey);
                }
                //var getemail=emailController.text;
                //print(getemail);
                //MySharedPreferences.instance.setEmail("emails", getemail);
                },
                  //Navigator.pushNamed(context, RoutePaths.HomeScreen),
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> OnboardingScreen())),
              child: Text('Login',
                // Languages.of(context)!.login,
                style: TextButtonStyle(context),
              ),
            )));
  }

  Widget buildYouhaveanac(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.012,
            bottom: MediaQuery.of(context).size.height * 0.1),
        child: AutoSizeText.rich(
          TextSpan(
              text: 'Don\'t have an Account?',
              // Languages.of(context)!.Donthaveanaccount,
              style: TextForgetStyle(context),
              children: [
                TextSpan(
                    text:' Register',
                    //Languages.of(context)!.register,
                    style: RichtextStyle(context),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          Navigator.pushNamed(context, RoutePaths.HOME)),
              ]),
          maxLines: 2,
          textAlign: TextAlign.center,
        ));
  }
}
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();


    // Path number 1


    paint.color = Color(0xff4889FD);
    path = Path();
    path.lineTo(size.width, -0.17);
    path.cubicTo(size.width, -0.17, 0, -0.17, 0, -0.17);
    path.cubicTo(0, -0.17, 0, size.height * 0.63, 0, size.height * 0.63);
    path.cubicTo(0, size.height * 0.63, 0, size.height * 0.63, 0, size.height * 0.63);
    path.cubicTo(0, size.height * 0.63, 0, size.height * 0.83, 0, size.height * 0.83);
    path.cubicTo(0, size.height * 0.73, size.width * 0.08, size.height * 0.64, size.width * 0.18, size.height * 0.63);
    path.cubicTo(size.width * 0.18, size.height * 0.63, size.width * 0.81, size.height * 0.63, size.width * 0.81, size.height * 0.63);
    path.cubicTo(size.width * 0.92, size.height * 0.63, size.width, size.height * 0.55, size.width, size.height * 0.44);
    path.cubicTo(size.width, size.height * 0.44, size.width, -0.17, size.width, -0.17);
    path.cubicTo(size.width, -0.17, size.width, -0.17, size.width, -0.17);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
// import 'package:user_clinic_token_app/utils/common/app_images.dart';
// import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
// import 'package:user_clinic_token_app/utils/common/app_validators.dart';
// import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   Future<void> localAuth(BuildContext context) async {
//     final localAuth = LocalAuthentication();
//     final didAuthenticate = await localAuth.authenticateWithBiometrics(
//       localizedReason: 'Please authenticate',
//     );
//     if (didAuthenticate) {
//       Navigator.pushNamed(context, RoutePaths.BOTTOMNAVIGATION);
//     }
//   }
//
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   TextEditingController _password = TextEditingController();
//   final TextEditingController _confirmpassword = TextEditingController();
//
//   String? validateConfirmPassword(String? formConfirmPassword) {
//     if (formConfirmPassword!.isEmpty) {
//       return "Password Is Required";
//     }
//     if (_password.text != _confirmpassword.text) {
//       return "Password Does Not Match";
//     }
//     return null;
//   }
//   bool _isObscure = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body:_buildBody(context)),
//     );
//   }
//   Widget _buildBody(BuildContext context){
//     return Stack(
//       children: [
//         buildBackgroundDesignAndWidgts(context)
//       ],
//     );
//   }
//   Widget buildBackgroundDesignAndWidgts(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.0),
//             spreadRadius: 0,
//             blurRadius: 0,
//           ),
//         ],
//         gradient: LinearGradient(
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             stops: [
//               0.1,
//               0.4,
//               0.6,
//               0.9,
//             ],
//             colors: [
//               Theme.of(context).primaryColor,
//               Theme.of(context).primaryColor,
//               Theme.of(context).scaffoldBackgroundColor,
//               Theme.of(context).scaffoldBackgroundColor,
//             ]),
//       ),
//       child: SingleChildScrollView(
//         physics: ScrollPhysics(),
//         child: Column(
//           children: [
//             Column(children: [
//               buildEntry(context),
//               buildbackgroundcolorAndTextfields(context),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildbackgroundcolorAndTextfields(BuildContext context) {
//     return Container(
//       // height: MediaQuery.of(context).size.height * 0.80,
//       decoration: BoxDecoration(
//           color: Theme.of(context).scaffoldBackgroundColor,
//           borderRadius: const BorderRadius.only(topLeft: Radius.circular(85))),
//       child: SingleChildScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         child: Column(
//           children: [
//             buildLogintitle(context),
//             Form(
//               key: _key,
//               child: Column(
//                 children: [
//                   buildEmail(context),
//                   buildPassword(context),
//                 ],
//               ),
//             ),
//             buildForgotPass(context),
//             buildLoginButton(context),
//             buildYouhaveanac(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildEntry(BuildContext context) {
//     return Container(
//       // height: MediaQuery.of(context).size.height * 0.25,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Theme.of(context).primaryColor,
//           borderRadius: BorderRadius.only(bottomRight: Radius.circular(85))),
//       child: Padding(
//         padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1,bottom: MediaQuery.of(context).size.height*0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(Languages.of(context)!.Welcomebacktoclinic,
//                 style: TextMainHeading(context)),
//             Text(
//               Languages.of(context)!.Welcomebacktoclinic2,
//               style: TextMainHeading(context),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildLogintitle(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.only(
//           top: MediaQuery.of(context).size.height * 0.03,
//         ),
//         child: Center(
//             child: Text(
//           Languages.of(context)!.login,
//           style: TextMainsubtitle(context),
//         )));
//   }
//
//   Widget buildEmail(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//           top: MediaQuery.of(context).size.height * 0.13,
//           left: MediaQuery.of(context).size.width * 0.03,
//           right: MediaQuery.of(context).size.width * 0.03),
//       child: TextFormField(
//         validator: validateEmail,
//         decoration: InputDecoration(
//           fillColor: Colors.white,
//           filled: true,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(18),
//             borderSide: BorderSide.none,
//           ),
//           prefixIcon: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Image.asset(AppImages.SMS),
//           ),
//           hintText: Languages.of(context)!.email,
//           hintStyle: TextFieldStyle(context),
//         ),
//       ),
//     );
//   }
//
//   Widget buildPassword(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//           top: MediaQuery.of(context).size.height * 0.025,
//           left: MediaQuery.of(context).size.width * 0.03,
//           right: MediaQuery.of(context).size.width * 0.03),
//       child: TextFormField(
//         validator: validatePassword,
//         obscureText: _isObscure,
//         decoration: InputDecoration(
//             fillColor: Colors.white,
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide: BorderSide.none,
//             ),
//             prefixIcon: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Image.asset(AppImages.KEYSQUARE),
//             ),
//             suffixIcon: Padding(
//               padding: const EdgeInsets.only(
//                 right: 10,
//               ),
//               child: IconButton(
//                 icon:
//                     Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
//                 onPressed: () {
//                   setState(() {
//                     _isObscure = !_isObscure;
//                   });
//                 },
//               ),
//             ),
//             hintText: Languages.of(context)!.password,
//             hintStyle: GoogleFonts.quicksand(
//                 textStyle: const TextStyle(
//               color: Colors.grey,
//               fontSize: 20,
//             ))),
//       ),
//     );
//   }
//
//   Widget buildForgotPass(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//           top: MediaQuery.of(context).size.height * 0.01,
//           right: MediaQuery.of(context).size.width * 0.04),
//       child: Align(
//           alignment: Alignment.topRight,
//           child: GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, RoutePaths.FORGOT);
//               },
//               child: Text(
//                 Languages.of(context)!.forgotPassword,
//                 style: GoogleFonts.roboto(
//                     textStyle:
//                         const TextStyle(color: Colors.grey, fontSize: 14)),
//               ))),
//     );
//   }
//
//   Widget buildLoginButton(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.only(
//             top: MediaQuery.of(context).size.height * 0.08,
//             bottom: MediaQuery.of(context).size.height * 0.01),
//         child: SizedBox(
//             width: 235,
//             height: 50,
//             child: ElevatedButton(
//               style: getButtonStyle(context),
//               onPressed: () =>
//                   Navigator.pushNamed(context, RoutePaths.HomeScreen),
//               child: Text(
//                 Languages.of(context)!.login,
//                 style: TextButtonStyle(context),
//               ),
//             )));
//   }
//
//   Widget buildYouhaveanac(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.only(
//             top: MediaQuery.of(context).size.height * 0.012,
//             bottom: MediaQuery.of(context).size.height * 0.1),
//         child: AutoSizeText.rich(
//           TextSpan(
//               text: Languages.of(context)!.Donthaveanaccount,
//               style: TextForgetStyle(context),
//               children: [
//                 TextSpan(
//                     text: Languages.of(context)!.register,
//                     style: RichtextStyle(context),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () =>
//                           Navigator.pushNamed(context, RoutePaths.SIGNUP)),
//               ]),
//           maxLines: 2,
//           textAlign: TextAlign.center,
//         ));
//   }
// }
