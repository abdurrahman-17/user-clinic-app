import 'package:flutter/material.dart';
import 'package:user_clinic_token_app/view/login/login.dart';
import 'package:user_clinic_token_app/view/signup/singup.dart';




class SignedUpScreen extends StatefulWidget {
  const SignedUpScreen({Key? key}) : super(key: key);

  @override
  _SignedUpScreenState createState() => _SignedUpScreenState();
}

class _SignedUpScreenState extends State<SignedUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image(image: AssetImage('assets/images/bgshape.png'),
                fit: BoxFit.fill,width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.10),
                    child: Container(
                      height: 350,
                      width: 350,
                      child: Image(image: AssetImage('assets/images/Signeduppic.png'),
                      ),
                    ),
                  ),
                  Center(
                    child: Text('Already',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  Center(
                    child: Text('Signed Up?',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 120,
                          child: ElevatedButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                          }, child:
                              Text('Yes',style: TextStyle(
                                fontSize: 20,
                              ),
                              ),
                            style:  ButtonStyle(
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
                          width: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: 120,
                          child: ElevatedButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                          }, child:
                              Text('No',style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                ),
                              ),
                            style:  ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side:BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
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
}
