import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/no%20Image/no_Image_Response_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/notification_on_off/notification_notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/about%20US/about_Us.dart';
import 'package:user_clinic_token_app/view/change_email/change_email.dart';
import 'package:user_clinic_token_app/view/change_mobile_number/change_mobile_number.dart';
import 'package:user_clinic_token_app/view/login/login.dart';
import 'package:user_clinic_token_app/view/privacy%20Policy/privacy%20Policy.dart';
import 'package:user_clinic_token_app/view/terms%20And%20Conditions/terms_And_Conditions.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  No_Image no_imageprovider=No_Image();
  bool selected = false;
  bool selected1 = false;
  bool isExpanded = false;
  int irfan = 0;
  String name='';
  String email='';
  String image='';
  String noimage='';

  @override
  void initState() {
  Future.delayed(Duration.zero,(){
    no_imageprovider.getNo_Image().then((value) {
      noimage=no_imageprovider.no_ImageResponseClass;
    });
    no_imageprovider.notifyListeners();
  });

    MySharedPreferences.instance.getEmail('email').then((value){
      setState(() {
        email=value;
      });
    });
    MySharedPreferences.instance.getusername('name').then((value){
      setState(() {
        name=value;
      });
    });
    MySharedPreferences.instance.getImage('image').then((value){
      setState(() {
        image=value;
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xffD3D3D3)),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Container(
                      height: 70,
                      width: 70,
                      child: Consumer<No_Image>(
                        builder: (context,provider,_){
                          this.no_imageprovider=provider;
                          return ModalProgressHUD(inAsyncCall: provider.isloading, child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              image=="null"?DataConstants.LIVE_BASE_URL+'/'+noimage:
                              DataConstants.LIVE_BASE_URL+'/'+image,
                              fit: BoxFit.cover,
                            ),
                          ));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      name,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(email),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  // ListTile(
                  //   leading: FaIcon(
                  //     FontAwesomeIcons.adjust,
                  //     color: Color(0xff5A95FD),
                  //   ),
                  //   title: Text(
                  //     'Change Theme',
                  //     style: TextStyle(),
                  //   ),
                  //   trailing: Transform.scale(
                  //     scale: 0.75,
                  //     child: CupertinoSwitch(
                  //       onChanged: (value) {
                  //         setState(() {
                  //           selected = value;
                  //         });
                  //       },
                  //       value: selected,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     //Navigator.pushNamed(context, RoutePaths.DoctorList);
                  //   },
                  // ),
                  // ListTile(
                  //   leading: FaIcon(
                  //     FontAwesomeIcons.bell,
                  //     color: Color(0xff5A95FD),
                  //   ),
                  //   title: Text(
                  //     'Notification',
                  //   ),
                  //   trailing: NotificationListener(
                  //     onNotification: (value) {
                  //       print(selected1);
                  //       return selected1;
                  //     },
                  //     child: Transform.scale(
                  //       scale: 0.75,
                  //       child: CupertinoSwitch(
                  //         onChanged: (value) {
                  //           setState(() {
                  //             if (value == true) {
                  //               selected1 = value;
                  //               irfan = 1;
                  //             } else {
                  //               selected1 = value;
                  //               irfan = 0;
                  //             }
                  //             // selected=value;
                  //             final notification_Model =
                  //                 Provider.of<NotificationNotifier>(context,
                  //                     listen: false);
                  //             notification_Model.Notification_Setting(
                  //                 12.toString(), irfan.toString());
                  //             print(irfan);
                  //             //selected1=value;
                  //             //print(selected1);
                  //           });
                  //         },
                  //         value: selected1,
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     //Navigator.pushNamed(context, RoutePaths.StaffList);
                  //   },
                  // ),

                  ExpansionTile(
                    onExpansionChanged: (bool expanding) =>
                        setState(() => this.isExpanded = expanding),
                    leading: Icon(
                      Icons.event_available,
                      color: Color(0xff5A95FD),
                    ),
                    title: Text(
                      'Log In Setting',
                      style: TextStyle(
                          color: isExpanded ? Color(0xff5A95FD) : Colors.black),
                    ),
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.email_outlined,
                          color: Color(0xff5A95FD),
                        ),
                        title: Text(
                          'Change Email',
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Change_email_setting()));
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=> TimeAndTokenScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.vpn_key_outlined,
                          color: Color(0xff5A95FD),
                        ),
                        title: Text(
                          'Change Password',
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutePaths.Change_New_Password_setting);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=> ListOfAVilability()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone_android,
                          color: Color(0xff5A95FD),
                        ),
                        title: Text(
                          'Change Mobile Number',
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Change_mobile_setting()));
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=> ListOfAVilability()));
                        },
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.error_outline,
                      color: Color(0xff5A95FD),
                    ),
                    title: const Text(
                      'Terms & Condition',
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Terms_And_Condition()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.verified_user_outlined,
                      color: Color(0xff5A95FD),
                    ),
                    title: const Text(
                      'Privacy Policy',
                    ),
                    onTap: () {
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) =>  Privacy_Policy()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help_outline_outlined,
                      color: Color(0xff5A95FD),
                    ),
                    title: const Text(
                      'About Us',
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  About_Us()));
                    },
                  ),
                  //Spacer(),
                ],
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title:Text(
                  'Log Out',
                  style: TextStyle(),
                ),
                onTap: () async{
                  final prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  MySharedPreferences.instance.removeAll();
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutePaths.LOGIN, (route) => false);
                })
          ],
        ),
      ),
    );
  }
}
