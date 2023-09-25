import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/request_response/change_new_password/Change_new_pass_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';

class ChangeNewPassword extends StatefulWidget {
  const ChangeNewPassword({Key? key}) : super(key: key);

  @override
  _ChangeNewPasswordState createState() => _ChangeNewPasswordState();
}

class _ChangeNewPasswordState extends State<ChangeNewPassword> {
  bool _isObscure = true;
  bool _isObscure1 = true;

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _password = TextEditingController();
  TextEditingController _cfmpassword = TextEditingController();
  Change_new_Pass_Notifier? change_new_pass;
  SharedPreferences? forgot;
  String email="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var me = MySharedPreferences.user_clinic().getEmail("email");

    // MySharedPreferences.instance.getEmail("email").then((value) => setState((){
    //   email=value;
    // }));
    email=Get.arguments[0]['email'];
    print(email);
    // getemail();
  }
  // @override
  // void getemail()async{
  //   forgot=await SharedPreferences.getInstance();
  //   setState(() {
  //     email=forgot?.getString('forgetemail') ?? "";
  //     print(email);
  //   });
  //
  // }

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
    if (_password.text != _cfmpassword.text) {
      return "Password Does Not Match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if(!kReleaseMode){}
    return Consumer<Change_new_Pass_Notifier>(
      builder: (context,provider,_) {
       return ModalProgressHUD(inAsyncCall:provider.isLoading , child:SafeArea(
         child: Scaffold(
           backgroundColor:  Color(0xffF3F3F3),
           body: _buildbody(context),
         ),
       ), );
      }
    );
  }
  Widget _buildbody(BuildContext context){
    change_new_pass=Provider.of<Change_new_Pass_Notifier?>(context,listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBackButton(context),
          buildChangeNewPassword(context),
          buildChangepassPara(context),
          buildTextFieldWithForm(context),
          buildConfirmButton(context,change_new_pass!),
        ],
      ),
    );
  }
  Widget buildTextFieldWithForm(BuildContext context){
          return Form(
        key: _key,
        child: Column(
        children: [
            buildPassword(context),
            buildConfirmPassword(context),
        ],
        ),
        );
}

  Widget buildBackButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
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

  Widget buildChangeNewPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2,
          left: MediaQuery.of(context).size.width * 0.04),
      child: Text("Change new Password",
        style:TextHeadingStyle(context)
      ),
    );
  }

  Widget buildChangepassPara(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.05),
      child: Text("Your new password must be different from previous used passwords.",
        style: TextParaStyle(context)
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
            hintText: "Password",
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
        controller: _cfmpassword,
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
            hintText:  "Confirm Password",
            hintStyle: TextFieldStyle(context),
        )
      ),
    );
  }

  Widget buildConfirmButton(BuildContext context,Change_new_Pass_Notifier notifier) {
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
                var me = MySharedPreferences.user_clinic().getEmail("email");
                print("saadh on email" + me.toString());

                 if (_key.currentState!.validate()) {
                   notifier.change_pass(email, _password.text.trim(), _cfmpassword.text.trim());
              //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //       content: Text('Password Changed'),
              //     ));
              //
              //     //Navigator.pushNamed(context, RoutePaths.LOGIN);
                 }
                //notifier.change_pass(email, _password.text.trim(), _cfmpassword.text.trim());
               },
              style: getButtonStyle(context),
              child: AutoSizeText("Change Password",
                maxLines: 1,textAlign: TextAlign.center,
                style: TextButtonStyle(context)
              )),
        ),
      ),
    );
  }
}
