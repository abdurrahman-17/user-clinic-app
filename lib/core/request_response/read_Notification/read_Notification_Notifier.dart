import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/pin_OTP_Verification/pin_OTP_Response.dart';
import 'package:user_clinic_token_app/core/request_response/read_Notification/read_Notification_Response.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/OTP_Screen/otp_verificationscreen.dart';
import 'package:user_clinic_token_app/view/pin_OTP_verify/pint_Otp_verify.dart';

class read_Notification_Notfier extends BaseChangeNotifier {
  ReadNotification? readNotification;

  read_Notification_Notfier() {
  }


  Future<void> read_Notification_Data(String id) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.read_Notification;
    print(url);
    final input = {'patient_id': id,'app_type':'1'};
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
        final read_Notificationdata =
        readNotificationFromJson(response.body);
        if (read_Notificationdata.status == true) {

        } else {
          appShowToast(read_Notificationdata.message!);
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
