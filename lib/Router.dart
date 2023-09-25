import 'package:flutter/material.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/Appointment%20Done/Appointemnt_done.dart';
import 'package:user_clinic_token_app/view/Change_new_password_setting/Change_new_Password.dart';
import 'package:user_clinic_token_app/view/Dr_profile/dr_profile.dart';
import 'package:user_clinic_token_app/view/Log%20in%20Setting/Log_in_Setting.dart';
import 'package:user_clinic_token_app/view/Notification_New_UI/Notifiaction_new_UI.dart';
import 'package:user_clinic_token_app/view/OTP_Screen/otp_verificationscreen.dart';
import 'package:user_clinic_token_app/view/Prescription/prescription.dart';
import 'package:user_clinic_token_app/view/add_family_member/add_family_member.dart';
import 'package:user_clinic_token_app/view/appointment_page/Appointment_page.dart';
import 'package:user_clinic_token_app/view/change_password/change_new_password.dart';
import 'package:user_clinic_token_app/view/family_member/family_member.dart';
import 'package:user_clinic_token_app/view/forgot_screen/forget_screen.dart';
import 'package:user_clinic_token_app/view/homescreen/homescreen.dart';
import 'package:user_clinic_token_app/view/login/login.dart';
import 'package:user_clinic_token_app/view/my_doctor/my_Doctors.dart';
import 'package:user_clinic_token_app/view/health_record/Health_Record.dart';
import 'package:user_clinic_token_app/view/Token_done/Token_done_page.dart';
import 'package:user_clinic_token_app/view/no.of%20appointment/no_of_appointment.dart';
import 'package:user_clinic_token_app/view/notification/notification.dart';
import 'package:user_clinic_token_app/view/pharmacy/pharmacy.dart';
import 'package:user_clinic_token_app/view/pin_entry/pin_entry.dart';
import 'package:user_clinic_token_app/view/setting/setting.dart';
import 'package:user_clinic_token_app/view/token_appointment_new/Token_Appointment_New.dart';
import 'package:user_clinic_token_app/view/token_appointment_page/token_appointment_page.dart';
import 'package:user_clinic_token_app/view/signup/singup.dart';

import 'view/Notification_New_UI/Notifiaction_new_UI.dart';

class MyRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case RoutePaths.LOGIN:
        return MaterialPageRoute(builder: (BuildContext context) => Login(),settings: settings);
      case RoutePaths.HOME:
        return MaterialPageRoute(builder: (BuildContext context) => SignUpPage(),settings: settings);
      case RoutePaths.HomeScreen:
        return MaterialPageRoute(builder: (BuildContext context) => HomeScreen(),settings: settings);
      case RoutePaths.FORGOT:
        return MaterialPageRoute(builder: (BuildContext context) => ForgetScreen(),settings: settings);
      case RoutePaths.OTPVERIFICATION:
        return MaterialPageRoute(builder: (BuildContext context) => OtpVerification(),settings: settings);
      case RoutePaths.CHANGENEWPASSWORD:
        return MaterialPageRoute(builder: (BuildContext context) => ChangeNewPassword(),settings: settings,);
      // case RoutePaths.BOTTOMNAVIGATION:
      //   return MaterialPageRoute(builder: (BuildContext context) => NavigationScreen(),settings: settings);
      case RoutePaths.FAMILYMEMEBER:
        return MaterialPageRoute(builder: (BuildContext context) => Family_member(),settings: settings);
      case RoutePaths.APPOINTMENTSCREEN:
        return MaterialPageRoute(builder: (BuildContext context) => TokenAppointment(),settings: settings);
      case RoutePaths.DrPROFILE:
        return MaterialPageRoute(builder: (BuildContext context) => DrProfile(selected: "", type: '',),settings: settings);
      case RoutePaths.Appointment:
        return MaterialPageRoute(builder: (BuildContext context) => New_appointment(id: 0,),settings: settings);
      case RoutePaths.Appointment_Done:
        return MaterialPageRoute(builder: (BuildContext context) => Appointment_done(time: '', date: '', name: '', age: '', drspec: '', drimage: '', drname: '', draddress: '',),settings: settings);
      case RoutePaths.Token:
        return MaterialPageRoute(builder: (BuildContext context) => Toke_Appointment_New(),settings: settings);
      case RoutePaths.Token_Done:
        return MaterialPageRoute(builder: (BuildContext context) => token_done_page(token: '', draddress: '', drname: '', drimage: '', age: '', name: '', drspec: '', date: '', time: '',),settings: settings);
      // case RoutePaths.Doctor_Profile_token:
      //   return MaterialPageRoute(builder: (BuildContext context) => DrProfile_token(),settings: settings);
      case RoutePaths.Pin_Set:
        return MaterialPageRoute(builder: (BuildContext context) => Pin_Set_Up(),settings: settings);
      case RoutePaths.Notification:
        return MaterialPageRoute(builder: (BuildContext context) => Notification_Screen(),settings: settings);
      case RoutePaths.Notification_New:
        return MaterialPageRoute(builder: (BuildContext context) => Notification_New(),settings: settings);
      case RoutePaths.NoOFAppointment:
        return MaterialPageRoute(builder: (BuildContext context) => No_of_Appointment(),settings: settings);
      case RoutePaths.Setting:
        return MaterialPageRoute(builder: (BuildContext context) => Setting(),settings: settings);
      case RoutePaths.Health_Record:
        return MaterialPageRoute(builder: (BuildContext context) => Health_Record(),settings: settings);
      case RoutePaths.My_Doctor:
        return MaterialPageRoute(builder: (BuildContext context) => My_Doctor(),settings: settings);
      case RoutePaths.Prescription:
        return MaterialPageRoute(builder: (BuildContext context) => Prescription(appointment_id: "",),settings: settings);
      case RoutePaths.Change_New_Password_setting:
        return MaterialPageRoute(builder: (BuildContext context) => Change_new_Password(),settings: settings);
      case RoutePaths.Pharmacy:
        return MaterialPageRoute(builder: (BuildContext context) => Pharmacy(id: null,),settings: settings);
      case RoutePaths.Add_Family__Member:
        return MaterialPageRoute(builder: (BuildContext context) => Add_Family_Member(),settings: settings);
      case RoutePaths.Log_In_Setting:
        return MaterialPageRoute(builder: (BuildContext context) => Log_in_Setting(),settings: settings);

      default:
        return MaterialPageRoute(builder: (BuildContext context)=>Scaffold(body: Center(child: Text('No Route defined for ${settings.name}'))));
    }
  }
}