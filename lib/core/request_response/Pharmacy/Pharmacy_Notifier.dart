import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/Pharmacy/Pharmacy_response.dart';
import 'package:user_clinic_token_app/core/request_response/list_family_member/list_family_member_response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';

class Pharmacy_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<Pharmacy_class> pharmacy_class_ResponseClass = [];
  List<Pharmacy_class> get Pharmacy_class_ => pharmacy_class_ResponseClass;

  set   Pharmacy_class_(List<Pharmacy_class> value) {
    pharmacy_class_ResponseClass = value;
    notifyListeners();
  }

  Future<void> Get_Appointment(String id) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Pharamacy;
    print(url);
    try {
      final input = {'appointment_id': id};
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
        final PharmacyModel = pharmacyResponseFromJson(response.body);
        Pharmacy_class_ = PharmacyModel.data!;
        //log(appointmentModel.data![0].name.toString());
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
