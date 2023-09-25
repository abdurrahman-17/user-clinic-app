import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/login/loginNotifier.dart';
import 'package:user_clinic_token_app/core/request_response/register/registerNotifier.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_validators.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/terms%20And%20Conditions/terms_And_Conditions.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool valuesecond = false;
  bool _isObscure = true;
  bool _isObscure1 = true;
  final FocusNode name = FocusNode();
  final FocusNode mobilenumber = FocusNode();
  final FocusNode password = FocusNode();
  final FocusNode confirm_password = FocusNode();
  final FocusNode address = FocusNode();
  final FocusNode city = FocusNode();
  final FocusNode state = FocusNode();
  final FocusNode pincode = FocusNode();
  final FocusNode email = FocusNode();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _zipcode = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  late RegisterNotifier? registerNotifier;
  late LoginNotifier? loginNotifier;
  String devicetype = '';
  String FCMkey = '';

  @override
  void initState() {
    if (Platform.isAndroid) {
      devicetype = 'Android';
      print('Android');
      // Android-specific code
    } else if (Platform.isIOS) {
      devicetype = 'IOS';
      print('IOS');
      // iOS-specific code
    }
    FirebaseMessaging.instance.getToken().then((newToken) {
      FCMkey = newToken.toString();
      print("FCM Token $newToken");
    });
  }


  String? validateConfirmPassword(String? formConfirmPassword) {
    if (formConfirmPassword!.isEmpty) {
      return "Password Is Required";
    }
    if (_password.text != _confirmpassword.text) {
      confirm_password.requestFocus();
      return "Password Does Not Match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterNotifier>(
      builder: (context, provider, _) {
        return ModalProgressHUD(
            inAsyncCall: provider.isLoading, child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: _buildbody(context)
          ),
        ));
      },
    );
  }

  Widget _buildbody(BuildContext context) {
    registerNotifier =
    Provider.of<RegisterNotifier?>(context, listen: false)!;
    return Stack(
      children: [
        buildRegisterWelcomeAndWidgets(context),
      ],
    );
  }

  Widget buildRegisterWelcomeAndWidgets(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [
              0.1,
              0.4,
              0.6,
              0.9,
            ],
            colors: [
              Colors.blueAccent,
              Colors.blueAccent,
              Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              Theme
                  .of(context)
                  .scaffoldBackgroundColor,
            ]),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildRegisterWelcome(context),
            buildRegisterTiltleandWidgets(context),
          ],
        ),)
      ,
    );
  }

  Widget buildRegisterTiltleandWidgets(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme
              .of(context)
              .scaffoldBackgroundColor,
          borderRadius:
          BorderRadius.only(topLeft: Radius.circular(85))),
      child: Column(
        children: [
          buildRegisterTitle(context),
          buildTextFieldWIthValidator(context),
          buildCheckbox(context),
          buildRegisterButton(context, registerNotifier!),
          buildYouHaveAnACC(context),
        ],
      ),
    );
  }

  Widget buildTextFieldWIthValidator(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          buildFullName(context),
          buildNumber(context),
          buildEmail(context),
          buildPassword(context),
          buildConfirmPassword(context),
          buildAddress(context),
          buildCity(context),
          buildState(context),
          buildZIPcode(context),
        ],
      ),
    );
  }

  Widget buildRegisterWelcome(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(85))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AutoSizeText(
              "For a healthy life keep your friends, family, and doctor close.",
              style: TextMainHeading(context),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
          // Text(Languages.of(context)!.registerEntry1,
          //   style: TextMainHeading(context),
          // ),
          // Text(
          //   Languages.of(context)!.registerEntry2,
          //   style: TextMainHeading(context),
          // ),
          // Text(
          //   Languages.of(context)!.registerEntry3,
          //   style: TextMainHeading(context),
          //   ),
        ],
      ),
    );
  }

  Widget buildRegisterTitle(BuildContext context) {
    return Padding(
        padding:
        EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.03),
        child: Center(
          child: Text("Register Account",
              style: TextMainsubtitle(context)),
        ));
  }

  Widget buildFullName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.035,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.03),
      child: TextFormField(
        focusNode: name,
        controller: _name,
        validator: validateText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              AppImages.PROFILE,
            ),
          ),
          hintText: "Full Name",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildNumber(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.035,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.03),
      child: TextFormField(
        focusNode: mobilenumber,
        keyboardType: TextInputType.number,
        maxLength: 10,
        controller: _number,
        validator: (nums) {
          if (nums!.isEmpty) {
            mobilenumber.requestFocus();
            return "Number is Required";
          }
          else if(nums.length<10){
            mobilenumber.requestFocus();
          return "Please Enter 10 digit Valid Number";
          }
          return
          null;
        },
        decoration: InputDecoration(
          counterText: '',
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Icon(Icons.phone_outlined, size: 30, color: Colors.grey,),
          ),
          hintText: "Mobile Number",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.025,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.03),
      child: TextFormField(
        focusNode: email,
        keyboardType: TextInputType.emailAddress,
        controller: _email,
        validator: (value) {
          if (value!.isEmpty) {
            email.requestFocus();
            return "Email Is Required";
          }
          String pattern = r'\w+@\w+\.\w+';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            email.requestFocus();
            return 'Invalid Email';
          }
          return null;
        },
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
          hintText: "Email",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.025,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.03),
      child: TextFormField(
        focusNode: password,
        validator: validatePassword,
        controller: _password,
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
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
          hintText: "Password",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildConfirmPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.025,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.03),
      child: TextFormField(
        focusNode: confirm_password,
        validator: validateConfirmPassword,
        controller: _confirmpassword,
        obscureText: _isObscure1,
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
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(_isObscure1 ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure1 = !_isObscure1;
                });
              },
            ),
          ),
          hintText: "Confirm Password",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildAddress(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.025,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.03),
      child: TextFormField(
        focusNode: address,
        controller: _address,
        validator: validateAddress,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(AppImages.HOME),
          ),
          //prefixIconConstraints: BoxConstraints(minHeight: 0),
          hintText: "Address",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildCity(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.025,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.03),
      child: TextFormField(
        focusNode: city,
        controller: _city,
        validator: validateText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(AppImages.COMPASS),
          ),
          hintText: "City",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildState(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.025,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.03),
      child: TextFormField(
        focusNode: state,
        controller: _state,
        validator: validateText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(AppImages.LOCATIONPIN),
          ),
          hintText: "State",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildZIPcode(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.025,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.03),
      child: TextFormField(
        focusNode: pincode,
        controller: _zipcode,
        maxLength: 6,
        keyboardType: TextInputType.number,
        validator: validateText,
        decoration: InputDecoration(
          counterText: "",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(AppImages.ZIP),
          ),
          hintText: "Pin Code",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildCheckbox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery
            .of(context)
            .size
            .height * 0.025,
        left: MediaQuery
            .of(context)
            .size
            .width * 0.08,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Checkbox(
              activeColor: Colors.blue,
              value: valuesecond,
              onChanged: (bool? value) {
                setState(() {
                  valuesecond = value!;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: RichText(
              text: TextSpan(
                  text: "I have read the ",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.5))),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              BuildContext context) => Terms_And_Condition()));
                        },
                      text: 'Terms And Condition',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.blueAccent)),)
                  ]
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildRegisterButton(BuildContext context, RegisterNotifier notifier) {
    loginNotifier =
    Provider.of<LoginNotifier?>(context, listen: false)!;
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.08,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.03,
          bottom: MediaQuery
              .of(context)
              .size
              .height * 0.01),
      child: SizedBox(
        height: 50,
        width: 235,
        child: ElevatedButton(
            onPressed: () {
              //notifier.PatientRegister(_email.text.trim(), _password.text.trim(), _name.text.trim(), _address.text.trim(), _city.text.trim(), _state.text.trim(),_zipcode.text.trim() );
              if (_key.currentState!.validate()) {
                if (valuesecond == false) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('check terms and condition'),
                  ));
                }
                else {
                  notifier.PatientRegister(
                      _email.text.trim(),
                      _password.text.trim(),
                      _name.text.trim(),
                      _address.text.trim(),
                      _city.text.trim(),
                      _state.text.trim(),
                      _zipcode.text.trim(),
                      _number.text,
                      FCMkey,
                      devicetype);
                  // loginNotifier!.PatientLogin(_email.text.trim(), _password.text.trim(),devicetype,FCMkey);
                }
              }
              // else if (_name.text.isEmpty && _name.text.length < 5) {
              //   name.requestFocus();
              // } else if (_number.text.isEmpty && _number.text.length < 10) {
              //   mobilenumber.requestFocus();
              // } else if (_email.text.isEmpty) {
              //   email.requestFocus();
              // } else if (_password.text.isEmpty) {
              //   password.requestFocus();
              // } else if (_confirmpassword.text.isEmpty) {
              //   confirm_password.requestFocus();
              // } else if (_address.text.isEmpty) {
              //   address.requestFocus();
              // } else if (_city.text.isEmpty) {
              //   city.requestFocus();
              // } else if (_state.text.isEmpty) {
              //   state.requestFocus();
              // } else if (_zipcode.text.isEmpty) {
              //   pincode.requestFocus();
              // }
            },
            style: getButtonStyle(context),
            child: Text(
              "Register",
              style: TextButtonStyle(context),
            )),
      ),
    );
  }

  Widget buildYouHaveAnACC(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.012,
          bottom: MediaQuery
              .of(context)
              .size
              .height * 0.05),
      child: RichText(
        text: TextSpan(
            text: "You Have an Account? ",
            style: GoogleFonts.quicksand(
                textStyle: const TextStyle(color: Colors.grey, fontSize: 15)),
            children: [
              TextSpan(
                  text: "Login",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15)),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Navigator.pushNamed(context, RoutePaths.LOGIN))
            ]),
      ),
    );
  }
}
