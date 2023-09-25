import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/password_change_setting/password_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';

class Change_new_Password extends StatefulWidget {
  const Change_new_Password({Key? key}) : super(key: key);

  @override
  _Change_new_PasswordState createState() => _Change_new_PasswordState();
}

class _Change_new_PasswordState extends State<Change_new_Password> {

  bool _isObscureold = true;
  bool _isObscure = true;
  bool _isObscure1 = true;
  Password_setting_Notifier? Password_setting;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _oldpassword = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
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

  String? validateConfirmPassword(String? formConfirmPassword) {
    if (formConfirmPassword!.isEmpty) {
      return "Password Is Required";
    }
    if (_password.text != _confirmpassword.text) {
      return "Password Does Not Match";
    }
    return null;
  }
  String id='';
  @override
  void initState() {

    MySharedPreferences.instance.getid('id').then((value){
      id=value.toString();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Password_setting_Notifier>(
      builder: (context,provider,_){
        return ModalProgressHUD(inAsyncCall:provider.isLoading , child:
        SafeArea(
          child: Scaffold(
            backgroundColor:  Color(0xffF3F3F3),
            body:_buildBody(context),
          ),
        ));
      },
    );
  }
  Widget _buildBody(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBackButton(context),
          buildChangeNewPassword(context),
          //buildChangepassPara(context),
          buildTextFieldWithForm(context),
          buildConfirmButton(context),
        ],
      ),
    );
  }
  Widget buildTextFieldWithForm(BuildContext context){
    return Form(
      key: _key,
      child: Column(
        children: [
          buildOldPassword(context),
          buildPassword(context),
          buildConfirmPassword(context),
        ],
      ),
    );
  }

  Widget buildBackButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 20,
          left: 15),
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

  Widget buildChangeNewPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2,
          left: MediaQuery.of(context).size.width * 0.04),
      child: Text('Change Password',
          style:TextHeadingStyle(context)
      ),
    );
  }

  // Widget buildChangepassPara(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //         top: MediaQuery.of(context).size.height * 0.01,
  //         left: MediaQuery.of(context).size.width * 0.05),
  //     child: Text(
  //         Languages.of(context)!.changenewpasswordPara,
  //         style: TextParaStyle(context)
  //     ),
  //   );
  // }

  Widget buildOldPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        validator: validatePassword,
        controller: _oldpassword,
        obscureText: _isObscureold,
        decoration: InputDecoration(
            fillColor:Colors.white,
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
                Icon(_isObscureold ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscureold = !_isObscureold;
                  });
                },
              ),
            ),
            hintText: 'Old Password',hintMaxLines: 1,
            hintStyle: TextFieldStyle(context),),
      ),
    );
  }
  Widget buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.03,
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
            hintText:"New Password",
            hintStyle: TextFieldStyle(context)),
      ),
    );
  }

  Widget buildConfirmPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
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
                icon:
                Icon(_isObscure1 ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure1 = !_isObscure1;
                  });
                },
              ),
            ),
            hintText: "Confirm New Password",
            hintStyle: TextFieldStyle(context),
          )
      ),
    );
  }

  Widget buildConfirmButton(BuildContext context) {
    Password_setting=Provider.of<Password_setting_Notifier?>(context,listen: false);
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
                  Password_setting!.password_change_setting(id, _oldpassword.text, _password.text, _confirmpassword.text);
                }
              },
              style: getButtonStyle(context),
              child: AutoSizeText(
                  'Change Password',
                  maxLines: 1,textAlign: TextAlign.center,
                  style: TextButtonStyle(context)
              )),
        ),
      ),
    );
  }
}
