import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/forget_pincode/email_for_pin_OTP.dart';
import 'package:user_clinic_token_app/view/homescreen/homescreen.dart';

class password_Screen extends StatefulWidget {
  const password_Screen({Key? key}) : super(key: key);

  @override
  State<password_Screen> createState() => _password_ScreenState();
}

class _password_ScreenState extends State<password_Screen> {
  Future<void> localAuth(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticateWithBiometrics(
      localizedReason: 'Please authenticate',
    );
    if (didAuthenticate) {
      //Future.delayed(Duration.zero,(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()), (route) => false);
      //});

    }
  }
  String password='';
  @override
  void initState() {
    MySharedPreferences.instance.getPin('pin').then((value) {
      print(value);
      password=value;
    });
    Future.delayed(Duration.zero,(){
      screenLock<void>(
        context: context,
        correctString: password,
        canCancel: false,
        footer: TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>pin_ForgetScreen_OTP()));},
          child: Text('Forget Password'),),
        didUnlocked:() {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()), (route) => false);
        },
        customizedButtonChild: const Icon(
          Icons.fingerprint,
        ),
        customizedButtonTap: () async {
          await localAuth(context);
        },
        didOpened: () async {
          await localAuth(context);
        },
      );
    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}
