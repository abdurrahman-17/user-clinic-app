import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/past%20Appointment/past_App_Notifier.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';

class Past_App extends StatefulWidget {
  const Past_App({Key? key}) : super(key: key);

  @override
  State<Past_App> createState() => _Past_AppState();
}

class Choice {
  const Choice({required this.name});
  final String name;
}

const List<Choice> choices = const <Choice>[
  const Choice(name: 'Edit Appointment', ),
  const Choice(name: 'Cancel Appointment', ),
];
class _Past_AppState extends State<Past_App> {
  Past_App_Notifier provider=Past_App_Notifier();
  Choice _selectedOption = choices[0];

  void _select(Choice choice) {
    setState(() {
      _selectedOption = choice;
    });
  }
  String id='';
  @override
  void initState() {
    MySharedPreferences.instance.getid("id").then((value) {
      id=value.toString();
      print(value);
    });
    Future.delayed(Duration.zero,(){
      provider.Past_App_data(id);
      provider.notifyListeners();
    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Past_App_Notifier>(
      builder: (context,provider,_){
        this.provider=provider;
        return ModalProgressHUD(inAsyncCall: provider.isLoading, child: Scaffold(
          backgroundColor: Color(0xffF7F9FC),
          body: provider.past_Appointment_ResponseClass.isEmpty?Center(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.event_busy,color: Colors.grey,size: 80,),
                SizedBox(height: 5,),
                Text('No Appointment',style: TextStyle(fontSize: 18),)
              ],
            ),
          ):Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
                clipBehavior: Clip.none,
                shrinkWrap: true,
                itemCount: provider.past_Appointment_ResponseClass.length,
                itemBuilder: (context,index) {
                  final DateFormat formatters=DateFormat("E-MMMM-yyy");
                  final formatteds=formatters.format(provider.past_Appointment_ResponseClass[index].date!);
                  final DateFormat formatterss=DateFormat("dd-MMMM-yyy");
                  final formattedss=formatterss.format(provider.past_Appointment_ResponseClass[index].date!);
                  final date=formattedss.split('-').first;
                  // final time=provider.past_Appointment_ResponseClass[index].appointmentTime.toString();
                  // var df =  DateFormat("hh:mm");
                  // var dt = df.parse(time);
                  // var times=DateFormat('h:mma').format(dt);
                  //print(times);
                  print(provider.past_Appointment_ResponseClass[index].tokenNo.toString());
                  //print(times);
                  final month=formatteds.split('-');
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
                                              Text(provider.past_Appointment_ResponseClass[index].doctorName.toString(),style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w500),),

                                            ],
                                          ),
                                          SizedBox(height: 3,),

                                          Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.stethoscope,size: 13,color: Colors.blueAccent,),
                                              SizedBox(width: 5,),
                                              Text(provider.past_Appointment_ResponseClass[index].specialist.toString(),style: TextStyle(fontSize: 15,color: Colors.grey),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: provider.past_Appointment_ResponseClass[index].consultation==4?Icon(Icons.cancel_outlined,color: Colors.red,):Icon(Icons.check_circle_outline,color: Colors.green,),
                                    )
                                    // PopupMenuButton<Choice>(
                                    //   onSelected: _select,
                                    //   itemBuilder: (BuildContext context) {
                                    //     return choices.skip(0).map((Choice choice) {
                                    //       return PopupMenuItem<Choice>(
                                    //         value: choice,
                                    //         child: Text(choice.name),
                                    //       );
                                    //     }).toList();
                                    //   },
                                    // ),
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
                                          provider.past_Appointment_ResponseClass[index].tokenNo==null?Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.clock,size: 15,color: Colors.blueAccent,),
                                              SizedBox(width: 5,),
                                              Text(provider.past_Appointment_ResponseClass[index].newAppointmentTime.toString(),style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w500),),
                                            ],
                                          ):Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.ticketAlt,size: 15,color: Colors.blueAccent,),
                                              SizedBox(width: 5,),
                                              Text(provider.past_Appointment_ResponseClass[index].tokenNo.toString(),style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w500),),
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
                                                  child: AutoSizeText(provider.past_Appointment_ResponseClass[index].patientName.toString(),style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w500),maxLines: 1,)),
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
}
