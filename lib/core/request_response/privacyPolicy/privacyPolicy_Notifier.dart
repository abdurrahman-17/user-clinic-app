import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/privacyPolicy/privacyPolicy_Response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';

class Privacy_Policy_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  //
  // Date termsAndConditions_Date_ResponseClass = Date();
  // Date get TermsAndConditions_Date_Class => termsAndConditions_Date_ResponseClass;
  //
  // set   TermsAndConditions_Date_Class(Date value) {
  //   termsAndConditions_Date_ResponseClass = value;
  //   notifyListeners();
  // }
  PrivacyPolicyContent privacyPolicy_ResponseClass = PrivacyPolicyContent();
  PrivacyPolicyContent get PrivacyPolicy_Class => privacyPolicy_ResponseClass;

  set   PrivacyPolicy_Class(PrivacyPolicyContent value) {
    privacyPolicy_ResponseClass = value;
    notifyListeners();
  }

  Future<void> PrivacyPolicy_data() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Privacy_Policy;
    print(url);
    try {
      //   final input = {'patient_id': id,'date':date};
      //print(input);
      final response = await http.get(
        Uri.parse(url),
        //body: input,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
          //'Authorization': 'Bearer ${_prefs.getToken()}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final appointmentModel = privacyPolicyFromJson(response.body);
        PrivacyPolicy_Class = appointmentModel.privacyPolicyContent!;
        print(PrivacyPolicy_Class.privacyPolicy.toString());
        //TermsAndConditions_Date_Class = appointmentModel.date!;
        //log(appointmentModel.data![0].doctorName.toString());
        notifyListeners();
      }else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
