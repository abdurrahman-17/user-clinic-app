import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/no%20Image/no_Image_Response_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/profile/dr_profile_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/profile/profile_notifer.dart';
import 'package:user_clinic_token_app/view/appointment_page/Appointment_page.dart';
import 'package:user_clinic_token_app/view/token_appointment_new/Token_Appointment_New.dart';

class DrProfile extends StatefulWidget {
  final selected;
  final type;
  DrProfile({Key? key, required this.selected,required this.type}) : super(key: key);

  @override
  _DrProfileState createState() => _DrProfileState();
}

class _DrProfileState extends State<DrProfile> {
  DrProfileNotifier provider= DrProfileNotifier();
  No_Image no_imageprovider=No_Image();

  String drname = '';
  String drdegree = '';
  String drimage = '';
  String nodrimage = '';
  String patient = '';
  String exp = '';
  String speciality = '';
  String about_doctor = '';
  String type = '';
  String address = '';
  String day = '';
  String from_time = '';
  String to_time = '';
  int? id;
  //String image='';
  @override
  void initState() {
      print(widget.type);
      print(widget.selected);
      Future.delayed(Duration.zero,(){
        no_imageprovider.getNo_Image().then((value){
          print(no_imageprovider.no_ImageResponseClass);
        });
        no_imageprovider.notifyListeners();
      });
      Future.delayed(Duration.zero,(){
        provider.getDrProfile(widget.selected).then((value) {
          provider.notifyListeners();
        for(int i=0;i<provider.drProfileResponseClass.length;i++){
          print("hi");
          drname=provider.drProfileResponseClass[i].name.toString();
          drdegree=provider.drProfileResponseClass[i].degree.toString();
          drimage=provider.drProfileResponseClass[i].image.toString();
          patient=provider.drProfileResponseClass[i].patientAttend.toString();
          exp=provider.drProfileResponseClass[i].experience.toString();
          speciality=provider.drProfileResponseClass[i].specialist.toString();
          about_doctor=provider.drProfileResponseClass[i].about.toString();
          address=provider.drProfileResponseClass[i].clinicAddress.toString();
          id=provider.drProfileResponseClass[i].id;
          print(provider.drProfileResponseClass[i].name.toString());
          print("hlkijki");
          print(provider.drProfileResponseClass[i].experience.toString());
          print("saad");
          print(provider.drProfileResponseClass[i].specialist.toString());
                  }
          day=provider.doctor_timeResponseClass.days.toString();
          from_time=provider.doctor_timeResponseClass.fromTime.toString();
          to_time=provider.doctor_timeResponseClass.toTime.toString();
          print(day);
          print(from_time);
          print(to_time);
    //api();
    });


    });

    // for(int i=0;i<provider.DrProfileResponseClass.length;i++){
    //   APInames=provider.DrProfileResponseClass[i].name.toString();
    //   print('irfan');
    //   print(provider.drProfileResponseClass[i].name.toString());
    //   print('abdul');
    //   print(provider.DrProfileResponseClass[i].name.toString());
    //
    // }

    super.initState();
    // apiname();

    /*final profile_notifier =
    Provider.of<Profile_Notifier>(context, listen: false);
    profile_notifier.DrProfile_notifier(widget.selected);
    profile_notifier.getPostData(context);
    print('irfan');
    //print(profile_notifier.getdoctor_id.data![0].name);
    print((widget.selected));
    print('irfan');*/
    // MySharedPreferences.instance.getDrname("drname").then((value) => setState((){
    //   drname=value;
    //   print(drname);
    //}));

  }

//   void apiname(){
//     provider.getDrProfile(widget.selected).then((value) {
//       provider.notifyListeners();
//       for(int i=0;i<provider.drProfileResponseClass.length;i++){
//         print("hi");
//         print(provider.drProfileResponseClass[i].name.toString());
//       }
//
//     });
// }


  // void api(){
  //   for(int i=0;i<provider.DrProfileResponseClass.length;i++){
  //     APInames=provider.DrProfileResponseClass[i].name.toString();
  //     print('irfan');
  //     print(provider.drProfileResponseClass[i].name.toString());
  //     print('abdul');
  //     print(provider.DrProfileResponseClass[i].name.toString());
  //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<DrProfileNotifier>(
      builder: (context, provider, _) {
        this.provider = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            // appBar: PreferredSize(
            //   preferredSize: Size.fromHeight(60),
            //   child: buildAppBar(context),
            // ),
            body: buildBody(context),
          ),
        );
      },
    );
  }

  // Widget buildAppBar(BuildContext context) {
  //   return AppBar(
  //     elevation: 0,
  //     flexibleSpace: Container(
  //       decoration: const BoxDecoration(
  //         gradient: LinearGradient(
  //             begin: Alignment.bottomCenter,
  //             end: Alignment.topCenter,
  //             colors: <Color>[Color(0xffFFFFFF), Color(0xffFCFAFA)]),
  //       ),
  //     ),
  //     leading: Padding(
  //       padding: const EdgeInsets.all(5),
  //       child: Container(
  //
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             color: Colors.grey.withOpacity(0.3),
  //           ),
  //           borderRadius: BorderRadius.circular(25),
  //         ),
  //         child: IconButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           icon: Padding(
  //             padding: const EdgeInsets.only(left: 6.0),
  //             child: Icon(
  //               Icons.arrow_back_ios,
  //               color: Colors.black,size: 20,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //
  //     centerTitle: true,
  //   );
  // }

  Widget buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  backButton(context),
                  buildFirstHalfScreen(context),
                  buildSecondHalfScreen(context),
                  Expanded(child: Container()),
                  buildBooking_page(context),
                ],
              ),
            ),
          ),
        );
      }
      );
    //   child:
    // );
  }
  Widget backButton(context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: 15,bottom: 60),
      child: Row(
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

  Widget buildFirstHalfScreen(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffFFFFFF).withOpacity(1),
                Color(0xffFCFAFA).withOpacity(1)
              ]),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15))),
      child: Column(
        children: [
          buildProfilePicture(context),
          buildDrNameAndDepartment(context),
          buildPES(context),
          //buildPER(context),
          // SizedBox(
          //   height: 20,
          // )
        ],
      ),
    );
  }

  Widget buildProfilePicture(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: CachedNetworkImage(
              fit: BoxFit.fill,
              width: 100,
              height: 100,
              placeholder: (context, url) =>
                  Image.asset('assets/images/giphy.gif'),
              imageUrl:
              drimage=="null"?DataConstants.LIVE_BASE_URL+'/'+no_imageprovider.no_ImageResponseClass:
              DataConstants.LIVE_BASE_URL+'/'+drimage,
                  //"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRLe5PABjXc17cjIMOibECLM7ppDwMmiDg6Dw&usqp=CAU"
          ),
        ),
      ),
    );
  }

  Widget buildDrNameAndDepartment(BuildContext context) {

    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(//profile_notifier.getdoctor_id.data![0].name.toString(),
              'Dr. '+drname,
              // 'irfan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 4,),Text(//profile_notifier.getdoctor_id.data![0].name.toString(),
               drdegree,
              // 'irfan',
              style: TextStyle(fontSize: 14,color: Colors.grey),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        //Text('Viralogist',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Color(0xff6B779A)),)
      ],
    );
  }
  Widget buildPES(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color(0xff7ACEFA).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.people_alt_outlined,
                      color: Color(0xff7ACEFA),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(patient+'+'),
                        SizedBox(
                          height: 5,
                        ),
                        Text('patients'),

                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color(0xffFDF1F3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        height: 20,
                        width:20 ,
                        child: SvgPicture.asset('assets/images/exp.svg',height: 20,width: 20,fit: BoxFit.scaleDown,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(exp+' Yrs'),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Experience'),

                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Color(0xffFEF6EC),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(child: FaIcon(FontAwesomeIcons.stethoscope,color: Colors.orangeAccent,)),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(speciality),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget buildPER(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 4 / 5,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 15,
        shrinkWrap: true,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff7ACEFA).withOpacity(0.15),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 30, left: 12, right: 12, bottom: 10),
                    child: Icon(
                      Icons.people_alt_outlined,
                      color: Color(0xff7ACEFA),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(patient+'+'),
                    SizedBox(
                      height: 5,
                    ),
                    Text('patients'),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffFDF1F3),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 12, right: 12, bottom: 10),
                    child: Image.asset('assets/images/icon.png'),
                  ),
                ),
                Column(
                  children: [
                    Text(exp+' Yrs'),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Experience'),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffFEF6EC).withOpacity(0.15),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 12, right: 12, bottom: 10),
                    child: SvgPicture.asset('assets/images/doctorsthetoscope.svg'),

                    ),
                  ),
                Column(
                  children: [
                    Text(speciality,textAlign: TextAlign.center,),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Specialist'),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSecondHalfScreen(BuildContext context) {
    return Column(
      children: [
        buildAboutDoctor(context),
        buildWorkingTime(context),
        buildAddress(context),
        //buildCommunication(context),

      ],
    );
  }

  Widget buildAboutDoctor(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'About Doctor',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            about_doctor,
            // 'Dr. Bellamy Nicholas is a top specialist at London Bridge Hospital at London. He has achieved several awards and recognition for is contribution and service in his own field. He is available for private consultation. ',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xff6B779A)),
            maxLines: 8,
          )
        ],
      ),
    );
  }

  Widget buildWorkingTime(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Working Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              day.toUpperCase()+'  ('+(from_time+' '+'-'+' '+to_time)+')',
              //'Mon - Sat (08:30 AM - 09:00 PM)',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xff6B779A)),
            )
          ],
        ),
      ),
    );
  }


  Widget buildCommunication(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Communication',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          ListTile(
            leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xffEDA1AB).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.textsms_rounded,
                  color: Color(0xffEDA1AB),
                )),
            title: Text(
              'Messaging',
              style: TextStyle(
                  color: Color(0xff222B45),
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            subtitle: Text(
              'Chat me up, share photos.',
              style: TextStyle(
                  color: Color(0xff6B779A),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xff7ACEFA).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.call,
                  color: Color(0xff7ACEFA),
                )),
            title: Text(
              'Audio Call',
              style: TextStyle(
                  color: Color(0xff222B45),
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            subtitle: Text(
              'Call your doctor directly.',
              style: TextStyle(
                  color: Color(0xff6B779A),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xffF7C480).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.videocam,
                  color: Color(0xffF7C480),
                )),
            title: Text(
              'Video Call',
              style: TextStyle(
                  color: Color(0xff222B45),
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            subtitle: Text(
              'See your doctor live.',
              style: TextStyle(
                  color: Color(0xff6B779A),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
  Widget buildAddress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
              SizedBox(
                height: 12,
              ),
              Text(address,style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xff6B779A)),),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Widget buildBooking_page(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, bottom: 20, left: 25),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              widget.type=="2"?Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Toke_Appointment_New())):Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => New_appointment(id:id!)));
            },
            child:widget.type=='2'? Text(
              'Book Token',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ):Text(
              'Book Appointment',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color(0xff4889FD),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
      ),
    );
  }
}
