import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/common/app_validators.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
import 'package:user_clinic_token_app/view/change_new_Email/Change_email_confirm.dart';



class Change_email_setting extends StatefulWidget {
  const Change_email_setting({Key? key}) : super(key: key);

  @override
  State<Change_email_setting> createState() => _Change_email_settingState();
}

class _Change_email_settingState extends State<Change_email_setting> {
  @override
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _password = TextEditingController();
  bool _isObscure = true;
  String? validatePassword(String? formPassword) {
    if (formPassword!.isEmpty) return "Password Is Required";

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword)) {
      return '''
    Password must be at least 8 character
    include an uppercase letter, number and symbol.
    ''';
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF3F3F3),
        body: _buildBody(context),
      ),
    );
  }
  Widget _buildBody(BuildContext context){
    return SingleChildScrollView(
      child: Column(

        children: [
          backButton(context),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01,
                vertical: MediaQuery.of(context).size.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                titleText(context),
                //descriptionText(context),
                Form(
                    key: _key,
                    child: buildPassword(context)),
                buttonRequestOTP(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget backButton(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0,left: 15,right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff4889FD), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(left:6),
                child: Icon(Icons.arrow_back_ios,size: 15,color: Color(0xff4889FD)),
              ),
            ),
          ),
          Text('Change Email',style: TextStyle(color: Color(0xff4889FD,),fontWeight: FontWeight.w700,fontSize: 24),),
          SizedBox(width: 15,)
        ],
      ),
    );
  }

  Widget titleText(context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20,left: 15),
      child: Text(
          'Enter Password',
          style: TextHeadingStyle(context)
      ),
    );
  }

  // Widget descriptionText(context) {
  //   return Padding(
  //     padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
  //     child: Text(
  //         Languages.of(context)!.forgotpara,
  //         style:TextParaStyle(context)
  //     ),
  //   );
  // }
  Widget buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
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
                icon:
                Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
            hintText: 'password',
            hintStyle: TextFieldStyle(context)),
      ),
    );
  }
  // Widget emailTextField(context) {
  //   return Padding(
  //     padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
  //     child: Form(
  //       key: _key,
  //       child: TextFormField(
  //         validator: validateEmail,
  //         decoration: InputDecoration(
  //             fillColor: Colors.white,
  //             filled: true,
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(18),
  //               borderSide: BorderSide.none,
  //             ),
  //             prefixIcon: Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 10,
  //               ),
  //               child: Image.asset(AppImages.SMS),
  //             ),
  //             hintText: Languages.of(context)!.email,
  //             hintStyle: TextFieldStyle(context)
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buttonRequestOTP(context) {
    return Padding(
      padding:EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.20),
      child: Center(
        child: SizedBox(
          height: 50,
          width: 234,
          child: ElevatedButton(
            style:getButtonStyle(context),
            child: AutoSizeText(
              'Continue',
              style: TextButtonStyle(context),maxLines: 1,
              textAlign: TextAlign.center,       ),
            onPressed: () {
                if(_key.currentState!.validate()) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Change_new_email(selected: _password.text)));
                }
            },
          ),
        ),
      ),
    );
  }
}
