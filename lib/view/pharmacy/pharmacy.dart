import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/Pharmacy/Pharmacy_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/view/Prescription/prescription.dart';
import 'package:user_clinic_token_app/view/health_record/Health_Record.dart';
import 'package:user_clinic_token_app/view/preview%20image/preview_Image.dart';

class Pharmacy extends StatefulWidget {
  final id;
   Pharmacy({Key? key, required this.id}) : super(key: key);

  @override
  _PharmacyState createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
  Pharmacy_Notifier provider=Pharmacy_Notifier();

  String name="";
  String heartbeat="";
  String temperature="";
  String blood_pressure="";
  String Diabetes="";
  String weight="";
  String height="";
  String spo2="";
  String? savePath;

  List<String> imageList = [
    'https://www.researchgate.net/profile/Sandra-Benavides/publication/228331607/figure/fig4/AS:667613038387209@1536182760366/Indicate-why-the-prescription-is-not-appropriate-as-written.png',
    'data:image/png;base64,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',
  ];

  List<String> imagename=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 Future.delayed(Duration.zero,() {
   provider.Get_Appointment(widget.id.toString()).then((value) {
     provider.notifyListeners();
     for (int i = 0; i < provider.pharmacy_class_ResponseClass.length; i++) {
       name = provider.pharmacy_class_ResponseClass[i].doctorName.toString();
       //print(name);
       heartbeat =
           provider.pharmacy_class_ResponseClass[i].pulseRate.toString();
       temperature =
           provider.pharmacy_class_ResponseClass[i].temperature.toString();
       blood_pressure =
           provider.pharmacy_class_ResponseClass[i].bloodPressure.toString();
       Diabetes = provider.pharmacy_class_ResponseClass[i].diabetes.toString();
       weight = provider.pharmacy_class_ResponseClass[i].weight.toString();
       height = provider.pharmacy_class_ResponseClass[i].height.toString();
       spo2 = provider.pharmacy_class_ResponseClass[i].spo2.toString();
       imagename=provider.pharmacy_class_ResponseClass[i].prescription!;
       //imagename=imageList
     }
     // provider.Get_Appointment(widget.id.toString());
     // provider.notifyListeners();
     // for(int i=0;i<provider.pharmacy_class_ResponseClass.length;i++){
     //   name=provider.pharmacy_class_ResponseClass[i].patientName.toString();
     //   print(name);
     //   heartbeat=provider.pharmacy_class_ResponseClass[i].heartBeat.toString();
     //   temperature=provider.pharmacy_class_ResponseClass[i].temperature.toString();
     //   blood_pressure=provider.pharmacy_class_ResponseClass[i].bloodPressure.toString();
     //   Diabetes=provider.pharmacy_class_ResponseClass[i].diabetes.toString();
     // }
   });
   print('irfan');
   print(imageList);
   imageList.forEach((element) {
     setState(() {
       imagename.add(element.split('/').last);
     });
   });
   print(imagename);
 });
  }
  @override
  Widget build(BuildContext context) {
    if(kReleaseMode){}
    return Consumer<Pharmacy_Notifier>(
      builder: (context,provider,_){
        this.provider=provider;
        return ModalProgressHUD(inAsyncCall: provider.isLoading, child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xffF7F9FC),
            body: buildBody(context),
          ),
        ));
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Positioned(
            top: -15,
            right: -30,
            child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.black.withOpacity(0.05),
                child: SvgPicture.asset(
                  'assets/images/Vector.svg',
                  color: Colors.white.withOpacity(0.1),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backButton(context),
                //buildGoodmornTitle(context),
                buildGridview(context),
                buildYourDailyMedication(context),
                buildbloodPandDaibetes(context),
                buildScheduled_Activities_Title(context),
                buildScheduled_Activities_card(context),
                //buildButton(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildGoodmornTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
        ),
        // Text(
        //   'Good Morning',
        //   style: GoodmornTitle(context),
        // ),
      ],
    );
  }

  Widget buildGridview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: GridView.count(
        crossAxisSpacing: 15,
        shrinkWrap: true,
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xffA1ECBF),
                borderRadius: BorderRadius.circular(11)),
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  left: -10,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black.withOpacity(0.05),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/HeartBeat.svg'),
                      SizedBox(width: 8,),
                      Text('Heartbeat',style: Heartbeatstyle(context),)

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(heartbeat,style: Tempstyle(context),),
                      Text('bpm',style: Bpmstyle(context),)
                    ],
                  ),
                ),
              ],
            ),

          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xffFFDA7A),
                borderRadius: BorderRadius.circular(11)),
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  left: -10,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black.withOpacity(0.05),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/carbon_temperature-feels-like.svg'),
                      SizedBox(width: 8,),
                      Text('Temperature',style: Heartbeatstyle(context),)

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(temperature,style: Tempstyle(context),),
                      Text('°F',style: Fahrenheitestyle(context),)
                    ],
                  ),
                ),
              ],
            ),

          )      ],
      ),
    );
  }
  Widget buildYourDailyMedication(BuildContext context){
    return
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text('Health Details',style: YoudailyMedicationstyle(context),),
      );
  }
  Widget buildbloodPandDaibetes(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                    color: Colors.white
                ),
                height: 130,
                width: 250,
                child: Stack(
                  children: [
                  Positioned(
                  top: -10,
                  left: -10,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xff3EC6FF).withOpacity(0.10),
                  ),
                ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/Blood Drop.svg',height: 28,width: 18,),
                                Spacer(),
                                //Text('8-9 AM',style: bloodpressureTimestyle(context),)
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,top: 20),
                          child: Text('Blood Pressure',style: bloodpressureTitlestyle(context),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: RichText(text: TextSpan(text: blood_pressure,style: GoogleFonts.lato(color: Color(0xff486581),fontWeight: FontWeight.w600,fontSize: 17),
                          children:[
                            TextSpan(text: '  mm/Hg',style: GoogleFonts.lato(color: Color(0xff486581),fontWeight: FontWeight.w300,fontSize: 17))
                          ]

                          ),),
                        )
                      ],
                    )
          ],
        )
        ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white
                  ),
                  height: 130,
                  width: 250,
                  child: Stack(
                    children: [
                      Positioned(
                        top: -10,
                        left: -10,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xff3EC6FF).withOpacity(0.10),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/blood pressure.svg',height: 28,width: 18,),
                                Spacer(),
                                //Text('8-9 AM',style: bloodpressureTimestyle(context),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20),
                            child: Text('Diabetes',style: bloodpressureTitlestyle(context),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: RichText(text: TextSpan(text: Diabetes,style: GoogleFonts.lato(color: Color(0xff486581),fontWeight: FontWeight.w600,fontSize: 17),
                                children:[
                                  TextSpan(text: '  mg/dl',style: GoogleFonts.lato(color: Color(0xff486581),fontWeight: FontWeight.w300,fontSize: 17))
                                ]

                            ),),
                          )
                        ],
                      )
                    ],
                  )
              ),
            ),Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white
                  ),
                  height: 130,
                  width: 250,
                  child: Stack(
                    children: [
                      Positioned(
                        top: -10,
                        left: -10,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xff3EC6FF).withOpacity(0.10),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/mainscreen/pulse-oximeter.svg',height: 28,width: 18,color: Color(0xff3b7afd) ,),
                                // Spacer(),
                                // Text('8-9 AM',style: bloodpressureTimestyle(context),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20),
                            child: Text('Spo2',style: bloodpressureTitlestyle(context),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: RichText(text: TextSpan(text: spo2,style: GoogleFonts.lato(color: Color(0xff486581),fontWeight: FontWeight.w600,fontSize: 17),
                                children:[
                                  TextSpan(text: '  %',style: GoogleFonts.lato(color: Color(0xff486581),fontWeight: FontWeight.w300,fontSize: 17))
                                ]

                            ),),
                          )
                        ],
                      )
                    ],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white
                  ),
                  height: 130,
                  width: 250,
                  child: Stack(
                    children: [
                      Positioned(
                        top: -10,
                        left: -10,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xff3EC6FF).withOpacity(0.10),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                            child: Row(
                              children: [
                                Icon(Icons.monitor_weight_outlined,color: Color(0xff3b7afd),size: 30,)
                                //SvgPicture.asset('assets/images/blood pressure.svg',height: 28,width: 18,),
                                // Spacer(),
                                // Text('8-9 AM',style: bloodpressureTimestyle(context),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20),
                            child: Text('Weight',style: bloodpressureTitlestyle(context),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: RichText(text: TextSpan(text: weight,style: GoogleFonts.lato(color: Color(0xff486581),fontWeight: FontWeight.w600,fontSize: 17),
                                children:[
                                  TextSpan(text: '  Kg',style: GoogleFonts.lato(color: Color(0xff486581),fontWeight: FontWeight.w300,fontSize: 17))
                                ]

                            ),),
                          )
                        ],
                      )
                    ],
                  )
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white
                ),
                height: 130,
                width: 250,
                child: Stack(
                  children: [
                    Positioned(
                      top: -10,
                      left: -10,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xff3EC6FF).withOpacity(0.10),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                          child: Row(
                            children: [
                              Icon(Icons.height_outlined,color: Color(0xff3b7afd),size: 30,)
                              // Spacer(),
                              // Text('8-9 AM',style: bloodpressureTimestyle(context),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,top: 20),
                          child: Text('Height',style: bloodpressureTitlestyle(context),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: RichText(text: TextSpan(text: height,style: GoogleFonts.lato(color: Color(0xff486581),fontWeight: FontWeight.w600,fontSize: 17),
                              children:[
                                TextSpan(text: '  cm',style: GoogleFonts.lato(color: Color(0xff486581),fontWeight: FontWeight.w300,fontSize: 17))
                              ]

                          ),),
                        )
                      ],
                    )
                  ],
                )
            )
        ]),
      ),
    );
  }
  Widget buildScheduled_Activities_Title(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text('Your daily medications',style: YoudailyMedicationstyle(context),),
    );
  }
  Widget buildScheduled_Activities_card(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext Context) =>
                  PhotoViewDemo(images: imagename)));},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white
                ),
                height: 85,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: -20,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xffFFDA7A).withOpacity(0.10),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/medication 1.svg',height: 30,width: 20,),
                            ],
                          ),
                        ),
                        Text('Prescription',style: healthRecordstyle(context),),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.image,color: Colors.blueAccent,),

                          // async {
                          //   Map<Permission, PermissionStatus> statuses =
                          //   await [
                          //     Permission.manageExternalStorage,
                          //     Permission.storage,
                          //     Permission.accessMediaLocation,
                          //
                          //     //add more permission to request here.
                          //   ].request();
                          //
                          //   if (statuses[Permission.storage]!.isGranted &&
                          //       statuses[Permission.accessMediaLocation]!
                          //           .isGranted &&
                          //       statuses[Permission.manageExternalStorage]!
                          //           .isGranted) {
                          //     if (await statuses[Permission.storage]!
                          //         .isGranted) {
                          //       directory =
                          //       await getExternalStorageDirectory();
                          //       String newPath = "";
                          //       print(directory);
                          //       List<String> paths =
                          //       directory!.path.split("/");
                          //       for (int x = 1; x < paths.length; x++) {
                          //         String folder = paths[x];
                          //         if (folder != "Android") {
                          //           newPath += "/" + folder;
                          //         } else {
                          //           break;
                          //         }
                          //       }
                          //       newPath = newPath + "/UserClinicAPP";
                          //       directory = Directory(newPath);
                          //       print('irfan');
                          //       print(directory);
                          //     } else {
                          //       return null;
                          //     }
                          //
                          //     //var dir = await DownloadsPathProvider.downloadsDirectory;
                          //     if (directory != null) {
                          //       List savename = imagename;
                          //       savePath = directory!.path + "/$savename";
                          //       print(savePath);
                          //       //output:  /storage/emulated/0/Download/banner.png
                          //         imageList.forEach((element) async {
                          //           final element1=element.split('/').last;
                          //           try {
                          //             await Dio().download(
                          //                 element,
                          //                 element1,
                          //                 // onReceiveProgress: (received, total) {
                          //                 //   if (total != -1) {
                          //                 //     print((received / total * 100)
                          //                 //         .toStringAsFixed(0) +
                          //                 //         "%");
                          //                 //     //you can build progressbar feature too
                          //                 //   }
                          //                 // }
                          //                 );
                          //             print(
                          //                 "File is saved to download folder.");
                          //           } on DioError catch (e) {
                          //             print(e.message);
                          //           }
                          //
                          //         });
                          //
                          //       // imageList.forEach((element) async {
                          //       //   try {
                          //       //     await Dio().download(
                          //       //         element,
                          //       //         savePath,
                          //       //         onReceiveProgress: (received, total) {
                          //       //           if (total != -1) {
                          //       //             print((received / total * 100)
                          //       //                 .toStringAsFixed(0) +
                          //       //                 "%");
                          //       //             //you can build progressbar feature too
                          //       //           }
                          //       //         });
                          //       //     print(
                          //       //         "File is saved to download folder.");
                          //       //   } on DioError catch (e) {
                          //       //     print(e.message);
                          //       //   }
                          //       //
                          //       // });
                          //       // try {
                          //       //   await Dio().download(
                          //       //      imageList,
                          //       //       savePath,
                          //       //       onReceiveProgress: (received, total) {
                          //       //         if (total != -1) {
                          //       //           print((received / total * 100)
                          //       //               .toStringAsFixed(0) +
                          //       //               "%");
                          //       //           //you can build progressbar feature too
                          //       //         }
                          //       //       });
                          //       //   print(
                          //       //       "File is saved to download folder.");
                          //       // } on DioError catch (e) {
                          //       //   print(e.message);
                          //       // }
                          //     }
                          //   } else {
                          //     print("No permission to read and write.");
                          //   }
                          //   // setState(() {
                          //   //   imageblur = true;
                          //   // });
                          // },

                        )
                      ],
                    )
                  ],
                )
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 20),
          //   child: Container(
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(11),
          //           color: Colors.white
          //       ),
          //       height: 85,
          //       width: double.infinity,
          //       child: Stack(
          //         alignment: Alignment.center,
          //         children: [
          //           Positioned(
          //             left: -20,
          //             child: CircleAvatar(
          //               radius: 55,
          //               backgroundColor: Color(0xff3EC6FF).withOpacity(0.10),
          //             ),
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.only(left: 20),
          //                 child: Row(
          //                   children: [
          //                     SvgPicture.asset('assets/images/medication 1.svg',height: 40,width: 40,),
          //                   ],
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(left: 60),
          //                 child: Text('Medication History',style: healthRecordstyle(context),),
          //               ),
          //             ],
          //           )
          //         ],
          //       )
          //   ),
          // )
        ],
      ),
    );

  }
  Widget buildButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,top: 20),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
          child: Text(name,
              style: TextStyle(fontSize: 25,color: Colors.white)
            //style: GoodmornTitle(context),
          ),
        ),
        SizedBox(width: 20,)
      ],
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff4889FD);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 1.9, 250.0, size.width, 145)
      ..relativeLineTo(0, -185)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
