import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/profile/profile_response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';

class DrProfileNotifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<No_of_appo> drProfileResponseClass = [];
  List<No_of_appo> get DrProfileResponseClass => drProfileResponseClass;

  set   DrProfileResponseClass(List<No_of_appo> value) {
    drProfileResponseClass = value;
    notifyListeners();
  }  DoctorAvailable doctor_timeResponseClass = DoctorAvailable();
  DoctorAvailable get Doctor_timeResponseClass => doctor_timeResponseClass;

  set   Doctor_timeResponseClass(DoctorAvailable value) {
    doctor_timeResponseClass = value;
    notifyListeners();
  }

  Future<void> getDrProfile(String id) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Drproifle;
    print(url);
    try {
      final input = {'doctor_id': id};
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
        final voucherTypeModel = getdoctorByidFromJson(response.body);
        DrProfileResponseClass = voucherTypeModel.data!;
        Doctor_timeResponseClass = voucherTypeModel.doctorAvailable!;
        log(voucherTypeModel.data![0].name.toString());
        notifyListeners();
      }else if (response.statusCode == 401) {
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
