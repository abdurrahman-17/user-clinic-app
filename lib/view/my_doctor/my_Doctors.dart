import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/carousel/DoctorList_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/my%20Doctor/my_Doctor_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/Dr_profile/dr_profile.dart';

class My_Doctor extends StatefulWidget {
  const My_Doctor({Key? key}) : super(key: key);

  @override
  _My_DoctorState createState() => _My_DoctorState();
}

class _My_DoctorState extends State<My_Doctor> {
  My_Doctor_Notifier provider=My_Doctor_Notifier();

  String id='';
  @override
  void initState() {
    MySharedPreferences.instance.getid('id').then((value) {
      id=value.toString();
      print(id);
    });
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      provider.MyDoctor_data(id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<My_Doctor_Notifier>(
      builder: (context,provider,_){
        this.provider=provider;
        return ModalProgressHUD(inAsyncCall:provider.isLoading , child:SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xffF5F6FC),
            body: buildbody(context),
          ),
        ) );
      },
    );
  }

  Widget buildbody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          buildBackground(context),
          Column(
            children: [
              backButton(context),
              build_All_Doctor(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBackground(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Color(0xff4889FD),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
    );
  }

  Widget build_All_Doctor(BuildContext context) {
    final postget=Provider?.of<Doctor>(context,listen: false);
    return provider.my_doctor_ResponseClass.isEmpty?Padding(
      padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.4 ),
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.userMd,color: Colors.grey,size: 80,),
          SizedBox(height: 5,),
          Text('No Doctor Is Availabel',style: TextStyle(fontSize: 18),)
        ],
      ),
    ):Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 40),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.filter_list_outlined,
            //         color: Colors.white,
            //       ),
            //       // Text(
            //       //   'FILTER',
            //       //   style: GoogleFonts.roboto(
            //       //       color: Colors.white,
            //       //       fontSize: 14,
            //       //       fontWeight: FontWeight.w700),
            //       // ),
            //     ],
            //   ),
            // ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: ListView.builder(
                  physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.my_doctor_ResponseClass.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: GestureDetector(
                          onTap: (){
                            // print(postget.doctorList.data![index].id.toString());
                            // print(postget.doctorList.data![index].type);
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                DrProfile(selected:provider.my_doctor_ResponseClass[index].doctorId.toString(),type:provider.my_doctor_ResponseClass[index].type.toString())));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 4),
                                    blurRadius: 3)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16,top: 35,bottom: 35),
                                  child: provider.my_doctor_ResponseClass[index].doctorImage!=null?
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                                'assets/images/giphy.gif'),
                                        imageUrl:DataConstants.LIVE_BASE_URL+'/'+provider.my_doctor_ResponseClass[index].doctorImage.toString()

                                      //    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRLe5PABjXc17cjIMOibECLM7ppDwMmiDg6Dw&usqp=CAU"
                                    ),
                                  ):ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                                'assets/images/giphy.gif'),
                                        imageUrl:"https://media.istockphoto.com/vectors/no-image-available-sign-vector-id922962354?k=20&m=922962354&s=170667a&w=0&h=mRTFds0L_Hq63ohdqIdHXMrE32DqOnajt4I0yJ1bBtU=",

                                      //    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRLe5PABjXc17cjIMOibECLM7ppDwMmiDg6Dw&usqp=CAU"
                                    ),
                                  )
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: ListTile(
                                      title: Text('Dr.'+provider.my_doctor_ResponseClass[index].doctorName.toString(),style: Dr_nameinMy_doctor(context),),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 11),
                                        child: Text(provider.my_doctor_ResponseClass[index].specialist.toString(),style: SpecialistStylenew(context),),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            //buildButton(context),
          ],
        ));
  }

  Widget buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, bottom: 10, left: 25, top: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Back',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color(0xff4889FD),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
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
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: 20),
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
          padding: EdgeInsets.only(top:  MediaQuery.of(context).size.height*0.03),
          child: Text(
            'My Doctors',
            style: GoogleFonts.roboto(
                fontSize: 25,
                color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 60,)
      ],
    );
  }
}
