import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/homescreen/homescreen.dart';

import 'mobileUpdate_Response.dart';

class mobile_Update_Notifier extends BaseChangeNotifier {
  MobileUpdate? mobileUpdate;

  mobile_Update_Notifier() {
  }



  Future<void> mobile_update_setting(String password,String old_number,String new_number,String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token="";
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.mobile_update_setting;
    print(url);
    final input = {'password': password,'mobile_number':old_number,'new_mobile_number':new_number,'patient_id':id};
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
        'Accept': 'application/json'
      },
    );
    super.isLoading = false;
    log(response.body);
    final mobile_update_response =
    mobileUpdateFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        final mobile_update_response =
        mobileUpdateFromJson(response.body);
        if (mobile_update_response.status == true) {
          Get.offNamedUntil(RoutePaths.HomeScreen, (route) => false);
        } else {
          appShowToast(mobile_update_response.message!);
        }
      }
      catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }else {
      appShowToast(mobile_update_response.message!);
    }
  }

}
