import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/onboard_screens/Gender_Screen.dart';

class OnboardingScreen extends StatefulWidget {
  //static const ROUTE_NAME = 'OnboardingScreen';
  const OnboardingScreen({Key? key, }) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  dynamic data=Get.arguments;

  String email='';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image(image: AssetImage('assets/images/ageshape.png'),
                fit: BoxFit.fill,width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12,left: 40),
                    child: Container(
                      height: 350,
                      width: 350,
                      child: Image(image: AssetImage('assets/images/onboardpic.png'),
                      ),
                    ),
                  ),
                  Center(
                    child: Text('Finding available appointments',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  Center(
                    child: Text('are',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  Center(
                    child: Text(' Simple & Effortless',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                      var test =  MySharedPreferences.instance.getEmail("emails");
                        var me = MySharedPreferences.user_clinic().getEmail("email");
                        print("saadh on email" + me.toString());
                        print("saadh on test email" + test.toString());
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GenderScreen(email:email)));
                    }, child:
                    Text('Next',style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side:BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    email=Get.arguments[0]['email'];
    print(email);
  }
}
