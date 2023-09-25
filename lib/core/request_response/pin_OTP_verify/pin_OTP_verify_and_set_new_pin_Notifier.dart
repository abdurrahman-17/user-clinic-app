import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/Otp_verify/Otp_verify_Response.dart';
import 'package:user_clinic_token_app/core/request_response/email_otp_request/Email_Otp_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/pin_OTP_verify/pin_OTP_verify_and_set_new_pin_Response.dart';

import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/onboard_screens/Onboarding_Screen.dart';

class pin_OTP_Notifier extends BaseChangeNotifier {

  pin_OTP_Notifier() {
  }



  Future<void> pin_otp_verfiy(String email, String otp,String pin_number) async {

    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.pin_Verify_otp;
    print(url);
    final input = {'email': email, 'otp': otp,'pin_number':pin_number};
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
        final pin_OTP_Response =
        pinOtpVerifyFromJson(response.body);
        if (pin_OTP_Response.status == true) {
          MySharedPreferences.user_clinic().setPin('pin', pin_OTP_Response.data![0].pinAuthentication.toString());
          Get.offAllNamed(
              RoutePaths.HomeScreen, arguments: [
            {'email':email}
          ]);
        } else {
          appShowToast(pin_OTP_Response.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }
  }

}
