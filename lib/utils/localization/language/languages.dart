import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
    // static Languages of(BuildContext context) {
    //   return Localizations.of<Languages>(context, Languages);
  }

  String get appName;
  String get labelWelcome;
  String get labelInfo;
  String get labelSelectLanguage;
  String get registerLabel;
  String get registerEntry1;
  String get registerEntry;
  String get registerEntry2;
  String get registerEntry3;
  String get fullName;
  String get email;
  String get password;
  String get confirmPassword;
  String get address;
  String get city;
  String get state;
  String get pincode;
  String get termAndc;
  String get registerButton;
  String get youhaveanaccount;
  String get Welcomebacktoclinic;
  String get login;
  String get forgotPassword;
  String get Donthaveanaccount;
  String get requestOTP;
  String get OTPverification;
  String get OTPpara;
  String get submit;
  String get didntreceiveotp;
  String get resendotp;
  String get changenewpassword;
  String get changenewpasswordPara;
  String get changenewpasswordButton;
  String get welcomeback;
  String get bookappoinment;
  String get biography;
  String get location;
  String get makeanappointment;
  String get morning;
  String get evening;
  String get viewmore;
  String get dateandtime;
  String get getdirection;
  String get done;
  String get cancelappointment;
  String get familymember;
  String get register;
  String get Welcomebacktoclinic2;
  String get forgotpara;
  String get booktoken;
  String get canceltoken;
  String get token;
  String get pin;
  String get confirm_pin;
  String get pin_para;
  String get pin_Heading;
  String get Set_Pin_Button;
  String get Time_slot;



}
