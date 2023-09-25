import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/email_change/email_change_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/email_change/email_change_response.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/common/app_validators.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';

class Change_new_email extends StatefulWidget {
  final selected;
   Change_new_email({Key? key,required this.selected}) : super(key: key);

  @override
  _Change_new_emailState createState() => _Change_new_emailState();
}

class _Change_new_emailState extends State<Change_new_email> {
  bool _isObscure = true;
  bool _isObscure1 = true;
  Email_change_Notifier? email_change_notifier;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _old_email = TextEditingController();
  TextEditingController _new_email = TextEditingController();

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
    if (_old_email.text != _new_email.text) {
      return "Password Does Not Match";
    }
    return null;
  }

  String id='';
@override
  void initState() {
    MySharedPreferences.instance.getid('id').then((value) {
      id=value.toString();
    });
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Email_change_Notifier>(
      builder: (context,provider,_){
        return ModalProgressHUD(inAsyncCall: provider.isLoading, child:SafeArea(
          child: Scaffold(
            backgroundColor:  Color(0xffF3F3F3),
            body: _buildbody(context),
          ),
        ));
      },
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
                buildEmail(context),
                buildNewEmail(context),
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
      padding: EdgeInsets.only(
          top: 15,
          left: 15),
      child:           GestureDetector(
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
          'Change new Email',
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
         'Your new Mail id must be different from previous used Mail id.',
          style: TextParaStyle(context)
      ),
    );
  }

  Widget buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        validator: validateEmail,
        controller: _old_email,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.email_outlined),
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
            hintText: 'Old Email',
            hintStyle: TextFieldStyle(context)),
      ),
    );
  }

  Widget buildNewEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
          validator: validateEmail,
          controller: _new_email,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:Icon(Icons.email_outlined)
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
            hintText: 'New Email',
            hintStyle: TextFieldStyle(context),
          )
      ),
    );
  }

  Widget buildConfirmButton(BuildContext context) {
    email_change_notifier=Provider.of<Email_change_Notifier?>(context,listen: false);
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
                  email_change_notifier!.email_change_setting(widget.selected, _old_email.text, _new_email.text,id);
                }
                email_change_notifier!.email_change_setting(widget.selected, _old_email.text, _new_email.text,id);
                  // Navigator.pushNamed(context, RoutePaths.LOGIN);
              },
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
