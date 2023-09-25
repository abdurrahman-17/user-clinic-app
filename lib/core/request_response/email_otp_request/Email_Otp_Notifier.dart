import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/login/loginresponse.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/OTP_Screen/otp_verificationscreen.dart';

import 'Email_Otp_Response.dart';

class EmailotpNotifier extends BaseChangeNotifier {
  EmailOtp? emailOtp;

  EmailotpNotifier() {
  }


  Future<void> PatientEmail_Otp(String email) async {
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Email_Otp;
    print(url);
    final input = {'email': email};
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
    final Email_OtpResponse =
    emailOtpFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        final Email_OtpResponse =
        emailOtpFromJson(response.body);
        if (Email_OtpResponse.status == true) {
          Get.to(OtpVerification(), arguments: [
            {'email':email}
          ]);
        } else {
          appShowToast(Email_OtpResponse.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }else {
      appShowToast(Email_OtpResponse.message!);
    }
  }

}
