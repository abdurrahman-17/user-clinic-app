import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/update_patient_profile/updatePatientProfileResponse.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/homescreen/homescreen.dart';

class UpdatePatientProfileNotifier extends BaseChangeNotifier {
  UpdatePatientProfileResponse? updatePatientProfileResponse;

  UpdatePatientProfileNotifier() {
  }



  Future<void> patientUpdateProfile(String uID, String fName, String age, String gender,String filepath,String filename) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.UpdatePatientProfile;
    print(url);
     final input = {'user_id':uID.toString(),'first_name': fName,'age':age.toString(),'gender':gender};
     print(input);
    final request=http.MultipartRequest('POST',Uri.parse(url),);
    request.fields['user_id']=uID.toString();
    request.fields['first_name']=fName.toString();
    age.isEmpty?null:request.fields['age']=age.toString();
    request.fields['gender']=gender.toString();
    filename.isEmpty?null:request.files.add(await http.MultipartFile.fromPath('image',filepath,filename: filename));
    //request.files.add(await http.MultipartFile.fromPath('report', filepath_report,filename: filname_report));
    request.headers.addAll({'Authorization': 'Bearer ${prefs.getString("token")}'});
    var response=await request.send();
    var responsed=await http.Response.fromStream(response);
    var responseData=json.decode(responsed.body);
    // final response = await http.post(
    //   Uri.parse(url),
    //   body: (input),
    //   headers: {
    //     'Authorization': 'Bearer 252|4yXziQzGwUNryFWdxgwUGd9XuM6muHUcHSH6S7dw',
    //     'Accept': 'application/json'
    //   },
    // );
    super.isLoading = false;
    //log(responseData);
    print('check');
    print(responseData);
    print(response.statusCode);
    if (response != null && response.statusCode == 200) {
      try {
        final updatePatientProfileResponse =UpdatePatientProfileResponse.fromJson(jsonDecode(responsed.body));
        if (updatePatientProfileResponse.status == true) {
          MySharedPreferences.user_clinic().setusername("name", updatePatientProfileResponse.data!.name.toString());
          MySharedPreferences.user_clinic().setage("age", updatePatientProfileResponse.data!.age.toString());
          MySharedPreferences.user_clinic().setgender('gender', updatePatientProfileResponse.data!.gender.toString());
          MySharedPreferences.user_clinic().setImage("image", updatePatientProfileResponse.data!.image.toString());
          print('check');
          Get.offAll(HomeScreen());
        } else {
          appShowToast(updatePatientProfileResponse.message!);
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