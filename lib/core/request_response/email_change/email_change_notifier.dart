import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/login/loginresponse.dart';
import 'package:user_clinic_token_app/core/request_response/notification_on_off/notification_response.dart';
import 'package:user_clinic_token_app/core/request_response/password_change_setting/password_change_response.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';

import 'package:user_clinic_token_app/view/onboard_screens/Onboarding_Screen.dart';

import 'email_change_response.dart';

class Email_change_Notifier extends BaseChangeNotifier {
  EmailChange? emailChange;

  Email_change_Notifier() {
  }



  Future<void> email_change_setting(String old_password,String old_email,String new_email,String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token="";
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.email_change_setting;
    print(url);
    final input = { 'old_password': old_password,'old_email':old_email,'new_email':new_email,'patient_id':id};
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
        'Accept': 'application/json'
      },
    );
    super.isLoading = false;
    log(response.body);
    final email_model_Response =
    emailChangeFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        final email_model_Response =
        emailChangeFromJson(response.body);
        if (email_model_Response.status == true) {
          Get.offAllNamed(RoutePaths.HomeScreen, arguments: true);

        } else {
          appShowToast(email_model_Response.message!);
        }
      }
      catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    } else {
      appShowToast(email_model_Response.message!);
    }
  }

}
