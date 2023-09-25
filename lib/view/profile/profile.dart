import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/no%20Image/no_Image_Response_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/Edit_Profile/Edit_Profile.dart';
import 'package:user_clinic_token_app/view/My%20Appointment/appointment_Upcoming.dart';
import 'package:user_clinic_token_app/view/pincode%20set/pincode_Set.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name='';
  String age='';
  String images='';

  No_Image no_imageprovider=No_Image();
  @override
  void initState() {
 Future.delayed(Duration.zero,(){
   no_imageprovider.getNo_Image();
   no_imageprovider.notifyListeners();

 });
    MySharedPreferences.instance.getage('age').then((value){
      setState(() {
        age=value;
      });
    });
    MySharedPreferences.instance.getusername('name').then((value){
      setState(() {
        name=value;
      });
    });
    MySharedPreferences.instance.getImage('image').then((value){
      setState(() {
        images=value;
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F6FC),
        body: buildBody(context),
      ),
    );
  }
  Widget buildBody(BuildContext context){
    return SingleChildScrollView(
      child: Stack(
        children: [
            buildBackgroundandTitle(context),
            buildProfileList(context),
        ],
      ),
    );
  }
  Widget buildBackgroundandTitle(BuildContext context){
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(13),bottomRight: Radius.circular(13)
        ),
        color: Color(0xff4889FD),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          backButton(context),

          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(color:Colors.black.withOpacity(0.05),borderRadius: BorderRadius.circular(150)),
            ),
          )
        ],
      ),
    );
  }
  Widget buildProfileList(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 170),
      child: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
                buildUsernameAndWidgets(context),
                //buildBackButton(context),

          ],
        ),
      ),
    );
  }
  Widget buildUsernameAndWidgets(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: -50,
              child: image(context)),
          Column(
            children: [
              SizedBox(height: 60,),
              Text(name,style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w700),),
              SizedBox(height: 5,),
              Text(age+' Years old',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xff8F9BB3)),),
              //SizedBox(height: 20,),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Column(
              //       children: [
              //         CircleAvatar(
              //           radius: 40,
              //           backgroundColor: Color(0xff7ACEFA).withOpacity(0.15),
              //           child: Icon(Icons.person,color: Color(0xff7ACEFA),),
              //         ),
              //         SizedBox(height: 10,),
              //         Text('Saved',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),),
              //         Text('Doctors',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),)
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         CircleAvatar(
              //           radius: 40,
              //           backgroundColor: Color(0xffE8899E).withOpacity(0.15),
              //           child: Icon(Icons.file_copy,color: Color(0xffE8899E),),
              //         ),
              //         SizedBox(height: 10,),
              //         Text('Saved',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),),
              //         Text('Articles',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),)
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         CircleAvatar(
              //           radius: 40,
              //           backgroundColor: Color(0xffF7C480).withOpacity(0.15),
              //           child: Icon(Icons.favorite_border,color: Color(0xffF7C480),),
              //         ),
              //         SizedBox(height: 10,),
              //         Text('Health',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),),
              //         Text('Dairy',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),)
              //       ],
              //     ),
              //   ],
              // ),
              //SizedBox(height: 20,),
              Divider(color: Color(0xffEDF1F7),),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Edit_Profile()));
                },
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff4889FD).withOpacity(0.08),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: FaIcon(FontAwesomeIcons.userAlt,color: Color(0xff231F20),size: 20,),
                    ),
                  ),
                  title: Text('Edit Profile',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
                  trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
                ),
              ),
              Divider(color: Color(0xffEDF1F7),),
              SizedBox(height: 5,),
              // ListTile(
              //   leading: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: Color(0xff4889FD).withOpacity(0.08),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(12),
              //       child: Icon(Icons.opacity_outlined,color: Color(0xff231F20),),
              //     ),
              //   ),
              //   title: Text('Pills Remainder',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
              //   trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
              // ),
              // Divider(color: Color(0xffEDF1F7),),
              // SizedBox(height: 5,),
              GestureDetector(
                onTap: (){Navigator.pushNamed(context, RoutePaths.My_Doctor);},
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff4889FD).withOpacity(0.08),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: FaIcon(FontAwesomeIcons.userMd,color:Color(0xff222B45))
                    ),
                  ),
                  title: Text('My Doctor',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
                  trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
                ),
              ),
              Divider(color: Color(0xffEDF1F7),),
              SizedBox(height: 5,),
              // GestureDetector(
              //   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Family_member()));},
              //   child: ListTile(
              //     leading: Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5),
              //         color: Color(0xff4889FD).withOpacity(0.08),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(12),
              //         child: Icon(Icons.groups_outlined,color: Color(0xff231F20),),
              //       ),
              //     ),
              //     title: Text('Family Member',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
              //     trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
              //   ),
              // ),
              // Divider(color: Color(0xffEDF1F7),),
              // SizedBox(height: 5,),
              // GestureDetector(
              //   onTap: (){
              //     //Navigator.pushNamed(context, RoutePaths.Health_Record);
              //     },
              //   child: ListTile(
              //
              //     leading: Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5),
              //         color: Color(0xff4889FD).withOpacity(0.08),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(12),
              //         child: Icon(Icons.file_copy_outlined,color: Color(0xff231F20),),
              //       ),
              //     ),
              //     title: Text('EHR File',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
              //     trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
              //   ),
              // ),
              // Divider(color: Color(0xffEDF1F7),),
              // SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>pincode_Set()));
                  },
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff4889FD).withOpacity(0.08),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(11.5),
                      child: FaIcon(FontAwesomeIcons.solidCreditCard,color: Color(0xff231F20),),
                    ),
                  ),
                  title: Text('Payment History',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
                  trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
                ),
              ),
              SizedBox(height: 10,)
              //Divider(color: Color(0xffEDF1F7),),

            ],
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
  // Widget buildBackButton(BuildContext context){
  //   return Padding(
  //       padding: const EdgeInsets.only(top:10,bottom: 20,),
  //       child: SizedBox(
  //         height: 50,
  //         width: double.infinity,
  //         child: ElevatedButton(onPressed: (){
  //           Navigator.pop(context);
  //         },
  //             child: Text('Back',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
  //             style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
  //         ),
  //       ));
  // }
  Widget image(BuildContext context){
    return Consumer<No_Image>(
      builder: (context,provider,_){
        this.no_imageprovider=provider;
        return ModalProgressHUD(inAsyncCall: provider.isloading, child:ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: 100,
              height: 100,
              placeholder: (context, url) => Image.asset('assets/images/giphy.gif'),
              imageUrl:images=="null"?
              DataConstants.LIVE_BASE_URL+'/'+no_imageprovider.no_ImageResponseClass.toString():
              DataConstants.LIVE_BASE_URL+'/'+images),
        ) );
      },
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
          padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.03,),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text('Profile',style: TextStyle(fontSize: 25,color: Colors.white))),
        ),
        SizedBox(width:60)

      ],
    );
  }
}
