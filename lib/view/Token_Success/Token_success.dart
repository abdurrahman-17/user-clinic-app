import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/Appointment%20Done/Appointemnt_done.dart';
import 'package:user_clinic_token_app/view/Token_done/Token_done_page.dart';
class Token_Suceess extends StatefulWidget {
  const Token_Suceess({Key? key}) : super(key: key);

  @override
  _Token_SuceessState createState() => _Token_SuceessState();
}

class _Token_SuceessState extends State<Token_Suceess> {

  dynamic data=Get.arguments;
  String name='';
  String age='';
  String date='';
  String time='';
  String token='';
  String drname='';
  String drspec='';
  String draddress='';
  String drimage='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(data);
    print('irfan');
    print('abdul');
    name=Get.arguments[0]['name'].toString();
    age=(Get.arguments[1]['age']);
    date=(Get.arguments[2]['date']);
    time=(Get.arguments[3]['time']);
    token=(Get.arguments[4]['token']);
    drname=(Get.arguments[5]['drname']);
    drspec=(Get.arguments[6]['drspec']);
    draddress=(Get.arguments[7]['draddress']);
    drimage=(Get.arguments[8]['drimage']);
    print('check');
    print(name);
    print(age);
    print(date);
    print(time);
    print(token);
    print(drname);
    print(drspec);
    print(draddress);
    print(drimage);

    // print(data[5]['drspec']);
    // print(data[6]['draddress']);
    // print(data[7]['drimage']);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildbody(context),
    );
  }
  Widget buildbody(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          buildsucessImage(context),
          buildSucessText(context),
          buildSucessSubTitile(context),
          buildButton(context),
        ],
      ),
    );
  }
  Widget buildsucessImage(BuildContext context){
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
      child: SvgPicture.asset('assets/images/checkbig.svg'),
    );
  }
  Widget buildSucessText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top:50),
      child: Text('Your Have Successfully Book Appointment!',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color: Color(0xff1C1C1C)),textAlign: TextAlign.center,),
    );
  }
  Widget buildSucessSubTitile(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text('Lorem ipsum dollor sit ament pallentesque adeipiscing elit enim minim ven ultricies eget, tempor sit amet, ante.',
          style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
    );
  }
  Widget buildButton(BuildContext context){
    return Padding(
      padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.25,right: 25,bottom: 20,left: 25),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(onPressed: (){
            var inputFormat = DateFormat('yyyy-MM-dd');
            var inputDate = inputFormat.parse(date.toString()); // <-- dd/MM 24H format

            var outputFormat = DateFormat("yyyy MMMM dd");
            String outputDate = outputFormat.format(inputDate);
            print('irfan'+outputDate);
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>token_done_page(name:name,age:age,date:outputDate,time:time.toUpperCase(),token:token.toUpperCase(),drname:drname,drspec:drspec,drimage:drimage,draddress:draddress)));
          },
              child: Text('Done',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
              style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
          ),
        ),
      ),
    );
  }
}
