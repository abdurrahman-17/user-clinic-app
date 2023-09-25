import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/notification_on_off/notification_notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
import 'package:user_clinic_token_app/utils/localization/locale_constant.dart';
import 'package:user_clinic_token_app/utils/model/language_data.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/Edit_Profile/Edit_Profile.dart';
import 'package:user_clinic_token_app/view/check/log.dart';
import 'package:user_clinic_token_app/view/login/login.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool selected=false;
  bool selected1=false;
  int irfan = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF7F9FC),
        body: buildBody(context),
      ),
    );
  }
  Widget buildBody(context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Stack(
             children: [
               Container(
                   child: buildBackground(context)),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   backButton(context),
                   //buildSettingtitle(context),
                 ],
               )
             ],
           ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                buildChangeTheme(context),
                //buildLanguage(context),
                //buildProfile(context),
                buildNotificatio(context),
                buildLoginSetting(context),
                SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                buildLogOut(context),
                buildLogOutText(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildBackground(BuildContext context){
    return Image.asset('assets/images/mainscreen/bg_setting.png',width: double.infinity,);
  }
  Widget backButton(context) {
    return Row(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: 20),
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
    Align(
    alignment: Alignment.center,
    child: Padding(
    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: 10),
    child: Text('Settings',style: GoogleFonts.rubik(fontSize: 25,color: Colors.white),),
    ))
      ],
    );
  }
  // Widget buildSettingtitle(BuildContext context){
  //   return Align(
  //       alignment: Alignment.center,
  //       child: Padding(
  //         padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
  //         child: Text('Settings',style: GoogleFonts.rubik(fontSize: 25,color: Colors.white),),
  //       ));
  // }
  Widget buildChangeTheme(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
      child: ListTile(
        leading: CircleAvatar(radius: 25,
          backgroundColor: Colors.white,
          child:FaIcon(FontAwesomeIcons.adjust),
        ),
        title: Text('Change Theme',style: GoogleFonts.quicksand(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff4889FD)),),
        trailing: CupertinoSwitch(
          onChanged: (value){setState(() {
          selected=value;
          });},
          value: selected,),
      ),
    );
  }
  // Widget buildLanguage(BuildContext context){
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 25),
  //     child: ListTile(
  //       leading: CircleAvatar(radius: 25,
  //         backgroundColor: Colors.white,
  //         child:FaIcon(FontAwesomeIcons.globe)
  //       ),
  //       title: AutoSizeText('Select Language',maxLines: 1,style: GoogleFonts.quicksand(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff4889FD)),),
  //       //trailing:_createLanguageDropDown()
  //     ),
  //   );
  // }
  // Widget buildProfile(BuildContext context){
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 25),
  //     child: GestureDetector(
  //       onTap: (){
  //         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Edit_Profile()));
  //         },
  //       child: ListTile(
  //         leading: CircleAvatar(radius: 25,
  //           backgroundColor: Colors.white,
  //           child:FaIcon(FontAwesomeIcons.user),
  //         ),
  //         title: Text('Profile',style: GoogleFonts.quicksand(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff4889FD)),),
  //         trailing: Icon(Icons.arrow_right,color: Color(0xff363853),)
  //       ),
  //     ),
  //   );
  // }
  Widget buildNotificatio(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ListTile(
        leading: CircleAvatar(radius: 25,
          backgroundColor: Colors.white,
          child:FaIcon(FontAwesomeIcons.bell),
        ),
        title: Text('Notification',style: GoogleFonts.quicksand(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff4889FD)),),
        trailing: NotificationListener(
          onNotification: (value){
            print(selected1);
            return selected1;
          },
          child: CupertinoSwitch(
            onChanged: (value){setState(() {

              if(value == true){
                selected1=value;
                irfan = 1;
              }else{
                selected1=value;
                irfan = 0;
              }
              // selected=value;
              final notification_Model =
              Provider.of<NotificationNotifier>(context, listen: false);
              notification_Model.Notification_Setting(12.toString(),irfan.toString());
              print(irfan);
              //selected1=value;
              //print(selected1);
            });},
            value: selected1,),
        ),

      ),
    );
  }
  Widget buildLoginSetting(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: GestureDetector(
        onTap: (){Navigator.pushNamed(context, RoutePaths.Log_In_Setting);},
        child: ListTile(
          leading: CircleAvatar(radius: 25,
            backgroundColor: Colors.white,
            child:FaIcon(FontAwesomeIcons.key),
          ),
          title: Text('Login Setting',style: GoogleFonts.quicksand(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff4889FD)),),
          trailing: Icon(Icons.arrow_right,color: Color(0xff363853),)
        ),
      ),
    );
  }
  Widget buildLogOut(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
      child: Center(
        child: GestureDetector(
          onTap: (){

            MySharedPreferences.instance.removeAll();
            Navigator.pushNamedAndRemoveUntil(context, RoutePaths.LOGIN, (route) => false);
            },
          child: CircleAvatar(radius: 25,
              backgroundColor: Colors.white,
              child:Icon(Icons.logout_outlined,color: Colors.red,size: 25,),
            ),
        ),
      ),
    );
  }
  Widget buildLogOutText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(child: Text('Log Out',style: GoogleFonts.rubik(fontSize: 20,fontWeight: FontWeight.w500,color: Color(0xff4889FD)),)),
    );
  }
  // _createLanguageDropDown() {
  //   return DropdownButton<LanguageData>(
  //     iconSize: 30,
  //     hint: Text(Languages
  //         .of(context)!
  //         .labelSelectLanguage),
  //     onChanged: (LanguageData? language) {
  //       changeLanguage(context, language!.languageCode);
  //     },
  //     items: LanguageData.languageList()
  //         .map<DropdownMenuItem<LanguageData>>(
  //           (e) =>
  //           DropdownMenuItem<LanguageData>(
  //             value: e,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: <Widget>[
  //                 Text(e.name)
  //               ],
  //             ),
  //           ),
  //     )
  //         .toList(),
  //   );
  // }

}
