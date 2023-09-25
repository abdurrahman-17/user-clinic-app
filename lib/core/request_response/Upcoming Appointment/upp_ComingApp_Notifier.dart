import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/Upcoming%20Appointment/upp_ComingApp_Response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';


class Upcoming_App_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;

  List<uppcoming_App_Data> upcoming_Appointment_ResponseClass = [];
  List<uppcoming_App_Data> get Upcoming_Appointment_Class => upcoming_Appointment_ResponseClass;

  set   Upcoming_Appointment_Class(List<uppcoming_App_Data> value) {
    upcoming_Appointment_ResponseClass = value;
    notifyListeners();
  }
  Future<void> Upcoming_App_data(String id) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.MY_appointment;
    print(url);
    try {
      final input = {'patient_id': id};
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
      if (response.statusCode == 200) {
        final appointmentModel = upcomingAppointmentFromJson(response.body);
        Upcoming_Appointment_Class = appointmentModel.data!;
        notifyListeners();
      } else if (response.statusCode == 401) {
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

// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
// import 'package:user_clinic_token_app/core/data_constants.dart';
// import 'package:user_clinic_token_app/core/request_response/Upcoming%20Appointment/upp_ComingApp_Response.dart';
// import 'package:user_clinic_token_app/core/request_response/privacyPolicy/privacyPolicy_Response.dart';
// import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
// import 'package:user_clinic_token_app/utils/app_locator.dart';
// import 'package:user_clinic_token_app/utils/app_message.dart';
//
// class Upcoming_App_Notifier extends BaseChangeNotifier {
//   final SharedPref _prefs = locator.get<SharedPref>();
//   bool isloading = false;
//   //
//   // Date termsAndConditions_Date_ResponseClass = Date();
//   // Date get TermsAndConditions_Date_Class => termsAndConditions_Date_ResponseClass;
//   //
//   // set   TermsAndConditions_Date_Class(Date value) {
//   //   termsAndConditions_Date_ResponseClass = value;
//   //   notifyListeners();
//   // }
//   List<uppcoming_App_Data> upcoming_Appointment_ResponseClass = [];
//   List<uppcoming_App_Data> get Upcoming_Appointment_Class => upcoming_Appointment_ResponseClass;
//
//   set   Upcoming_Appointment_Class(List<uppcoming_App_Data> value) {
//     upcoming_Appointment_ResponseClass = value;
//     notifyListeners();
//   }
//
//   Future<void> Upcoming_App_data() async {
//     isLoading = true;
//     final prefs = await SharedPreferences.getInstance();
//     String url = DataConstants.LIVE_BASE_URL + DataConstants.MY_appointment;
//     print(url);
//     try {
//       //   final input = {'patient_id': id,'date':date};
//       //print(input);
//       final response = await http.get(
//         Uri.parse(url),
//         //body: input,
//         headers: {
//           'Authorization': 'Bearer ${prefs.getString('token')}',
//           //'Authorization': 'Bearer ${_prefs.getToken()}',
//           'Accept': 'application/json'
//         },
//       );
//       log(response.body);
//       if (response.statusCode == 200) {
//         final appointmentModel = upcomingAppointmentFromJson(response.body);
//         Upcoming_Appointment_Class = appointmentModel.data!;
//         //print(Upcoming_Appointment_Class.privacyPolicy.toString());
//         //TermsAndConditions_Date_Class = appointmentModel.date!;
//         //log(appointmentModel.data![0].doctorName.toString());
//         notifyListeners();
//       } else if (response.statusCode == 401) {
//         appShowToast('You are unauthorized, please login again');
//       } else {
//         print('error');
//       }
//     } catch (e) {
//       print(e);
//     }
//     isLoading = false;
//   }
// }
//
