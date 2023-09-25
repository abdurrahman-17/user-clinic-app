import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user_clinic_token_app/core/request_response/add%20Token%20Appointment/add_Token_Appointment_Notifier.dart';
import 'package:user_clinic_token_app/view/Appointment%20Done/Appointemnt_done.dart';
class Suceess extends StatefulWidget {
  final drname;
  final draddress;
   Suceess({Key? key, this.drname, this.draddress}) : super(key: key);

  @override
  _SuceessState createState() => _SuceessState();
}

class _SuceessState extends State<Suceess> {
add_Token_Appointment_Notifier provider=add_Token_Appointment_Notifier();
  dynamic data=Get.arguments;
  String name='';
  String age='';
  String date='';
  String time='';
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
     drname=(Get.arguments[4]['drname']);
     drspec=(Get.arguments[5]['drspec']);
     draddress=(Get.arguments[6]['draddress']);
     drimage=(Get.arguments[7]['drimage']);
     print('check');
     print(name);
     print(age);
     print(date);
     print(time);
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return  SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),

            child: IntrinsicHeight(
              child: Column(
                children: [
                  buildsucessImage(context),
                  buildSucessText(context),
                  //buildSucessSubTitile(context),
                  Expanded(child: Container()),
                  buildButton(context),
                ],
              ),
            ),
          ),
        );
      });
  }
  Widget buildsucessImage(BuildContext context){
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.40),
      child: SvgPicture.asset('assets/images/checkbig.svg'),
    );
  }
  Widget buildSucessText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top:50),
      child: Text("You have successfully booked",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color: Color(0xff1C1C1C)),textAlign: TextAlign.center,),
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
      padding: const EdgeInsets.all(25),
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
            // var inputFormat1 = DateFormat('e');
            // var inputDate1 = inputFormat1.parse(time.toString()); // <-- dd/MM 24H format
            //
            // var outputFormat1 = DateFormat("e");
            // String outputDate1 = outputFormat1.format(inputDate1);
            // print('irfan'+outputDate1);*
            // 12/31/2000 11:59 PM <-
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Appointment_done(name:name,age:age,date:outputDate,time:time.toUpperCase(),drname:drname,drspec:drspec,drimage:drimage,draddress:draddress)));},
              child: Text('Done',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
              style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
          ),
        ),
      ),
    );
  }
}
