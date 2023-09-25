import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';
import 'No_of_appointment_response.dart';

class No_of_appointment extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<No_of_appo> appointmentResponseClass = [];
  List<No_of_appo> get AppointmentClass => appointmentResponseClass;

  set   AppointmentClass(List<No_of_appo> value) {
    appointmentResponseClass = value;
    notifyListeners();
  }

  Future<void> getNo_of_appointment(String id) async {
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
        final appointmentModel = noOfAppointmentFromJson(response.body);
        AppointmentClass = appointmentModel.data!;
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
