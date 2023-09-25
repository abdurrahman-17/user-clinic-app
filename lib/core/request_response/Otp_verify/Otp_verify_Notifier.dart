import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/Otp_verify/Otp_verify_Response.dart';
import 'package:user_clinic_token_app/core/request_response/email_otp_request/Email_Otp_Notifier.dart';

import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/onboard_screens/Onboarding_Screen.dart';

class OTP_Notifier extends BaseChangeNotifier {

  OTP_Notifier() {

  }



  Future<void> otp_verfiy(String email, String otp) async {
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Verify_otp;
    print(url);
    final input = {'email': email, 'otp': otp};
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

    if (response != null && response.statusCode == 200) {
      try {
        final OTP_Response =
        otpVerifyFromJson(response.body);
        if (OTP_Response.status == true) {
          Get.toNamed(RoutePaths.CHANGENEWPASSWORD, arguments: [
            {'email':email}
          ]);
        } else {
          appShowToast(OTP_Response.message!);
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
