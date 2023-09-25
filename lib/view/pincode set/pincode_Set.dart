import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:user_clinic_token_app/core/request_response/gender&age/age&gender_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/gender&age/gender&age_response..dart';
import 'package:user_clinic_token_app/view/homescreen/homescreen.dart';

class pincode_Set extends StatefulWidget {
  final email;
  final gender;
  final age;
   pincode_Set({Key? key,required this.email,required this.gender,required this.age}) : super(key: key);

  @override
  State<pincode_Set> createState() => _pincode_SetState();
}

class _pincode_SetState extends State<pincode_Set> {
  age_number_Notifier Addage=age_number_Notifier();
  @override
  void initState() {
    print('Abdur');
    print(widget.email);
    print(widget.gender);
    print(widget.age);
    Future.delayed(Duration.zero,(){
      screenLock<void>(
        canCancel: false,
        context: context,
        confirmation: true,
        // footer: TextButton(onPressed: () {
        //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()), (route) => false);
        //   },
        //   child: Text('Forget Password'),),
        didConfirmed: (pass){
          print(pass);
          Addage.AddGender(widget.email, widget.age, widget.gender, pass);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        },
        // didUnlocked:() {
        //   Navigator.pop(context);
        //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()), (route) => false);
        // },
        correctString:'',
      );
    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
