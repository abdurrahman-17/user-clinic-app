import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/request_response/gender&age/age&gender_Notifier.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/homescreen/homescreen.dart';
import 'package:user_clinic_token_app/view/onboard_screens/Gender_Screen.dart';
import 'package:user_clinic_token_app/view/pincode%20set/pincode_Set.dart';
import 'Onboarding_Screen.dart';

class AgeScreen extends  StatefulWidget {
  final selectedValue;
  final email;
   AgeScreen({Key? key, required this.selectedValue,required this.email}) : super(key: key);
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int _currentIntValue = 10;
  String email="";
  String token="";


  @override
  void initState() {
    print('abdur');
    print(widget.email);
    print(widget.selectedValue);
    print('irfan');
    MySharedPreferences.instance.getEmail("emails").then((value) =>  setState(() {
      email = value;
      MySharedPreferences.instance.getToken("token").then((value) => setState((){
        token=value;
        MySharedPreferences.instance.setDecoded('decoded', token);
      }));
    }));
  }

 // int ages;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //email=UserSimplePreferences.getEmail() ?? "";
  // }
  // @override
  // void getemail()async{
  //   genderage=await SharedPreferences.getInstance();
  //   setState(() {
  //     email=genderage?.getString('mail') ?? "";
  //   });
  //
  // }
  age_number_Notifier? age_number_notifier;
  @override
  Widget build(BuildContext context) {
    age_number_notifier =
    Provider.of<age_number_Notifier?>(context, listen: false)!;
    return Consumer<age_number_Notifier>(
      builder: (context,provider,_){
        return ModalProgressHUD(inAsyncCall:provider.isLoading,
            child:SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Image(image: AssetImage('assets/images/ageshape.png'),
                        fit: BoxFit.fill,width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('Select',style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ),
                          Text('Age',style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          Container(
                            height: 250,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.blue,width: 2),
                              color: Colors.white,
                            ),
                            child: NumberPicker(
                              value: _currentIntValue,
                              selectedTextStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                              ),
                              minValue: 0,
                              maxValue: 100,
                              step: 01,
                              haptics: true,
                              onChanged: (value) => setState(() {
                                _currentIntValue = value;
                                //ages=_currentIntValue;
                              }
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 60,
                            width: 150,
                            child: ElevatedButton(onPressed: (){
                              print('irfan'+email);
                              print('irfan'+token);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>pincode_Set(email:widget.email,gender:widget.selectedValue,age:_currentIntValue)));
                              //age_number_notifier?.AddGender(widget.email,_currentIntValue,widget.selectedValue);
                              // Navigator.push(context, `MaterialPageRoute(builder: (context)=>HomeScreen()));
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
            ) );
      },
    );
  }
}
