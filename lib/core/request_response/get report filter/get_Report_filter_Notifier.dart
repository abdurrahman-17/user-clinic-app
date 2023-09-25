import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/get%20report%20filter/get_Report_filter_Response.dart';
import 'package:user_clinic_token_app/core/request_response/get_report/Get_Report_response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';

class GEt_Report_Filter_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;

  List<get_Report_Filter_class> get_report_filter_ResponseClass = [];
  List<get_Report_Filter_class> get Get_Report_Filter_Class => get_report_filter_ResponseClass;

  set   Get_Report_Filter_Class(List<get_Report_Filter_class> value) {
    get_report_filter_ResponseClass = value;
    notifyListeners();
  }
  String? message;

  Future<void> Get_Report_filter_data(String id,String date) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Get_Report_by_id_filter;
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
      print(response.statusCode);
      final filter_report_Data = getReportFilterFromJson(response.body);
      if (response.statusCode == 200) {

        final filter_report_Data = getReportFilterFromJson(response.body);
        Get_Report_Filter_Class = filter_report_Data.data ?? [];
        // message = appointmentModel.message;
        // print('irfan'+message!);
        // //log(appointmentModel.data![0].doctorName.toString());
        notifyListeners();
      } else if(filter_report_Data.message==" No record found "){
        print('no data');
        Get_Report_Filter_Class=[];
        notifyListeners();
      } else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      }else {
        appShowToast(message!);
        print('abdul');
        print('error');

      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
