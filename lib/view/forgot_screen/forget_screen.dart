import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/request_response/email_otp_request/Email_Otp_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/common/app_validators.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  @override
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  EmailotpNotifier? otpNotifier;
  TextEditingController emailController=TextEditingController();
  SharedPreferences? forgot;

  // Future<void> initializePreference() async {
  //   forgot = await SharedPreferences.getInstance();
  //   forgot?.setString('forgetemail', emailController.text);
  // }

  @override
  Widget build(BuildContext context) {
    if(kReleaseMode){}
    return Consumer<EmailotpNotifier>(
      builder: (context,provider,_){
        return ModalProgressHUD(inAsyncCall: provider.isLoading, child:SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: _buildBody(context),
          ),
        ) );
      },
    );
  }
  Widget _buildBody(BuildContext context){
    otpNotifier =
    Provider.of<EmailotpNotifier?>(context, listen: false)!;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(context),
            titleText(context),
            descriptionText(context),
            emailTextField(context),
            buttonRequestOTP(context,otpNotifier!),
          ],
        ),
      ),
    );
  }
  Widget backButton(context) {
    return Row(
      children: [
        GestureDetector(
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
        //Text('Change Email',style: TextStyle(color: Color(0xff4889FD,),fontWeight: FontWeight.w700,fontSize: 24),),
      ],
    );
  }

  Widget titleText(context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20),
      child: Text(
        'Forget Password',
        style: TextHeadingStyle(context)
      ),
    );
  }

  Widget descriptionText(context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
      child: Text("Enter the email associated with your account and we\'ll send an email with OTP to reset your password",
        style:TextParaStyle(context)
      ),
    );
  }

  Widget emailTextField(context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      child: Form(
        key: _key,
        child: TextFormField(
          controller: emailController,
          validator: validateEmail,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Image.asset(AppImages.SMS),
            ),
            hintText:"Email",
            hintStyle: TextFieldStyle(context)
          ),
        ),
      ),
    );
  }

  Widget buttonRequestOTP(context,EmailotpNotifier notifier) {
    return Padding(
      padding:EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.17),
      child: Center(
        child: SizedBox(
          height: 50,
          width: 234,
          child: ElevatedButton(
            style:getButtonStyle(context),
            child: AutoSizeText("Request OTP",
              style: TextButtonStyle(context),maxLines: 1,
              textAlign: TextAlign.center,       ),
            onPressed: () {
              if (_key.currentState!.validate()) {
                // initializePreference();
                // SharedPrefImpl(context).SetEmail(emailControlller.text);
                var getemail=emailController.text;
                print(getemail);
                // await UserSimplePreferences.setEmail(emailController.text);
                // initializePreference();
                MySharedPreferences.instance.setEmail("emails", getemail);
                notifier.PatientEmail_Otp(emailController.text.trim());
              }
            },
          ),
        ),
      ),
    );
  }
}
