import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';
import 'notification_Count_Response.dart';

class Notification_Count_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;

  String Notification_count='';
  String? message;

  Future<void> Notification_count_data(String id) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Notification_count;
    print(url);
    try {
      final input = {'patient_id': id,'app_type':'1'};
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
      final Notification_data = notificationCountFromJson(response.body);
      if (response.statusCode == 200) {
        final Notification_data = notificationCountFromJson(response.body);
        Notification_count=Notification_data.notificationCount.toString();
        // message = appointmentModel.message;
        // print('irfan'+message!);
        log(Notification_data.notificationCount.toString());
        notifyListeners();
      }
      // else if(mydoctordata.message==" No record found "){
      //   print('no data');
      //   My_Doctor_Class=[];
      //   notifyListeners();
      // }
      else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      }else{
        print(response.statusCode);
        print('abdul');
        print('error');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
