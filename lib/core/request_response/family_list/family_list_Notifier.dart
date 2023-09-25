import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/Get_report_By_Id/Get_Report_Byid_Response.dart';
import 'package:user_clinic_token_app/core/request_response/get_report/Get_Report_response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';
import 'family_List_Response.dart';

class family_List_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;

  List<Family_list> family_List_ResponseClass = [];
  List<Family_list> get Family_List_Class => family_List_ResponseClass;

  set   Family_List_Class(List<Family_list> value) {
    family_List_ResponseClass = value;
    notifyListeners();
  }

  Future<void> family_List_data(String id) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.family_list_by_id;
    print(url);
    try {
      final input = {'parent_id': id};
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
        final appointmentModel = familyFilterFromJson(response.body);
        Family_List_Class = appointmentModel.data!;
        //log(appointmentModel.data![0].doctorName.toString());
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
