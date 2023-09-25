import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/login/loginresponse.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/homescreen/homescreen.dart';

import 'package:user_clinic_token_app/view/onboard_screens/Onboarding_Screen.dart';

class LoginNotifier extends BaseChangeNotifier {
  LoginResponse? loginResponse;

  LoginNotifier() {
  }



  Future<void> PatientLogin(String email, String password,String devicetype,String FCM) async {
    String token="";
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Login;
    print(url);
    final input = {'email': email, 'password': password,'device_type':devicetype,'device_token':FCM};
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {
        //'Authorization': 'Bearer ${prefs.getToken()}',
        'Accept': 'application/json'
      },
    ).timeout(const Duration(seconds: 10),
    onTimeout: (){
      print("done");
       throw TimeoutException('The connection has timed out, Please try again!');
    }
    );
    super.isLoading = false;
    log(response.body);
    print(response.statusCode);
    final patientLoginResponse =
    loginResponseFromJson(response.body);

    if (response != null && response.statusCode == 200) {
      //String? age= null;
      final patientLoginResponse =
      loginResponseFromJson(response.body);
      try {
        if (patientLoginResponse.status == true&&patientLoginResponse.data!.age==null) {
          print(patientLoginResponse.data!.apiToken!);
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("token", patientLoginResponse.data!.apiToken!);
          MySharedPreferences.user_clinic().setid('id',patientLoginResponse.data!.id!);
          MySharedPreferences.user_clinic().setusername("name", patientLoginResponse.data!.name.toString());
          MySharedPreferences.user_clinic().setEmail("email", patientLoginResponse.data!.email.toString());
          MySharedPreferences.user_clinic().setToken("token", patientLoginResponse.data!.apiToken.toString());
          MySharedPreferences.user_clinic().setage("age", patientLoginResponse.data!.age.toString());
          MySharedPreferences.user_clinic().setImage("image", patientLoginResponse.data!.image.toString());
          MySharedPreferences.user_clinic().setPin('pin', patientLoginResponse.data!.pinAuthentication.toString());
          MySharedPreferences.user_clinic().setaddress('address', patientLoginResponse.data!.address.toString());
          MySharedPreferences.user_clinic().setgender('gender',patientLoginResponse.data!.gender.toString());

          //MySharedPreferences.user_clinic().setBooleanValue("logged", true);
          prefs.setInt("id", patientLoginResponse.data!.id!);
          //MySharedPreferences.instance.setid("id",patientLoginResponse.data!.id!);
          print(prefs.getInt("id"));
           Get.off(OnboardingScreen(),arguments: [{'email':patientLoginResponse.data!.email.toString()}]);
        }
        else if(patientLoginResponse.status == true&&patientLoginResponse.data!.age!=null){
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", patientLoginResponse.data!.apiToken!);
        MySharedPreferences.user_clinic().setusername("name", patientLoginResponse.data!.name.toString());
        MySharedPreferences.user_clinic().setEmail("email", patientLoginResponse.data!.email.toString());
        MySharedPreferences.user_clinic().setToken("token", patientLoginResponse.data!.apiToken.toString());
        MySharedPreferences.user_clinic().setage("age", patientLoginResponse.data!.age.toString());
        MySharedPreferences.user_clinic().setImage("image", patientLoginResponse.data!.image.toString());
        MySharedPreferences.user_clinic().setid('id',patientLoginResponse.data!.id!);
        MySharedPreferences.user_clinic().setPin('pin', patientLoginResponse.data!.pinAuthentication.toString());
        MySharedPreferences.user_clinic().setaddress('address', patientLoginResponse.data!.address.toString());
        MySharedPreferences.user_clinic().setgender('gender', patientLoginResponse.data!.gender.toString());

        //MySharedPreferences.instance.setid("id",patientLoginResponse.data!.id!);
        Get.off(HomeScreen());
        }
        else{
          appShowToast(patientLoginResponse.message.toString());
        }
      }
      catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }
    else {
      appShowToast(patientLoginResponse.message.toString());
    }
  }

}
