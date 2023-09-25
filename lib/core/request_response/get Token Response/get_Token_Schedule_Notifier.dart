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
import 'get_Token_Schedule_response.dart';

class get_Doctor_Token_Schedule_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<add_Token_Appointment_Data> doctor_token_Schedule_ResponseClass = [];
  List<add_Token_Appointment_Data> get Doctor_Token_ScheduleResponseClass => doctor_token_Schedule_ResponseClass;

  set   Doctor_Token_ScheduleResponseClass(List<add_Token_Appointment_Data> value) {
    doctor_token_Schedule_ResponseClass = value;
    notifyListeners();
  }
  List<FamilyMember> addedFamily_ResponseClass = [];
  List<FamilyMember> get AddedFamilyResponseClass => addedFamily_ResponseClass;

  set   AddedFamilyResponseClass(List<FamilyMember> value) {
    addedFamily_ResponseClass = value;
    notifyListeners();
  }

  Future<void> get_Doctor_token_Schedule(String id,String days,String patient_id) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.get_Token_Doctor_Schedule;
    print(url);
    try {
      final input = {'doctor_id': id,'days':days,'patient_id':patient_id};
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
        final voucherTypeModel = getDoctorScheduleTokenFromJson(response.body);
        Doctor_Token_ScheduleResponseClass = voucherTypeModel.data!;
        final addedfamily = getDoctorScheduleTokenFromJson(response.body);
        AddedFamilyResponseClass = addedfamily.familyMembers!;
        log(voucherTypeModel.data![0].id.toString());
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
