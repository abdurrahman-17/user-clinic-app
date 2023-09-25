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

class Password_setting_Notifier extends BaseChangeNotifier {
  NotificationModel? notificationModel;

  Password_setting_Notifier() {
  }



  Future<void> password_change_setting(String id, String old_password,String password,String confirm_password) async {
    final prefs = await SharedPreferences.getInstance();
    String token="";
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.password_change_setting;
    print(url);
    final input = {'patient_id': id, 'old_password': old_password,'password':password,'cfm_password':confirm_password};
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

    if (response != null && response.statusCode == 200) {
      try {
        final Password_model_Response =
        passwordChangeFromJson(response.body);
        if (Password_model_Response.status == true) {
          Get.offAndToNamed(RoutePaths.HomeScreen, arguments: true);
        } else {
          appShowToast(Password_model_Response.message!);
        }
      }
      catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }
  }

}
