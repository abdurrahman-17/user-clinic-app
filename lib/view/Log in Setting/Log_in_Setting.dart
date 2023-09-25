import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/change_email/change_email.dart';
import 'package:user_clinic_token_app/view/change_mobile_number/change_mobile_number.dart';

class Log_in_Setting extends StatefulWidget {
  const Log_in_Setting({Key? key}) : super(key: key);

  @override
  _Log_in_SettingState createState() => _Log_in_SettingState();
}

class _Log_in_SettingState extends State<Log_in_Setting> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF7F9FC),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              buildBackground(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backButton(context),
                  //buildLogin_Setting_title(context),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                buildChange_Password(context),
                buildChange_Email(context),
                buildChange_Phone_Number(context),
                buildLogOut(context),
                buildLogOutText(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackground(BuildContext context) {
    return Image.asset('assets/images/mainscreen/bg_setting.png');
  }

  Widget backButton(context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,left: 20),
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 23,left: MediaQuery.of(context).size.width*0.02),
          child: Text(
            'Login Setting',
            style: GoogleFonts.rubik(fontSize: 25, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget buildLogin_Setting_title(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
          child: Text(
            'Login Setting',
            style: GoogleFonts.rubik(
                fontWeight: FontWeight.w500, fontSize: 30, color: Colors.white),
          ),
        ));
  }

  Widget buildChangeTheme(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: FaIcon(FontAwesomeIcons.adjust),
        ),
        title: Text(
          'Change Theme',
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Color(0xff4889FD)),
        ),
        trailing: CupertinoSwitch(
          onChanged: (value) {
            setState(() {
              selected = value;
              print(selected);
            });
          },
          value: selected,
        ),
      ),
    );
  }

  Widget buildChange_Password(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: GestureDetector(
        onTap: (){Navigator.pushNamed(context, RoutePaths.Change_New_Password_setting);},
        child: ListTile(
            title: Text(
              'Change Password',
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color(0xff4889FD)),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Color(0xff363853),
            )),
      ),
    );
  }

  Widget buildChange_Email(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: GestureDetector(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Change_email_setting()));},
        child: ListTile(
            title: Text(
              'Change Email',
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color(0xff4889FD)),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Color(0xff363853),
            )),
      ),
    );
  }

  Widget buildChange_Phone_Number(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Change_mobile_setting()));
        },
        child: ListTile(
            title: Text(
              'Change Phone Number',
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color(0xff4889FD)),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Color(0xff363853),
            )),
      ),
    );
  }

  Widget buildLogOut(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: Center(
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.logout_outlined,
            color: Colors.red,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget buildLogOutText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
          child: Text(
        'Log Out',
        style: GoogleFonts.rubik(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xff4889FD)),
      )),
    );
  }
}
