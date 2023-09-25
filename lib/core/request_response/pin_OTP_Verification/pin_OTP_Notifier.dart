import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/pin_OTP_Verification/pin_OTP_Response.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/OTP_Screen/otp_verificationscreen.dart';
import 'package:user_clinic_token_app/view/pin_OTP_verify/pint_Otp_verify.dart';

class pin_emila_send_OTP_Notfier extends BaseChangeNotifier {
  PinOtp? pinOtp;

  pin_emila_send_OTP_Notfier() {
  }


  Future<void> PinEmail_Otp(String email) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.pin_Otp;
    print(url);
    final input = {'email': email};
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
        final Email_OtpResponse =
        pinOtpFromJson(response.body);
        if (Email_OtpResponse.status == true) {
          Get.to(pin_OtpVerification(), arguments: [
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
    }
  }

}
