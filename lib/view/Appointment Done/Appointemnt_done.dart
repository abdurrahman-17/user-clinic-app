import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/no%20Image/no_Image_Response_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
import 'package:user_clinic_token_app/view/homescreen/homescreen.dart';


class Appointment_done extends StatefulWidget {
  final name;
  final age;
  final time;
  final date;
  final drname;
  final drspec;
  final drimage;
  final draddress;
  const Appointment_done({Key? key,required this.name,required this.age, required this.time, required this.date, required this.drname, required this.drspec,required this.drimage,required this.draddress}) : super(key: key);

  @override
  _Appointment_doneState createState() => _Appointment_doneState();
}

class _Appointment_doneState extends State<Appointment_done> {
  No_Image no_imageprovider=No_Image();
  String utcDate='';
  @override
  void initState() {
    DateTime tempDate = DateFormat("hh:mm").parse(widget.time);
    var dateFormat = DateFormat("h:mm a"); // you can change the format here
     utcDate = dateFormat.format(tempDate);
    print(utcDate);
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      no_imageprovider.getNo_Image().then((value){
        print(no_imageprovider.no_ImageResponseClass);
      });
      no_imageprovider.notifyListeners();
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(60),
        //   child: buildAppBar(context),
        // ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              backButton(context),
              buildFirstHalfScreen(context),
              //buildProfile(context),
              buildUserName(context),
              buildDateandTime(context),
              buildAddress(context),
              buildAttention(context),
              buildDoneButton(context),
              //buildCancelButton(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget backButton(context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: 15,bottom: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()), (route) => false);
            },
            child: Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left:6),
                    child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.black,),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
            child: Text('',style:GoogleFonts.roboto(fontSize: 25),),
          ),
          SizedBox(width: 10,)
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[Color(0xffFFFFFF), Color(0xffFCFAFA)]),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(

          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,size: 20,
              ),
            ),
          ),
        ),
      ),
      // actions: [
      //   IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.black))
      // ],
      centerTitle: true,
    );
  }
  Widget buildFirstHalfScreen(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffFFFFFF).withOpacity(1),
                Color(0xffFCFAFA).withOpacity(1)
              ]
          ),

          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15))
      ),
      child: Column(
        children: [
          buildProfilePicture(context),
          buildDrNameAndDepartment(context),
          //buildMsgAndCall(context),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
  Widget buildProfilePicture(BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child:widget.drimage=="null"?
          CachedNetworkImage(
              fit: BoxFit.cover,
              width: 100,
              height: 100,
              placeholder: (context, url) => Image.asset('assets/images/giphy.gif'),
              imageUrl:DataConstants.LIVE_BASE_URL+'/'+no_imageprovider.no_ImageResponseClass
                  //DataConstants.LIVE_BASE_URL+widget.drimage,
              //"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRLe5PABjXc17cjIMOibECLM7ppDwMmiDg6Dw&usqp=CAU"),
        ):CachedNetworkImage(
              fit: BoxFit.fill,
              width: 100,
              height: 100,
              placeholder: (context, url) => Image.asset('assets/images/giphy.gif'),
              imageUrl:
                  DataConstants.LIVE_BASE_URL+'/'+widget.drimage,
              //"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRLe5PABjXc17cjIMOibECLM7ppDwMmiDg6Dw&usqp=CAU"),
        ),
      ),
    ));
  }
  Widget buildDrNameAndDepartment(BuildContext context){
    return Column(
      children: [
        SizedBox(height: 30,),
        Text('Dr. '+widget.drname,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
        SizedBox(height: 10,),
        Text(widget.drspec,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Color(0xff6B779A)),)
      ],
    );
  }
  Widget buildMsgAndCall(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xffEDA1AB).withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(Icons.textsms_rounded,color: Color(0xffEDA1AB),)),
          SizedBox(width: 50,),
          Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xff7ACEFA).withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(Icons.call,color: Color(0xff7ACEFA),)),
        ],
      ),
    );
  }
  Widget buildProfile(BuildContext context) {
    return Container(

      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
        color: Theme.of(context).primaryColor,
        // gradient: LinearGradient(
        //     begin: Alignment.centerLeft,
        //     end: Alignment.centerRight,
        //     colors: [
        //       Color(0xff6CA5FC),
        //       Color(0xff4F96FF)
        //     ]
        // ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: IconButton(onPressed: () {Navigator.pop(context);},
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: IconButton(onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none_outlined, color: Colors.white,)),
              ),

            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 10,bottom: 10),
                  child:CircleAvatar(
                      minRadius: 50,
                      maxRadius: 50,
                      //   height: MediaQuery
                      //       .of(context)
                      //       .size
                      //       .height * 0.18,
                      //   width: MediaQuery
                      //       .of(context)
                      //       .size
                      //       .width * 0.28,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       image: DecorationImage(
                      //           fit: BoxFit.fill,
                      backgroundImage: NetworkImage(
                      'https://thumbs.dreamstime.com/b/doctor-vector-illustration-smiling-53599819.jpg')
                      )
                      ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Dr. Nadeem', style: NameStyle(context),),
                    SizedBox(height: 10,),
                    Text('Heart Surgeon', style: SpecialistStyle(context),),
                    SizedBox(height: 10,),
                    Text('Fees ₹ 200',style: SpecialistStyle(context),)
                    // RatingBar.builder(
                    //   unratedColor: Colors.transparent,
                    //   itemSize: 18,
                    //   initialRating: 4.5,
                    //   minRating: 1,
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: true,
                    //   itemCount: 5,
                    //   itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    //   itemBuilder: (context, _) =>
                    //       Icon(Icons.star, color: Colors.amber,),
                    //   onRatingUpdate: (double value) {
                    //
                    //   },)
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 10, width: 5,),
                  Text('14 years EXP', style: ExpStyle(context),)
                ],
              )
            ],
          ),

        ],
      ),
    );
  }
  Widget buildUserName(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 40,right: 40),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.10),
            offset: Offset(0,2),
            blurRadius: 2,
          )],
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Info',style: DateContainerStyle(context),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 10),
                child: Text('Name : '+widget.name,style: DateContainer1Style(context),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text('Age     : '+widget.age,style: DateContainer1Style(context),),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget buildDateandTime(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 40,right: 40),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.10),
            offset: Offset(0,2),
            blurRadius: 2,
          )],
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Date and Time',style: DateContainerStyle(context),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 10),
                child: Text(widget.date,style: DateContainer1Style(context),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text('Your Appointment on '+utcDate,style: DateContainer1Style(context),),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget buildAttention(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 40,right: 40),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.30),
          borderRadius:BorderRadius.circular(5)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Row(
            children: [
              Icon(Icons.info_outline,color: Colors.blueAccent),
              SizedBox(width: 10,),
              Expanded(child: Text('Please reach 10 Minutes before your slot time.',style: AttentionStyle(context),))
            ],
          ),
        ),
      ),
    );
  }
  Widget buildAddress(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 40,right: 40),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.10),
            offset: Offset(0,2),
            blurRadius: 2,
          )],
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Address',style: DateContainerStyle(context),)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15,left: 25),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(widget.draddress,
                      //'No.15, Ashraf Street, near State Bank of India, Peranampattu, Tamil Nadu 635810.',
                      style: AddressStyle(context),)),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 10,top: 10),
              //   child: Align(
              //       alignment: Alignment.topRight,
              //       child: Text('Get Direction',style:GetdirectionStyle(context) ,)),
              // )
            ],
          ),
        ),
      ),
    );
  }
  Widget buildDoneButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 20,left: 30,right: 30),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (){
            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()), (route) => false)
            ;
          },
          child: Text("Done",style: TextButtonStyle(context),),
          style: AppointmentbuttonStyle(context),
        ),
      ),
    );
  }
  // Widget buildCancelButton(BuildContext context){
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 20,left: 30,right: 30),
  //     child: SizedBox(
  //       height: 50,
  //       width: double.infinity,
  //       child: ElevatedButton(
  //         onPressed: (){
  //           Navigator.pushNamed(context, RoutePaths.Token);
  //         },
  //         child: Text('Cancel Appointment',style: TextCancelButtonStyle(context),),
  //         style:CancelbuttonStyle(context),
  //       ),
  //     ),
  //   );
  // }

}

