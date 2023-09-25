import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_clinic_token_app/core/request_response/mobile%20Update/mobileUpdate_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/common/app_validators.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';

class Change_new_number extends StatefulWidget {
  final password;
   Change_new_number({Key? key,required this.password}) : super(key: key);

  @override
  _Change_new_numberState createState() => _Change_new_numberState();
}


class _Change_new_numberState extends State<Change_new_number> {
  mobile_Update_Notifier mobile_update_notifier = mobile_Update_Notifier();
  String id='';
  @override

  void initState() {
    MySharedPreferences.instance.getid('id').then((value) {
      id=value.toString();
    });
   print( widget.password);
    // TODO: implement initState
    super.initState();
  }
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _oldNumber = TextEditingController();
  TextEditingController _newNumber = TextEditingController();

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
    if (_oldNumber.text != _newNumber.text) {
      return "Password Does Not Match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:   Color(0xffF3F3F3),
        body: _buildbody(context),
      ),
    );
  }
  Widget _buildbody(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBackButton(context),
          buildChangeNewPassword(context),
          buildChangepassPara(context),
          Form(
            key: _key,
            child: Column(
              children: [
                buildoldmobile(context),
                buildNewMobile(context),
              ],
            ),
          ),
          buildConfirmButton(context),
        ],
      ),
    );
  }

  Widget buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0,left: 15),
      child: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.only(left:6),
            child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.blueAccent,),
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
      child: Text(
          'Change new Number',
          style:TextHeadingStyle(context)
      ),
    );
  }

  Widget buildChangepassPara(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.05),
      child: Text(
          'Your new Mobile number must be different from previous used Mobile Number.',
          style: TextParaStyle(context)
      ),
    );
  }

  Widget buildoldmobile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: validateNumber,
        controller: _oldNumber,
        maxLength: 10,
        decoration: InputDecoration(
          counterText: '',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.call),
            ),
            // suffixIcon: Padding(
            //   padding: const EdgeInsets.only(
            //     right: 10,
            //   ),
            //   child: IconButton(
            //     icon:
            //     Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            //     onPressed: () {
            //       setState(() {
            //         _isObscure = !_isObscure;
            //       });
            //     },
            //   ),
            // ),
            hintText: 'Old Number',
            hintStyle: TextFieldStyle(context)),
      ),
    );
  }

  Widget buildNewMobile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        keyboardType: TextInputType.number,
          validator: validateNumber,
          controller: _newNumber,
          maxLength: 10,
          decoration: InputDecoration(
            counterText: '',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:Icon(Icons.call)
            ),
            // suffixIcon: Padding(
            //   padding: const EdgeInsets.only(right: 10),
            //   child: IconButton(
            //     icon:
            //     Icon(_isObscure1 ? Icons.visibility : Icons.visibility_off),
            //     onPressed: () {
            //       setState(() {
            //         _isObscure1 = !_isObscure1;
            //       });
            //     },
            //   ),
            // ),
            hintText: 'New Number',
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
                  if(_key.currentState!.validate()){
                    mobile_update_notifier.mobile_update_setting(widget.password,_oldNumber.text, _newNumber.text,id);
    }},
              style: getButtonStyle(context),
              child: AutoSizeText(
                  'Confirm',
                  maxLines: 1,textAlign: TextAlign.center,
                  style: TextButtonStyle(context)
              )),
        ),
      ),
    );
  }
}
