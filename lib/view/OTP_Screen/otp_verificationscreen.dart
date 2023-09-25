import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/request_response/Otp_verify/Otp_verify_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/email_otp_request/Email_Otp_Notifier.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref_impl.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';


class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _otpcontroller = TextEditingController();
  final _keyscafflod = GlobalKey<ScaffoldState>();
   OTP_Notifier? otpVerifyNotifier;
   SharedPreferences? forgot;
   String email='';
  dynamic data=Get.arguments;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getemail();
    //  MySharedPreferences.instance.getEmail("email").then((value) => setState((){
    //    email=value;
    //  }));
    email=Get.arguments[0]['email'];
    print(email);
  }
  @override
 // void getemail()async{
 //   forgot=await SharedPreferences.getInstance();
 //   setState(() {
 //     email=forgot?.getString('forgetemail') ?? "";
 //     print(email);
 //   });
 //
 // }
  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<OTP_Notifier>(
      builder: (context, provider, _) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          child: SafeArea(
            child: Scaffold(
              key: _keyscafflod,
              body:   Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: buildBody(context)
              ),
            ),
          ),
        );
      },
    );

  }

  Widget buildBody(context){
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              backButton(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              titleText(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              otpVerificationText(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              verificationTextField(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              buttonRequestOTP(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              didnotRecieveText(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              resendOtpText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton(context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(

          border: Border.all(color: Color(0xff4889FD), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff4889FD),
            size: 15,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget titleText(context) {
    return Text(
        'OTP Verification',
        style: TextHeadingStyle(context)
    );
  }

  Widget otpVerificationText(context) {
    return Text(
        'Enter the verification code we just sent you on your email address',
        style: TextParaStyle(context)
    );
  }

  Widget verificationTextField(context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        child: PinCodeTextField(
          controller: _otpcontroller,
          length: 4,
          obscureText: true,
          showCursor: false,
          //blinkWhenObscuring: true,
          pinTheme:PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(18),
            borderWidth:0,
            fieldWidth: 75,
            fieldHeight: 75,
            activeColor: Colors.white,
            inactiveColor: Colors.white,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
          ),
          enableActiveFill: true,

          keyboardType: TextInputType.number,
          //backgroundColor: Colors.white,
          onChanged: (value){print(value);}, appContext: context,),
      ),
    );
  }

  Widget buttonRequestOTP(context) {
    otpVerifyNotifier =
        Provider.of<OTP_Notifier?>(context, listen: false);
    return Center(
      child: SizedBox(
        height: 50,
        width: 234,
        child: ElevatedButton(
          style: getButtonStyle(context),
          child: Text(
              'Submit',
              style: TextButtonStyle(context)
          ),
          onPressed: () {
            otpVerifyNotifier?.otp_verfiy(
                email, _otpcontroller.text.trim());
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChangeNewPassword()));
            // Navigator.pushNamed(context, RoutePaths.CHANGENEWPASSWORD);
          },
        ),
      ),
    );
  }

  Widget didnotRecieveText(context) {
    return  const Center(
      child: Text(
        'Didn\'t receive OTP? ',
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }

  Widget resendOtpText(context) {
   EmailotpNotifier notifier =
    Provider.of<EmailotpNotifier?>(context, listen: false)!;
    return Center(
      child: InkWell(
        child: Text(
          'Resend',
          textAlign: TextAlign.center,
          style: TextResendStyle(context),
        ),
        onTap: (){
          notifier.PatientEmail_Otp(email);
        },
      ),
    );
  }
}