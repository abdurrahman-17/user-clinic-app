import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/get%20Appointment%20Filter/get_Appointment_Filter_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/no_of_appointment/No_of_appointment_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:intl/intl.dart';
import 'package:user_clinic_token_app/view/My%20Appointment/appointment_Past.dart';
import 'package:user_clinic_token_app/view/My%20Appointment/appointment_Upcoming.dart';
import 'package:user_clinic_token_app/view/pharmacy/pharmacy.dart';

class No_of_Appointment extends StatefulWidget {
  const No_of_Appointment({Key? key}) : super(key: key);

  @override
  _No_of_AppointmentState createState() => _No_of_AppointmentState();
}

class _No_of_AppointmentState extends State<No_of_Appointment> {
  // No_of_appointment provider=No_of_appointment();
  // Get_Appointment_Filter_Notifier providerfilter=Get_Appointment_Filter_Notifier();

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.delayed(Duration.zero,(){
  //     provider.getNo_of_appointment(12.toString()).then((value) {
  //       provider.notifyListeners();
  //       for(int i=0;i<provider.appointmentResponseClass.length;i++){
  //         print(provider.appointmentResponseClass[i].doctorName.toString());
  //       }
  //     });
  //   });
  // }
  DateTime? todayDate = DateTime.now();
  String formatted='';
  bool filters=false;

  // _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: todayDate!, // Refer step 1
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   );
  //   if (picked != null && picked != todayDate) {
  //     setState(() {
  //       todayDate = picked;
  //       final DateFormat format=DateFormat('yyy-MM-dd');
  //       formatted=format.format(picked);
  //       print(formatted);
  //       filter();
  //       filters=true;
  //     });
  //   }
  // }
  // void filter(){
  //   Future.delayed(Duration.zero,(){
  //     providerfilter.Get_Appointment_filter_data(12.toString(), formatted).then((value) {
  //       providerfilter.notifyListeners();
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
        return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff4889FD),
              centerTitle: true,
              elevation: 0,
              title: Text('My Appointment',style:GoogleFonts.roboto(fontSize: 25,color: Colors.white),),
              leading:GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:  EdgeInsets.only(left: 10,top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(left:6),
                        child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Color(0xffF7F9FC),
            body:buildbody(context),
          ),
          ),
        );
  }
  Widget buildbody(BuildContext context){
    return Consumer<No_of_appointment>(
      builder: (context,provider,_){
        //this.provider=provider;
        return ModalProgressHUD(inAsyncCall: provider.isloading, child:
        buildNo_of_appointment(context));
      },
    );
  }
  Widget buildBackground(BuildContext context){
    return Container(
      height:80,
      decoration: BoxDecoration(
        color:Color(0xff4889FD),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
      ),
    );
  }
  Widget buildNo_of_appointment(BuildContext context){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //backButton(context),
            buildTabBar(context),
            buildTabBar_View(context),

            // Padding(
            //   padding: const EdgeInsets.only(top: 40),
            //   child: GestureDetector(
            //     onTap: (){_selectDate(context);},
            //     child: Row(
            //       children: [
            //         Icon(Icons.filter_list_outlined,color: Colors.white,),
            //         Text('FILTER',style: GoogleFonts.roboto(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
            //       ],
            //     ),
            //   ),
            // ),
            // Container(
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 20),
            //     child: ListView.builder
            //       (
            //       physics: NeverScrollableScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: provider.appointmentResponseClass.length,
            //         itemBuilder: (context,index){
            //           return Padding(
            //             padding: const EdgeInsets.only(top: 25),
            //             child: GestureDetector(
            //
            //               onTap: (){
            //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Pharmacy(id:provider.appointmentResponseClass[index].id.toString())));
            //                 print(provider.appointmentResponseClass[index].id.toString());
            //                 },
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   boxShadow: [BoxShadow(
            //                       color: Colors.black26,
            //                       offset: Offset(0,4),
            //                       blurRadius: 3
            //                   )],
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.circular(11),
            //                 ),
            //                 child:Row(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.only(left: 16),
            //                       child: CircleAvatar(
            //                         radius: 35,
            //                         backgroundColor: Color(0xff5E698F),
            //                         child: Text(provider.appointmentResponseClass[index].doctorName.toString().substring(0,1).toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 40),),
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.only(left: 30),
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           SizedBox(height: 15,),
            //                           Text(provider.appointmentResponseClass[index].doctorName.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 19),),
            //                           SizedBox(height: 10,),
            //                           Text(provider.appointmentResponseClass[index].specialist.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.grey),),
            //                           SizedBox(height: 15,),
            //                           Padding(
            //                             padding: const EdgeInsets.only(bottom: 15),
            //                             child: Row(
            //                               children: [
            //                                 Icon(Icons.calendar_today,color: Colors.grey,),
            //                                 Text(provider.appointmentResponseClass[index].date.toString(),style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey),),
            //                               ],
            //                             ),
            //                           )
            //                         ],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           );
            //         }),
            //   ),
            // ),
            //buildButton(context),
          ],)
    );
  }
  Widget buildButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(right: 25,bottom: 10,left: 25,top: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(onPressed: (){
          Navigator.pop(context);
          },
            child: Text('Back',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
            style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
        ),
      ),
    );
  }
  Widget backButton(context) {
    return Row(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(left:6),
                  child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:EdgeInsets.only(top: 23,left: MediaQuery.of(context).size.width*0.02),
          child: Text('No.of Appointment',style:GoogleFonts.roboto(fontSize: 25,color: Colors.white),),
        )
      ],
    );
  }
  // Widget buildbody_filter(BuildContext context){
  //   return Consumer<Get_Appointment_Filter_Notifier>(
  //     builder: (context,provider,_){
  //       this.providerfilter=provider;
  //       return ModalProgressHUD(inAsyncCall: provider.isloading, child:
  //       SingleChildScrollView(
  //         child: Stack(
  //           children: [
  //             buildBackground_Design_filter(context),
  //             Column(
  //               children: [
  //                 buildNo_of_appointment_filter(context),
  //                 // buildButton(context),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ));
  //     },
  //   );
  // }
  Widget buildBackground_Design_filter(BuildContext context){
    return Container(
      height:250,
      decoration: BoxDecoration(
        color: Color(0xff4889FD),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
      ),
    );
  }
  // Widget buildNo_of_appointment_filter(BuildContext context){
  //   return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 20),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           backButton(context),
  //           SizedBox(height: 25,),
  //           Text('No.of Appointment',style:GoogleFonts.roboto(fontSize: 35,color: Colors.white,fontWeight: FontWeight.w700),),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 40),
  //             child: GestureDetector(
  //               onTap: (){_selectDate(context);},
  //               child: Row(
  //                 children: [
  //                   Icon(Icons.filter_list_outlined,color: Colors.white,),
  //                   Text('FILTER',style: GoogleFonts.roboto(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Container(
  //             child: Padding(
  //               padding: const EdgeInsets.only(top: 20),
  //               child: ListView.builder
  //                 (
  //                 physics: NeverScrollableScrollPhysics(),
  //                   shrinkWrap: true,
  //                   itemCount: providerfilter.get_appointment_filter_ResponseClass.length,
  //                   itemBuilder: (context,index){
  //                     return Padding(
  //                       padding: const EdgeInsets.only(top: 25),
  //                       child: GestureDetector(
  //
  //                         onTap: (){
  //                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Pharmacy(id:provider.appointmentResponseClass[index].id.toString())));
  //                           //print(providerfilter.get_appointment_filter_ResponseClass[index].id.toString());
  //                           },
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             boxShadow: [BoxShadow(
  //                                 color: Colors.black26,
  //                                 offset: Offset(0,4),
  //                                 blurRadius: 3
  //                             )],
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(11),
  //                           ),
  //                           child:Row(
  //                             children: [
  //                               Padding(
  //                                 padding: const EdgeInsets.only(left: 16),
  //                                 child: CircleAvatar(
  //                                   radius: 35,
  //                                   backgroundColor: Color(0xff5E698F),
  //                                   child: Text('S',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 40),),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.only(left: 30),
  //                                 child: Column(
  //                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                   children: [
  //                                     SizedBox(height: 15,),
  //                                     Text(providerfilter.get_appointment_filter_ResponseClass[index].doctorName.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 19),),
  //                                     SizedBox(height: 10,),
  //                                     Text(providerfilter.get_appointment_filter_ResponseClass[index].specialist.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.grey),),
  //                                     SizedBox(height: 15,),
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(bottom: 15),
  //                                       child: Row(
  //                                         children: [
  //                                           Icon(Icons.calendar_today,color: Colors.grey,),
  //                                           Text(providerfilter.get_appointment_filter_ResponseClass[index].date.toString(),style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey),),
  //                                         ],
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   }),
  //             ),
  //           ),
  //           buildButton(context),
  //         ],)
  //   );
  // }
  Widget buildButton_filter(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(right: 25,bottom: 10,left: 25,top: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(onPressed: (){
          Navigator.pop(context);
          },
            child: Text('Back',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
            style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
        ),
      ),
    );
  }
  Widget buildTabBar(BuildContext context){
    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.blue,
      indicatorWeight: 4,
      labelColor: Colors.black54,
        labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
        tabs: [
      Tab(text: 'Upcoming',),
      Tab(text: 'Past',),
    ]);
  }
  Widget buildTabBar_View(BuildContext context){
    return Flexible(
      child: TabBarView(children: [
        Upcoming_App(),
        Past_App(),
      ]),
    );
  }
  Widget backButton_filter(context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Padding(
        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: 0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(left:6),
              child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,),
            ),
          ),
        ),
      ),
    );
  }
}
