import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/get%20Appointment%20Filter/get_Appointment_Filter_Response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';

class Get_Appointment_Filter_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;

  List<get_Appointment_Filter_class> get_appointment_filter_ResponseClass = [];
  List<get_Appointment_Filter_class> get Get_Appointemnt_Filter_Class => get_appointment_filter_ResponseClass;

  set   Get_Appointment_Filter_Class(List<get_Appointment_Filter_class> value) {
    get_appointment_filter_ResponseClass = value;
    notifyListeners();
  }

  Future<void> Get_Appointment_filter_data(String id,String date) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Get_Appointment_by_id_filter;
    print(url);
    try {
      final input = {'patient_id': id,'date':date};
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
        final appointmentModel = getAppointmentFilterFromJson(response.body);
        Get_Appointment_Filter_Class = appointmentModel.data!;
        log(appointmentModel.data![0].doctorName.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      }else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
