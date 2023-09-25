import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/family_list/family_list_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/filter%20Using%20Name/filter_Using_name_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/get%20report%20filter/get_Report_filter_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/get_report/Get_Report_Notifier.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/pharmacy/pharmacy.dart';

class Health_Record extends StatefulWidget {
  const Health_Record({Key? key}) : super(key: key);

  @override
  _Health_RecordState createState() => _Health_RecordState();
}

class _Health_RecordState extends State<Health_Record> {
  GEt_Report_Notifier provider=GEt_Report_Notifier();
  GEt_Report_Filter_Notifier providerfilter=GEt_Report_Filter_Notifier();
  Get_Filter_Name_Notifier providerfiltername=Get_Filter_Name_Notifier();
  family_List_Notifier familyprovier=family_List_Notifier();
  bool checkedValue=false;
  String id='';
    @override
  void initState() {
      MySharedPreferences.instance.getid("id").then((value) => setState((){
        id=value.toString();
        print('irfan');
        print(id);
      }));
      Future.delayed(Duration.zero,(){
        provider.Get_Report_data(id).then((value) {
          print(provider.get_report_ResponseClass.length);
        });
        provider.notifyListeners();
        familyprovier.family_List_data(id).then((value) {
        });
        familyprovier.notifyListeners();
      });
    // TODO: implement initState
    super.initState();
  }
  DateTime? todayDate = DateTime.now();
    String formatted='';
    int count=0;
    int? length;
    bool filters=false;
    bool filtersname=false;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: todayDate!, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != todayDate) {
      setState(() {
        todayDate = picked;
        final DateFormat format=DateFormat('yyy-MM-dd');
        formatted=format.format(picked);
        print(formatted);
        filtersname=false;
        filters=true;
        filter();

      });
    }
  }
  void filter(){
    Future.delayed(Duration.zero,(){
      providerfilter.Get_Report_filter_data(id, formatted).then((value) {

      });
      providerfilter.notifyListeners();
      length=providerfilter.get_report_filter_ResponseClass.length;
      print(length);
    });
  }
  void filternamesend(String id){
    Future.delayed(Duration.zero,(){
      providerfiltername.Get_Filter_Name_data(id).then((value) {
        print("length");
        length=providerfiltername.get_filter_name_ResponseClass.length;
        print(length);
        // for(int i=0;i<providerfilter.get_report_filter_ResponseClass.length;i++){
        //   print('irfan');
        //   count=providerfilter.get_report_filter_ResponseClass.length;
        //   print(count);
        // }
      });
      providerfiltername.notifyListeners();
      filters=false;
      filtersname=true;
    });
  }
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F6FC),
        body:(filters==true)?buildbody_filter(context):(filtersname==true)?buildbodyfiltername(context):buildbody(context)
        // buildbody(context),
      ),
    );
  }
  Widget setupAlertDialoadContainer() {

    return Container(
      //height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: familyprovier.family_List_ResponseClass.length,
        itemBuilder: (BuildContext context, int index) {
          return  Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: (){
                setState(() {

                  filternamesend(familyprovier.family_List_ResponseClass[index].id.toString());

                  //print(familyprovier.family_List_ResponseClass[index].name.toString());
                  //print(familyprovier.family_List_ResponseClass[index].id.toString());
                });
              Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 5,),
                  Text(familyprovier.family_List_ResponseClass[index].name.toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void _user(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text('Select User'),
            content: setupAlertDialoadContainer(),

          );
        }
    );
  }
  Widget buildbody(BuildContext context){
    return Consumer<GEt_Report_Notifier>(
      builder:(context,provider,_){
        this.provider=provider;
        return ModalProgressHUD(inAsyncCall: provider.isLoading, child:SingleChildScrollView(
          child: Stack(
            children: [
              buildBackground(context),
              Column(
                children: [
                  buildRecord(context),
                  //buildButton(context),
                ],
              ),
            ],
          ),
        ) );
      },
    );
  }

  Widget buildBackground(BuildContext context){
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xff4889FD),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
      ),
    );
  }

  Widget buildRecord(BuildContext context){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            backButton(context),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  PopupMenuButton(
                    child: TextButton.icon(onPressed:null, icon: Icon(Icons.filter_list_outlined,color: Colors.white,), label: Text('Filter By',style: GoogleFonts.roboto(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700))),
                    onSelected: (value) { // add this property
                      if(value==0){
                       _selectDate(context);
                      }else  if(value==1){
                        _user();
                      }
                      // setState(() {
                      //   final _value = newValue; // it gives the value which is selected
                      // });
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Filter By Date"),
                        value: 0,
                      ),
                      PopupMenuItem(
                        child: Text("Filter By User"),
                        value: 1,
                      ),

                    ],
                  )
                  //Icon(Icons.filter_list_outlined,color: Colors.white,),
                  //Text('FILTER',style: GoogleFonts.roboto(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
                ],
              ),
            ),
            Container(
              child:provider.get_report_ResponseClass.isEmpty?Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.25),
                child: Center(
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.file,color: Colors.grey,size: 80,),
                      SizedBox(height: 5,),
                      Text('No Record Available',style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ),
              ): Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.get_report_ResponseClass.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    // print('irfan');
                    // print(provider.get_report_ResponseClass[index].doctorName);
                    // print('irfan');
                    final DateFormat formatter=DateFormat("dd-MM-yyy");
                    final formatted=formatter.format(provider.get_report_ResponseClass[index].bookedDate!);
                    print('irfan');
                    final DateFormat formatters=DateFormat("E-MM-yyy");
                    final formatteds=formatters.format(provider.get_report_ResponseClass[index].bookedDate!);
                    //print(formatteds);
                    final dateValuename = formatteds.split('-').first;
                    //print(dateValuename);
                    final dateValue = formatted.substring(0,2);
                    final monthValue = formatted.substring(3,5);
                    //print(monthValue);
                    var inputFormat = DateFormat('MM');
                    var inputDate = inputFormat.parse(monthValue.toString()); // <-- dd/MM 24H format

                    var outputFormat = DateFormat('MMMM');
                    final outputDate = outputFormat.format(inputDate);
                    //print('irfan'+capitalize(outputDate)); // 12/31/2000 11:5
                    return TimelineTile(
                      indicatorStyle: IndicatorStyle(
                        height: 10,
                        width: 15,
                        color: Color(0xff91b8fe),
                      ),
                      afterLineStyle: LineStyle(color: Colors.grey.shade300,thickness: 3),
                      beforeLineStyle: LineStyle(color: Colors.grey.shade300,thickness: 3),
                      alignment: TimelineAlign.manual,
                      isFirst: index==0,
                      lineXY: 0.2,
                      isLast: index==provider.get_report_ResponseClass.length-1,
                      endChild: Padding(
                        padding: const EdgeInsets.only(top: 40,left: 10,right: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Pharmacy(id: provider.get_report_ResponseClass[index].appointmentId)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow:  [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 10,spreadRadius: 0.5)
                              ],

                              // borderRadius: BorderRadius.circular(11),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: const Color(0xff4889FD).withOpacity(0.6),
                                      width: 8,
                                    ),
                                  ),
                                  boxShadow:  [
                                    BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(0, 4),
                                        blurRadius: 8)
                                  ],
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular(11),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children:  [
                                          Icon(
                                            Icons.person,
                                            color:Color(0xff566CCE),
                                            //Color(0xff4889FD),
                                            size: 22,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(provider.get_report_ResponseClass[index].patientName.toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // Row(
                                      //   children: const [
                                      //     Icon(
                                      //       Icons.calendar_today_rounded,
                                      //       color: Color(0xff4889FD),
                                      //       size: 22,
                                      //     ),
                                      //     SizedBox(
                                      //       width: 10,
                                      //     ),
                                      //     Text(
                                      //       'Jan 8',
                                      //       style: TextStyle(
                                      //         fontSize: 18,
                                      //       ),
                                      //     ),
                                      //     SizedBox(
                                      //       width: 20,
                                      //     ),
                                      //     Icon(
                                      //       Icons.access_time,
                                      //       color: Color(0xff4889FD),
                                      //       size: 22,
                                      //     ),
                                      //     SizedBox(
                                      //       width: 5,
                                      //     ),
                                      //     Text(
                                      //       '11:30:00',
                                      //       style: TextStyle(
                                      //         fontSize: 18,
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      Row(
                                        children:  [
                                          Icon(
                                            Icons.note_add_rounded,
                                            color: Color(0xff566CCE),
                                            //color: Color(0xff4889FD),
                                            size: 22,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(provider.get_report_ResponseClass[index].description.toString(),
                                              //'A medical report is an encompassing and comprehensive report that includes the medical history and details about a person when they have a consultation with a health service provider or when they are admitted to a hospital.',maxLines: 2,overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      startChild: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(outputDate,style: TextStyle(fontSize: 15,color: Colors.grey),),
                              SizedBox(height: 5,),
                              Text(dateValue,style: TextStyle(fontSize: 25,color: Color(0xff566CCE),fontWeight: FontWeight.w500)),
                              SizedBox(height: 5,),
                              Text(dateValuename,style: TextStyle(fontSize: 15,color: Colors.grey)),
                            ],
                          )
                      ),
                    );
                  },
                )

                // ListView.builder
                //   (
                //   physics:NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,itemCount: provider.get_report_ResponseClass.length,
                //     itemBuilder: (context,index){
                //       return Padding(
                //         padding: const EdgeInsets.only(top: 25),
                //         child: GestureDetector(
                //           onTap: (){
                //             Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>Prescription(appointment_id:provider.get_report_ResponseClass[index].appointmentId.toString())));
                //             },
                //           child: Container(
                //             decoration: BoxDecoration(
                //               boxShadow: [BoxShadow(
                //                   color: Colors.black26,
                //                   offset: Offset(0,4),
                //                   blurRadius: 3
                //               )],
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(11),
                //             ),
                //             child:Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 16),
                //                   child: Container(
                //                     height: MediaQuery.of(context).size.height*0.15,
                //                     width: MediaQuery.of(context).size.width*0.15,
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(5),
                //                     ),
                //                     child: provider.get_report_ResponseClass[index].prescription==null?
                //                     FadeInImage.assetNetwork(
                //                       placeholder: 'assets/images/giphy.gif',
                //                       image:'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',fit: BoxFit.fill,
                //                       //'https://www.researchgate.net/publication/345830022/figure/fig4/AS:957640029003789@1605330583881/Sample-prescription-used-as-input-to-the-GUI-developed-in-the-present-work.png',
                //                     ):
                //                     FadeInImage.assetNetwork(
                //                       placeholder: 'assets/images/giphy.gif',
                //                       image:DataConstants.LIVE_BASE_URL+'/'+provider.get_report_ResponseClass[index].prescription.toString(),fit: BoxFit.fill,
                //                       //'https://www.researchgate.net/publication/345830022/figure/fig4/AS:957640029003789@1605330583881/Sample-prescription-used-as-input-to-the-GUI-developed-in-the-present-work.png',
                //                     ),
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 30),
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       SizedBox(height: 15,),
                //                       Text(provider.get_report_ResponseClass[index].doctorName.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 19),),
                //                       SizedBox(height: 10,),
                //                       Text(provider.get_report_ResponseClass[index].description.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.grey),),
                //                       SizedBox(height: 15,),
                //                       Padding(
                //                         padding: const EdgeInsets.only(bottom: 15),
                //                         child: Row(
                //                           children: [
                //                             Icon(Icons.calendar_today,color: Colors.grey,),
                //                             Text(provider.get_report_ResponseClass[index].date.toString(),style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey),),
                //                           ],
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //     }),
              ),
            ),
            //buildButton(context)
          ],)
    );
  }
  // Widget buildButton(BuildContext context){
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 25,bottom: 10,left: 25,top: 10),
  //     child: SizedBox(
  //       height: 50,
  //       width: double.infinity,
  //       child: ElevatedButton(onPressed: (){
  //         Navigator.pop(context);
  //       },
  //           child: Text('Back',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
  //           style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
  //       ),
  //     ),
  //   );
  // }
  Widget backButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,),
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
          padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
          child: Text('Health Record',style:GoogleFonts.roboto(fontSize: 25,color: Colors.white),),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
  Widget buildbodyfiltername(BuildContext context){
    return Consumer<Get_Filter_Name_Notifier>(
      builder:(context,providers,_){
        providerfiltername=providers;
        return ModalProgressHUD(
            inAsyncCall: providers.isLoading,
            child:SingleChildScrollView(
          child: Stack(
            children: [
              buildBackgroundfiltername(context),
              Column(
                children: [
                  buildRecordfiltername(context),
                  //buildButton(context),
                ],
              ),
            ],
          ),
        ) );
      },
    );
  }

  Widget buildBackgroundfiltername(BuildContext context){
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xff4889FD),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
      ),
    );
  }

  Widget buildRecordfiltername(BuildContext context){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            backButtonfltername(context),

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  PopupMenuButton(
                    child: TextButton.icon(onPressed:null, icon: Icon(Icons.filter_list_outlined,color: Colors.white,), label: Text('Filter By',style: GoogleFonts.roboto(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700))),
                    onSelected: (value) { // add this property
                      if(value==0){
                       _selectDate(context);
                      }else  if(value==1){
                        _user();
                      }
                      // setState(() {
                      //   final _value = newValue; // it gives the value which is selected
                      // });
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Select By Date"),
                        value: 0,
                      ),
                      PopupMenuItem(
                        child: Text("Select By User"),
                        value: 1,
                      ),

                    ],
                  )
                  //Icon(Icons.filter_list_outlined,color: Colors.white,),
                  //Text('FILTER',style: GoogleFonts.roboto(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
                ],
              ),
            ),
            providerfiltername.get_filter_name_ResponseClass.isEmpty?Padding(
              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.25),
              child: Center(
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.file,color: Colors.grey,size: 80,),
                    SizedBox(height: 5,),
                    Text('No User Record Found',style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            ):Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: providerfiltername.get_filter_name_ResponseClass.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    print('abdul'+providerfiltername.get_filter_name_ResponseClass.length.toString());
                    // print('irfan');
                    // print(provider.get_report_ResponseClass[index].doctorName);
                    // print('irfan');
                    final DateFormat formatter=DateFormat("dd-MM-yyy");
                    final formatted=formatter.format(providerfiltername.get_filter_name_ResponseClass[index].bookedDate!);
                    // print('irfan');
                    final DateFormat formatters=DateFormat("E-MM-yyy");
                    final formatteds=formatters.format(providerfiltername.get_filter_name_ResponseClass[index].bookedDate!);
                    //print(formatteds);
                    final dateValuename = formatteds.split('-').first;
                    //print(dateValuename);
                    final dateValue = formatted.substring(0,2);
                    final monthValue = formatted.substring(3,5);
                    //print(monthValue);
                    var inputFormat = DateFormat('MM');
                    var inputDate = inputFormat.parse(monthValue.toString()); // <-- dd/MM 24H format

                    var outputFormat = DateFormat('MMMM');
                    final outputDate = outputFormat.format(inputDate);
                    //print('irfan'+capitalize(outputDate)); // 12/31/2000 11:5
                    return TimelineTile(
                      indicatorStyle: IndicatorStyle(
                        height: 10,
                        width: 15,
                        color: Color(0xff91b8fe),
                      ),
                      afterLineStyle: LineStyle(color: Colors.grey.shade300,thickness: 3),
                      beforeLineStyle: LineStyle(color: Colors.grey.shade300,thickness: 3),
                      alignment: TimelineAlign.manual,
                      isFirst: index==0,
                      lineXY: 0.2,
                      isLast: index==providerfiltername.get_filter_name_ResponseClass.length-1,
                      endChild: Padding(
                        padding: const EdgeInsets.only(top: 40,left: 10,right: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Pharmacy(id: provider.get_report_ResponseClass[index].appointmentId)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow:  [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 10,spreadRadius: 0.5)
                              ],

                              // borderRadius: BorderRadius.circular(11),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: const Color(0xff4889FD).withOpacity(0.6),
                                      width: 8,
                                    ),
                                  ),
                                  boxShadow:  [
                                    BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(0, 4),
                                        blurRadius: 8)
                                  ],
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular(11),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children:  [
                                          Icon(
                                            Icons.person,
                                            color:Color(0xff566CCE),
                                            //Color(0xff4889FD),
                                            size: 22,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(providerfiltername.get_filter_name_ResponseClass[index].patientName.toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // Row(
                                      //   children: const [
                                      //     Icon(
                                      //       Icons.calendar_today_rounded,
                                      //       color: Color(0xff4889FD),
                                      //       size: 22,
                                      //     ),
                                      //     SizedBox(
                                      //       width: 10,
                                      //     ),
                                      //     Text(
                                      //       'Jan 8',
                                      //       style: TextStyle(
                                      //         fontSize: 18,
                                      //       ),
                                      //     ),
                                      //     SizedBox(
                                      //       width: 20,
                                      //     ),
                                      //     Icon(
                                      //       Icons.access_time,
                                      //       color: Color(0xff4889FD),
                                      //       size: 22,
                                      //     ),
                                      //     SizedBox(
                                      //       width: 5,
                                      //     ),
                                      //     Text(
                                      //       '11:30:00',
                                      //       style: TextStyle(
                                      //         fontSize: 18,
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      Row(
                                        children:  [
                                          Icon(
                                            Icons.note_add_rounded,
                                            color: Color(0xff566CCE),
                                            //color: Color(0xff4889FD),
                                            size: 22,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(providerfiltername.get_filter_name_ResponseClass[index].description.toString(),
                                              //'A medical report is an encompassing and comprehensive report that includes the medical history and details about a person when they have a consultation with a health service provider or when they are admitted to a hospital.',maxLines: 2,overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      startChild: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(outputDate,style: TextStyle(fontSize: 15,color: Colors.grey),),
                              SizedBox(height: 5,),
                              Text(dateValue,style: TextStyle(fontSize: 25,color: Color(0xff566CCE),fontWeight: FontWeight.w500)),
                              SizedBox(height: 5,),
                              Text(dateValuename,style: TextStyle(fontSize: 15,color: Colors.grey)),
                            ],
                          )
                      ),
                    );
                  },
                )

                // ListView.builder
                //   (
                //   physics:NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,itemCount: provider.get_report_ResponseClass.length,
                //     itemBuilder: (context,index){
                //       return Padding(
                //         padding: const EdgeInsets.only(top: 25),
                //         child: GestureDetector(
                //           onTap: (){
                //             Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>Prescription(appointment_id:provider.get_report_ResponseClass[index].appointmentId.toString())));
                //             },
                //           child: Container(
                //             decoration: BoxDecoration(
                //               boxShadow: [BoxShadow(
                //                   color: Colors.black26,
                //                   offset: Offset(0,4),
                //                   blurRadius: 3
                //               )],
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(11),
                //             ),
                //             child:Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 16),
                //                   child: Container(
                //                     height: MediaQuery.of(context).size.height*0.15,
                //                     width: MediaQuery.of(context).size.width*0.15,
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(5),
                //                     ),
                //                     child: provider.get_report_ResponseClass[index].prescription==null?
                //                     FadeInImage.assetNetwork(
                //                       placeholder: 'assets/images/giphy.gif',
                //                       image:'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',fit: BoxFit.fill,
                //                       //'https://www.researchgate.net/publication/345830022/figure/fig4/AS:957640029003789@1605330583881/Sample-prescription-used-as-input-to-the-GUI-developed-in-the-present-work.png',
                //                     ):
                //                     FadeInImage.assetNetwork(
                //                       placeholder: 'assets/images/giphy.gif',
                //                       image:DataConstants.LIVE_BASE_URL+'/'+provider.get_report_ResponseClass[index].prescription.toString(),fit: BoxFit.fill,
                //                       //'https://www.researchgate.net/publication/345830022/figure/fig4/AS:957640029003789@1605330583881/Sample-prescription-used-as-input-to-the-GUI-developed-in-the-present-work.png',
                //                     ),
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 30),
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       SizedBox(height: 15,),
                //                       Text(provider.get_report_ResponseClass[index].doctorName.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 19),),
                //                       SizedBox(height: 10,),
                //                       Text(provider.get_report_ResponseClass[index].description.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.grey),),
                //                       SizedBox(height: 15,),
                //                       Padding(
                //                         padding: const EdgeInsets.only(bottom: 15),
                //                         child: Row(
                //                           children: [
                //                             Icon(Icons.calendar_today,color: Colors.grey,),
                //                             Text(provider.get_report_ResponseClass[index].date.toString(),style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey),),
                //                           ],
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //     }),
              ),
            ),
            //buildButton(context)
          ],)
    );
  }
  // Widget buildButton(BuildContext context){
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 25,bottom: 10,left: 25,top: 10),
  //     child: SizedBox(
  //       height: 50,
  //       width: double.infinity,
  //       child: ElevatedButton(onPressed: (){
  //         Navigator.pop(context);
  //       },
  //           child: Text('Back',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
  //           style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
  //       ),
  //     ),
  //   );
  // }
  Widget backButtonfltername(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,),
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
          padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
          child: Text('Health Record',style:GoogleFonts.roboto(fontSize: 25,color: Colors.white),),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
  Widget buildbody_filter(BuildContext context){
    return Consumer<GEt_Report_Filter_Notifier>(
      builder: (context,provider,_) {
        this.providerfilter=provider;
       return ModalProgressHUD(inAsyncCall: provider.isLoading, child:
       SingleChildScrollView(
         child: Stack(
           children: [
             buildBackground_filter(context),
             Column(
               children: [
                 buildRecord_filter(context),
                 //buildButton(context),
               ],
             ),
           ],
         ),
       ), );
      }

    );
  }
  Widget buildBackground_filter(BuildContext context){
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xff4889FD),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
      ),
    );
  }
  Widget buildRecord_filter(BuildContext context){
    return Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            backButton_filter(context),
            //1Text('Health Record',style:GoogleFonts.roboto(fontSize: 35,color: Colors.white,fontWeight: FontWeight.w700),),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  PopupMenuButton(
                    child: TextButton.icon(onPressed:null, icon: Icon(Icons.filter_list_outlined,color: Colors.white,), label: Text('Filter By',style: GoogleFonts.roboto(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700))),
                    onSelected: (value) { // add this property
                      if(value==0){
                        _selectDate(context);
                      }else  if(value==1){
                        _user();
                      }
                      // setState(() {
                      //   final _value = newValue; // it gives the value which is selected
                      // });
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Select By Date"),
                        value: 0,
                      ),
                      PopupMenuItem(
                        child: Text("Select By User"),
                        value: 1,
                      ),

                    ],
                  )
                  //Icon(Icons.filter_list_outlined,color: Colors.white,),
                  //Text('FILTER',style: GoogleFonts.roboto(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
                ],
              ),
            ),
            providerfilter.get_report_filter_ResponseClass.isEmpty?Padding(
              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.25),
              child: Center(
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.file,color: Colors.grey,size: 80,),
                    SizedBox(height: 5,),
                    Text('No Record Available in date',style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            ):
            Container(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: providerfilter.message==' No record found '?
                  Text('No Data Found'):
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: providerfilter.get_report_filter_ResponseClass.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      // print('irfan');
                      // print(provider.get_report_ResponseClass[index].doctorName);
                      // print('irfan');
                      final DateFormat formatter=DateFormat("dd-MM-yyy");
                      final formatted=formatter.format(providerfilter.get_report_filter_ResponseClass[index].bookedDate!);
                      print('irfan');
                      final DateFormat formatters=DateFormat("E-MM-yyy");
                      final formatteds=formatters.format(providerfilter.get_report_filter_ResponseClass[index].bookedDate!);
                      //print(formatteds);
                      final dateValuename = formatteds.split('-').first;
                      //print(dateValuename);
                      final dateValue = formatted.substring(0,2);
                      final monthValue = formatted.substring(3,5);
                      //print(monthValue);
                      var inputFormat = DateFormat('MM');
                      var inputDate = inputFormat.parse(monthValue.toString()); // <-- dd/MM 24H format

                      var outputFormat = DateFormat('MMMM');
                      final outputDate = outputFormat.format(inputDate);
                      //print('irfan'+capitalize(outputDate)); // 12/31/2000 11:5
                      return TimelineTile(
                        indicatorStyle: IndicatorStyle(
                          height: 15,
                          width: 15,
                          color: Color(0xff91b8fe),
                        ),
                        afterLineStyle: LineStyle(color: Colors.grey.shade300,thickness: 3),
                        beforeLineStyle: LineStyle(color: Colors.grey.shade300,thickness: 3),
                        alignment: TimelineAlign.manual,
                        isFirst: index==0,
                        lineXY: 0.2,
                        isLast: index==providerfilter.get_report_filter_ResponseClass.length-1,
                        endChild: Padding(
                          padding: const EdgeInsets.only(top: 40,left: 10,right: 10),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Pharmacy(id: provider.get_report_ResponseClass[index].appointmentId)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow:  [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(2, 2),
                                      blurRadius: 10,spreadRadius: 0.5)
                                ],

                                // borderRadius: BorderRadius.circular(11),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: const Color(0xff4889FD).withOpacity(0.6),
                                        width: 8,
                                      ),
                                    ),
                                    boxShadow:  [
                                      BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(0, 4),
                                          blurRadius: 8)
                                    ],
                                    color: Colors.white,
                                    // borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children:  [
                                            Icon(
                                              Icons.person,
                                              color:Color(0xff566CCE),
                                              //Color(0xff4889FD),
                                              size: 22,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(providerfilter.get_report_filter_ResponseClass[index].patientName!,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // Row(
                                        //   children: const [
                                        //     Icon(
                                        //       Icons.calendar_today_rounded,
                                        //       color: Color(0xff4889FD),
                                        //       size: 22,
                                        //     ),
                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     Text(
                                        //       'Jan 8',
                                        //       style: TextStyle(
                                        //         fontSize: 18,
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 20,
                                        //     ),
                                        //     Icon(
                                        //       Icons.access_time,
                                        //       color: Color(0xff4889FD),
                                        //       size: 22,
                                        //     ),
                                        //     SizedBox(
                                        //       width: 5,
                                        //     ),
                                        //     Text(
                                        //       '11:30:00',
                                        //       style: TextStyle(
                                        //         fontSize: 18,
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        Row(
                                          children:  [
                                            Icon(
                                              Icons.note_add_rounded,
                                              color: Color(0xff566CCE),
                                              //color: Color(0xff4889FD),
                                              size: 22,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Text(providerfilter.get_report_filter_ResponseClass[index].description??'not mentioned',
                                                //'A medical report is an encompassing and comprehensive report that includes the medical history and details about a person when they have a consultation with a health service provider or when they are admitted to a hospital.',maxLines: 2,overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        startChild: Container(
                            padding: EdgeInsets.only(left: 5,right: 5,top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(outputDate,style: TextStyle(fontSize: 15,color: Colors.grey),),
                                SizedBox(height: 5,),
                                Text(dateValue,style: TextStyle(fontSize: 35,color: Color(0xff566CCE),fontWeight: FontWeight.w500)),
                                SizedBox(height: 5,),
                                Text(dateValuename,style: TextStyle(fontSize: 15,color: Colors.grey)),
                              ],
                            )
                        ),
                      );
                    },
                  )
                // ListView.builder
                //   (
                //   physics:NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,itemCount: provider.get_report_ResponseClass.length,
                //     itemBuilder: (context,index){
                //       return Padding(
                //         padding: const EdgeInsets.only(top: 25),
                //         child: GestureDetector(
                //           onTap: (){
                //             Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>Prescription(appointment_id:provider.get_report_ResponseClass[index].appointmentId.toString())));
                //             },
                //           child: Container(
                //             decoration: BoxDecoration(
                //               boxShadow: [BoxShadow(
                //                   color: Colors.black26,
                //                   offset: Offset(0,4),
                //                   blurRadius: 3
                //               )],
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(11),
                //             ),
                //             child:Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 16),
                //                   child: Container(
                //                     height: MediaQuery.of(context).size.height*0.15,
                //                     width: MediaQuery.of(context).size.width*0.15,
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(5),
                //                     ),
                //                     child: provider.get_report_ResponseClass[index].prescription==null?
                //                     FadeInImage.assetNetwork(
                //                       placeholder: 'assets/images/giphy.gif',
                //                       image:'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',fit: BoxFit.fill,
                //                       //'https://www.researchgate.net/publication/345830022/figure/fig4/AS:957640029003789@1605330583881/Sample-prescription-used-as-input-to-the-GUI-developed-in-the-present-work.png',
                //                     ):
                //                     FadeInImage.assetNetwork(
                //                       placeholder: 'assets/images/giphy.gif',
                //                       image:DataConstants.LIVE_BASE_URL+'/'+provider.get_report_ResponseClass[index].prescription.toString(),fit: BoxFit.fill,
                //                       //'https://www.researchgate.net/publication/345830022/figure/fig4/AS:957640029003789@1605330583881/Sample-prescription-used-as-input-to-the-GUI-developed-in-the-present-work.png',
                //                     ),
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 30),
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       SizedBox(height: 15,),
                //                       Text(provider.get_report_ResponseClass[index].doctorName.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 19),),
                //                       SizedBox(height: 10,),
                //                       Text(provider.get_report_ResponseClass[index].description.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.grey),),
                //                       SizedBox(height: 15,),
                //                       Padding(
                //                         padding: const EdgeInsets.only(bottom: 15),
                //                         child: Row(
                //                           children: [
                //                             Icon(Icons.calendar_today,color: Colors.grey,),
                //                             Text(provider.get_report_ResponseClass[index].date.toString(),style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey),),
                //                           ],
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //     }),
              ),
            ),
            //buildButton_filter(context)
          ],)
    );
  }
  // Widget buildButton_filter(BuildContext context){
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 25,bottom: 10,left: 25,top: 10),
  //     child: SizedBox(
  //       height: 50,
  //       width: double.infinity,
  //       child: ElevatedButton(onPressed: (){
  //         Navigator.pop(context);
  //       },
  //           child: Text('Back',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
  //           style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
  //       ),
  //     ),
  //   );
  // }
  Widget backButton_filter(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,),
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
          padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
          child: Text('Health Record',style:GoogleFonts.roboto(fontSize: 25,color: Colors.white),),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
}
