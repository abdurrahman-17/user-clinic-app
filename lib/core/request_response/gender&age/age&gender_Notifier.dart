import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'gender&age_response..dart';

class age_number_Notifier extends BaseChangeNotifier {
  AddGenderAge? addGenderAge;
  // age_number_Notifier() {
  //
  // }
  Future<void> AddGender(String email,int age,String gender,String pin_authentication) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.gender;
    print(url);
    final input = {'email': email,'age':age.toString(),'gender':gender.toString(),'pin_authentication':pin_authentication};
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
        'Accept': 'application/json'
      },
    );
    print("saad");
    print(prefs.getString('token'));
    super.isLoading = false;
    log(response.body);

    if (response != null && response.statusCode == 200) {
      try {
        final ageGenderResponse =
        addGenderAgeFromJson(response.body);
        if (ageGenderResponse.status == true) {
          MySharedPreferences.user_clinic().setage("age", ageGenderResponse.data![0].age.toString());
          MySharedPreferences.user_clinic().setPin('pin', ageGenderResponse.data![0].pinAuthentication.toString());
          MySharedPreferences.user_clinic().setgender('gender',ageGenderResponse.data![0].gender.toString());
          //MySharedPreferences.user_clinic().setToken("token", ageGenderResponse.data!.apiToken.toString());
          Get.offAllNamed(RoutePaths.HomeScreen, arguments: true);
        } else {
          appShowToast(ageGenderResponse.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }
  }

}
