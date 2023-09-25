import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/Upcoming%20Appointment/upp_ComingApp_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/cancel%20Appointment/cancel_Appointment_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/no.of%20appointment/no_of_appointment.dart';
import 'package:user_clinic_token_app/view/update%20Appointment/update_Appointment.dart';
import 'package:user_clinic_token_app/view/update_Token_appointment/update_Appointment_Token.dart';

import '../../utils/sharedpreference/shared_preference.dart';

class Upcoming_App extends StatefulWidget {
  const Upcoming_App({Key? key}) : super(key: key);

  @override
  State<Upcoming_App> createState() => _Upcoming_AppState();
}

class Choice {
  const Choice({required this.name});
  final String name;
}

const List<Choice> choices = const <Choice>[
  const Choice(name: 'Edit Appointment', ),
  const Choice(name: 'Cancel Appointment', ),
];
class _Upcoming_AppState extends State<Upcoming_App> {
  Upcoming_App_Notifier provider=Upcoming_App_Notifier();
  Cancel_Appointment_Notifier provider1=Cancel_Appointment_Notifier();
  Choice _selectedOption = choices[0];
  String id='';
  int countspage=0;
@override
  void initState() {
  MySharedPreferences.instance.getid("id").then((value) {
    id=value.toString();
    print(value);
  });
  Future.delayed(Duration.zero,(){
    provider.Upcoming_App_data(id);
    provider.notifyListeners();
    print('irfan');
  });
    // TODO: implement initState
    super.initState();
  }
  void _select(Choice choice) {
    setState(() {
      _selectedOption = choice;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Upcoming_App_Notifier>(
      builder: (context,provider,_){
        this.provider=provider;
        return ModalProgressHUD(inAsyncCall: provider.isLoading, child: Scaffold(
          backgroundColor: Color(0xffF7F9FC),
          body: provider.upcoming_Appointment_ResponseClass.isEmpty?Center(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.event_busy,color: Colors.grey,size: 80,),
                SizedBox(height: 5,),
                Text('No Appointment booked',style: TextStyle(fontSize: 18),)
              ],
            ),
          ):Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
                clipBehavior: Clip.none,
                shrinkWrap: true,
                itemCount: provider.upcoming_Appointment_ResponseClass.length,
                itemBuilder: (context,index) {
                  final DateFormat formatters=DateFormat("E-MMMM-yyy");
                  final formatteds=formatters.format(provider.upcoming_Appointment_ResponseClass[index].date!);
                  final DateFormat formatterss=DateFormat("dd-MMMM-yyy");
                  final formattedss=formatterss.format(provider.upcoming_Appointment_ResponseClass[index].date!);
                  final date=formattedss.split('-').first;
                  //print(formatteds);
                  final month=formatteds.split('-');
                  // final time=provider.upcoming_Appointment_ResponseClass[index].appointmentTime.toString();
                  // print(time);
                  // var df =  DateFormat("hh:mm:ss");
                  // var dt = df.parse(time);
                  // var times=DateFormat('h:mm a').format(dt);
                  // print(times);
                  return Padding(
                    padding:  EdgeInsets.only(top: 10.0,bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow:  [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 2),
                                blurRadius: 5)
                          ],

                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.all(10),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(month[1],style: TextStyle(fontSize: 15,color: Colors.grey),),
                                SizedBox(height: 5,),
                                Text(date,style: TextStyle(fontSize: 35,color: Colors.blue,fontWeight: FontWeight.w500)),
                                SizedBox(height: 5,),
                                Text(month[0],style: TextStyle(fontSize: 15,color: Colors.grey)),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: 70,
                              child: VerticalDivider(thickness: 1,color: Colors.grey[350],)),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.userMd,size: 15,color: Colors.blueAccent,),
                                              SizedBox(width: 5,),
                                              Text(provider.upcoming_Appointment_ResponseClass[index].doctor.toString(),style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w500),),
                                            ],
                                          ),
                                          SizedBox(height: 3,),

                                          Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.stethoscope,size: 13,color: Colors.blueAccent,),
                                              SizedBox(width: 5,),
                                              Text(provider.upcoming_Appointment_ResponseClass[index].specialist.toString(),style: TextStyle(fontSize: 15,color: Colors.grey),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton(
                                      icon: Icon(Icons.more_vert),
                                      onSelected: (value) { // add this property
                                        if(value==0){
                                         final type=provider.upcoming_Appointment_ResponseClass[index].type;
                                         final app_id=provider.upcoming_Appointment_ResponseClass[index].id;
                                         final doctor_id=provider.upcoming_Appointment_ResponseClass[index].doctorId;
                                         type==1?Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Update_appointment(app_id:app_id,doctor_id:doctor_id))):Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Update_Toke_Appointment_New(app_id:app_id)));
                                        }else  if(value==1){
                                          final id=provider.upcoming_Appointment_ResponseClass[index].id;
                                          //final status=provider.upcoming_Appointment_ResponseClass[index].status;
                                          print(id);
                                          //print(status);
                                          print(provider.upcoming_Appointment_ResponseClass[index].patientId);
                                          _showDialog(id.toString());
                                        }
                                        // setState(() {
                                        //   final _value = newValue; // it gives the value which is selected
                                        // });
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Text("Edit Appointment"),
                                          value: 0,
                                        ),
                                        PopupMenuItem(
                                          child: Text("Cancel Appointment"),
                                          value: 1,
                                        ),

                                      ],
                                    ),
                                    // IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.grey,)),
                                  ],
                                ),
                                SizedBox(
                                    width: 230,
                                    child: Divider(thickness: 1,color: Colors.grey[350],)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          provider.upcoming_Appointment_ResponseClass[index].type==1?Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.clock,size: 15,color: Colors.blueAccent,),
                                              SizedBox(width: 5,),
                                              Text(provider.upcoming_Appointment_ResponseClass[index].newAppoinmentTime.toString(),style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w500),),
                                            ],
                                          ):Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.ticketAlt,size: 15,color: Colors.blueAccent,),
                                              SizedBox(width: 5,),
                                              Text(provider.upcoming_Appointment_ResponseClass[index].tokenNo.toString(),style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w500),),
                                            ],
                                          )
                                        ],
                                      ),Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.userAlt,size: 12,color: Colors.blueAccent,),
                                              SizedBox(width: 5,),
                                              SizedBox(
                                                width: 120,
                                                child: AutoSizeText(
                                                  provider.upcoming_Appointment_ResponseClass[index].patientName.toString(),style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w500),maxLines: 1,),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                )
                              ],

                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                }),
          ),
        ));
      },
    );
  }
  void _showDialog(String id) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Cancel Appointment",style: TextStyle(color: Colors.black),),
          content: new Text("Are you sure that you want to Cancel the Appointment?",style: TextStyle(color: Colors.grey.shade700),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",style: TextStyle(),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),FlatButton(
              child: new Text("Proceed",style: TextStyle(color: Colors.red),),
              onPressed: () {
                provider1.Cancel_Appointment_data(id, 0.toString());
                // Navigator.popAndPushNamed(context, RoutePaths.NoOFAppointment);
              },
            ),
          ],
        );
      },
    );
  }
}
