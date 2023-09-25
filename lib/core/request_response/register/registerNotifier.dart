import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/login/loginNotifier.dart';
import 'package:user_clinic_token_app/core/request_response/login/loginresponse.dart';
import 'package:user_clinic_token_app/core/request_response/register/registerresponse.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/onboard_screens/Onboarding_Screen.dart';

class RegisterNotifier extends BaseChangeNotifier {
  RegisterResponse? registerResponse;

  RegisterNotifier() {
  }



  Future<void> PatientRegister(String email, String password,String name,String address,String city,String state,String zipcode,String mobilenumber,String FCMkey,String devicetype) async {
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Register;
    print(url);
    final input = {'name':name,'email': email, 'password': password,'address':address,'city':city,'state':state,'zip_code':zipcode,'mobile_number':mobilenumber};
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {
        //'Authorization': 'Bearer ${prefs.getToken()}',
        'Accept': 'application/json'
      },
    );
    super.isLoading = false;
    log(response.body);
    final patientRegister =
    registerResponseFromJson(response.body);
    if (response != null && response.statusCode == 200) {

      try {
        final patientRegister =
        registerResponseFromJson(response.body);
        if (patientRegister.status == true) {
          print('check');
          appShowToast(patientRegister.message.toString());
          LoginNotifier loginNotifier=LoginNotifier();
          loginNotifier.PatientLogin(email,password,devicetype,FCMkey);
          //Get.off(OnboardingScreen(), arguments: true);
        }
        // else if(patientRegister.status==false){
        //
        // }
        else {
          print('irfan');
          appShowToast(patientRegister.message.toString());
        }
      } catch (e) {
        print('hi');
        print(e);
        appShowToast(e.toString());
      }
    }else if(patientRegister.status==false){
      appShowToast(patientRegister.error.toString());
    }else{
      print('hello');
      appShowToast(patientRegister.message.toString());
    }
  }

}
