import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';

class Pin_Set_Up extends StatefulWidget {
  const Pin_Set_Up({Key? key}) : super(key: key);

  @override
  _Pin_Set_UpState createState() => _Pin_Set_UpState();
}

class _Pin_Set_UpState extends State<Pin_Set_Up> {
  bool _isObscure = true;
  bool _isObscure1 = true;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _pin = TextEditingController();
  TextEditingController _confirmpin = TextEditingController();

  String? validatePassword(String? formPassword) {
    if (formPassword!.isEmpty) return "Pin Is Required";


    if (formPassword.length<4) {
      return 'Please Enter 4 Digits';
    }
  }

  String? validateConfirmPassword(String? formConfirmPassword) {
    if (formConfirmPassword!.isEmpty) {
      return "Pin is Required";
    }
    if (_pin.text != _confirmpin.text) {
      return "Pin Does Not Match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBackButton(context),
            buildSetYourPin(context),
            buildPinPara(context),
            buildTextfieldWithForm(context),
            buildConfirmButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildBackButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.04),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.blueAccent, width: 2.0),
          ),
          width: 35,
          height: 35,
          child:  Icon(
            CupertinoIcons.back,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  Widget buildSetYourPin(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2,
          left: MediaQuery.of(context).size.width * 0.04),
      child: Text(
          Languages.of(context)!.pin_Heading,
          style:TextHeadingStyle(context)
      ),
    );
  }

  Widget buildPinPara(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.05),
      child: Text(
          Languages.of(context)!.pin_para,
          style: TextParaStyle(context)
      ),
    );
  }

  Widget buildTextfieldWithForm(BuildContext context){
    return Form(
      key: _key,
      child: Column(
        children: [
          buildPin(context),
          buildConfirmPin(context),
        ],
      ),
    );
  }

  Widget buildPin(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        maxLength: 4,
        validator: validatePassword,
        controller: _pin,
        obscureText: _isObscure,
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
            hintText: Languages.of(context)!.pin,
            hintStyle: TextFieldStyle(context)),
      ),
    );
  }

  Widget buildConfirmPin(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
          maxLength: 4,
          validator: validateConfirmPassword,
          controller: _confirmpin,
          obscureText: _isObscure1,
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
              child: Image.asset(AppImages.KEYSQUARE),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon:
                Icon(_isObscure1 ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure1 = !_isObscure1;
                  });
                },
              ),
            ),
            hintText: Languages.of(context)!.confirm_pin,
            hintStyle: TextFieldStyle(context),
          )
      ),
    );
  }

  Widget buildConfirmButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
        ),
        child: SizedBox(
          height: 50,
          width: 234,
          child: ElevatedButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content: Text('Password Changed'),
                  // ));
                  Navigator.pushNamed(context, RoutePaths.BOTTOMNAVIGATION);
                }
              },
              style: getButtonStyle(context),
              child: AutoSizeText(
                  Languages.of(context)!.Set_Pin_Button,
                  maxLines: 1,textAlign: TextAlign.center,
                  style: TextButtonStyle(context)
              )),
        ),
      ),
    );
  }
}
