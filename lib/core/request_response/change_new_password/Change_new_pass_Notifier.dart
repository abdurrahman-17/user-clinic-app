import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'Change_new_Pass_Response.dart';
class Change_new_Pass_Notifier extends BaseChangeNotifier {

  Change_new_Pass_Notifier() {

  }



  Future<void> change_pass(String email, String password,String cfm_password) async {
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Change_new_password;
    print(url);
    final input = {'email': email, 'password': password,'cfm_password':cfm_password};
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {
        //'Authorization': 'Bearer ${prefs.getToken()}',
        'Accept': 'application/json'
      },
    );
    super.isLoading = false;
    log(response.body);
    final change_password =
    changeNewPasswrodFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        final change_password =
        changeNewPasswrodFromJson(response.body);
        if (change_password.status == true) {
          Get.offAllNamed(RoutePaths.LOGIN, arguments: true);
        } else {
          appShowToast(change_password.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }else {
      appShowToast(change_password.message!);
    }
  }

}
