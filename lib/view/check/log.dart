import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_validators.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';

class Logincheck extends StatefulWidget {
  const Logincheck({Key? key}) : super(key: key);

  @override
  _LogincheckState createState() => _LogincheckState();
}

class _LogincheckState extends State<Logincheck> {
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
  TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  String? validateConfirmPassword(String? formConfirmPassword) {
    if (formConfirmPassword!.isEmpty) {
      return "Password Is Required";
    }
    if (_password.text != _confirmpassword.text) {
      return "Password Does Not Match";
    }
    return null;
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0XffF3F3F3),
          body:_buildBody(context)),
    );
  }
  Widget _buildBody(BuildContext context){
    return SingleChildScrollView(
      child: Stack(
        children: [
          buildBackgroundDesignAndWidgts(context),
      Column(children: [
        buildEntry(context),
        buildbackgroundcolorAndTextfields(context),
      ]),
        ],
      ),
    );
  }
  Widget buildBackgroundDesignAndWidgts(BuildContext context) {
    return  CustomPaint(
        painter: MyPainter(),
    child: Container(
    height: MediaQuery.of(context).size.height * 0.4,
    width: double.infinity,
    ));
  }

  Widget buildbackgroundcolorAndTextfields(BuildContext context) {
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
          buildLoginButton(context),
          buildYouhaveanac(context),
        ],
      ),
    );
  }

  Widget buildEntry(BuildContext context) {
    return
        // decoration: BoxDecoration(
        //     color: Theme.of(context).primaryColor,
        //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(85))),
//        child:
    Padding(
          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.11,bottom: MediaQuery.of(context).size.height*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Languages.of(context)!.Welcomebacktoclinic,
                  style: TextMainHeading(context)),
              Text(
                Languages.of(context)!.Welcomebacktoclinic2,
                style: TextMainHeading(context),
              )
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
          child: Text(
            Languages.of(context)!.login,
            style: TextMainsubtitle(context),
          )),
    );
  }

  Widget buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.13,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        validator: validateEmail,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(AppImages.SMS),
          ),
          hintText: Languages.of(context)!.email,
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
            hintText: Languages.of(context)!.password,
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
          top: MediaQuery.of(context).size.height * 0.01,
          right: MediaQuery.of(context).size.width * 0.04),
      child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.FORGOT);
              },
              child: Text(
                Languages.of(context)!.forgotPassword,
                style: GoogleFonts.roboto(
                    textStyle:
                    const TextStyle(color: Colors.grey, fontSize: 14)),
              ))),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.08,
            bottom: MediaQuery.of(context).size.height * 0.01),
        child: SizedBox(
            width: 235,
            height: 50,
            child: ElevatedButton(
              style: getButtonStyle(context),
              onPressed: () =>
                  Navigator.pushNamed(context, RoutePaths.HomeScreen),
              child: Text(
                Languages.of(context)!.login,
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
              text: Languages.of(context)!.Donthaveanaccount,
              style: TextForgetStyle(context),
              children: [
                TextSpan(
                    text: Languages.of(context)!.register,
                    style: RichtextStyle(context),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          Navigator.pushNamed(context, RoutePaths.SIGNUP)),
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
