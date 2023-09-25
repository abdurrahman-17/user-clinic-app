import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/list_family_member/list_family_member_response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';

class List_family_Member extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  ParentDetails parent_list_ResponseClass = ParentDetails();


  ParentDetails get Parent_list_ResponseClass => parent_list_ResponseClass;

  set Parent_list_ResponseClass(ParentDetails value) {
    parent_list_ResponseClass = value;
    notifyListeners();
  }

  List<list_family> family_list_ResponseClass = [];
  List<list_family> get Family_list_Class => family_list_ResponseClass;

  set   Family_list_Class(List<list_family> value) {
    family_list_ResponseClass = value;
    notifyListeners();
  }

  Future<void> Family_list(String id) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.list_family_member;
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
        final appointmentModel = familyMemberResponseFromJson(response.body);
        Parent_list_ResponseClass=appointmentModel.parentDetails!;
        Family_list_Class = appointmentModel.data!;
        log(appointmentModel.data![0].name.toString());

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
