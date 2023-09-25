import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notification_Screen extends StatefulWidget {
  const Notification_Screen({Key? key}) : super(key: key);

  @override
  _Notification_ScreenState createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F9FC),
        body: _buildbody(context),
    );
  }
  Widget _buildbody(BuildContext context){
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.01
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(context),
              SizedBox(height: 20,),
              //buildNotificationTitle(context),
              buildNewtitle(context),
              buildnewnotifylist(context),
              buildRecenttitle(context),
              buildrecentnotifylist(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget backButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: Icon(Icons.arrow_back_ios,size: 15,),
            ),
          ),
        ),
    Padding(
      padding:const EdgeInsets.only(right:6),
      child: Text('Notification',style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 30,color: Color(0xff4889fd)),),
    ),
        SizedBox(width: 10,)
      ],
    );
  }
  Widget buildNotificationTitle(context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Center(child: Text('Notification',style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 30,color: Color(0xff4889fd)),)),
    );
  }
  Widget buildNewtitle(BuildContext context){
    return Center(child: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text('New',style: GoogleFonts.quicksand(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),),
    ));
  }
  Widget buildnewnotifylist(BuildContext context){
    return ListView.builder(shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context,int){
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: Text('29 January 2022, 7.14 PM',style:GoogleFonts.quicksand(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.grey))),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top:5,left: 10,bottom: 10),
            child: Text('You\'r Appointment is 12.00 AM tomorrow 30/01/2022',maxLines: 2,style: GoogleFonts.quicksand(textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black)),),
          ),
        ),
      );
    });
  }
  Widget buildRecenttitle(BuildContext context){
    return Center(child: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text('Recent',style: GoogleFonts.quicksand(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),),
      ),
    ));
  }
  Widget buildrecentnotifylist(BuildContext context){
    return ListView.builder(shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context,int){
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 10,top: 10),
                child: Text('28 January 2022, 7.14 PM',style:GoogleFonts.quicksand(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.grey))),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top:5,left: 10,bottom: 10),
                child: Text('You\'r Appointment is 12.00 AM tomorrow 29/01/2022',maxLines: 2,style: GoogleFonts.quicksand(textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black)),),
              ),
            ),
          );
        });
  }
}
