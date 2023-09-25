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
import 'filter_Using_Name_Response.dart';

class Get_Filter_Name_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;

  List<get_Report_Filter_Name_class> get_filter_name_ResponseClass = [];
  List<get_Report_Filter_Name_class> get Get_Filter_Name_Class => get_filter_name_ResponseClass;

  set   Get_Filter_Name_Class(List<get_Report_Filter_Name_class> value) {
    get_filter_name_ResponseClass = value;
    notifyListeners();
  }
  String? message;

  Future<void> Get_Filter_Name_data(String id) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Get_Report_by_name_filter;
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
      final filternamedata = filterUsingNameFromJson(response.body);
      if (response.statusCode == 200) {
        final filternamedata = filterUsingNameFromJson(response.body);
        Get_Filter_Name_Class = filternamedata.data ?? [];
        // message = appointmentModel.message;
        // print('irfan'+message!);
        log(filternamedata.data![0].patientName.toString());
        notifyListeners();
      }else if(filternamedata.message==" No record found "){
        print('no data');
        Get_Filter_Name_Class=[];
        notifyListeners();
      } else if (response.statusCode == 401) {
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
