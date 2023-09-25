import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/doctor_profile/doctor_profile_response.dart';
import 'package:user_clinic_token_app/core/request_response/login/loginresponse.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';

class Doctor_ProfileNotifier extends BaseChangeNotifier {
  DoctorProfile? doctorProfile;

  Doctor_ProfileNotifier() {
  }


  Future<void> Doctor_profile(String email) async {
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.pin_Otp;
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

    if (response != null && response.statusCode == 200) {
      try {
        final Doctor_ProfileResponse =
        doctorProfileFromJson(response.body);
        if (Doctor_ProfileResponse.status == true) {
          Get.toNamed(RoutePaths.OTPVERIFICATION, arguments: true);
        } else {
          appShowToast(Doctor_ProfileResponse.message!);
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
