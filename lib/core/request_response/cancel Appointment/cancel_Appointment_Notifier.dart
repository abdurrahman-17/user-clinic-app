import 'dart:developer';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/privacyPolicy/privacyPolicy_Response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/view/no.of%20appointment/no_of_appointment.dart';

import '../../../utils/common/app_route_paths.dart';
import 'cancel_Appointment_Response.dart';

class Cancel_Appointment_Notifier extends BaseChangeNotifier {
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
  // DeleteFamilyMember family_Member_Delete_ResponseClass = DeleteFamilyMember();
  // DeleteFamilyMember get Family_Member_Delete_Class => DeleteFamilyMember();
  //
  // set   Family_Member_Delete_Class(DeleteFamilyMember value) {
  //   family_Member_Delete_ResponseClass = value;
  //   notifyListeners();
  // }
  Future<void>Cancel_Appointment_data(String app_id,String Status) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Cancel_Appointment;
    print(url);
    try {
      final input = {'appoinment_id': app_id,'status':Status};
      print(input);
      final response = await http.post(
        Uri.parse(url),
        body: input,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
          //'Authorization': 'Bearer ${_prefs.getToken()}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      print(response.statusCode);
      final cancelappointment = cancelAppointmentFromJson(response.body);
      if (response.statusCode == 200) {
         final cancelappointment = cancelAppointmentFromJson(response.body);
        // Family_Member_Delete_Class = appointmentModel;
        //print(About_Us_Class.privacyPolicy.toString());
        //TermsAndConditions_Date_Class = appointmentModel.date!;
        //log(appointmentModel.data![0].doctorName.toString());
        notifyListeners();
        Get.back();
        Get.offAndToNamed(RoutePaths.NoOFAppointment);
        //Get.off(No_of_Appointment());
      } else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        appShowToast(cancelappointment.message.toString());
        Get.back();
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
