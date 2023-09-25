import 'dart:developer';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/privacyPolicy/privacyPolicy_Response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/view/family_member/family_member.dart';
import '../../../utils/common/app_route_paths.dart';
import 'family_Member_Delete_Response.dart';

class Family_Member_Delete_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  //
  // Date termsAndConditions_Date_ResponseClass = Date();
  // Date get TermsAndConditions_Date_Class => termsAndConditions_Date_ResponseClass;
  //
  // set   TermsAndConditions_Date_Class(Date value) {
  //   termsAndConditions_Date_ResponseClass = value;
  //   notifyListeners();
  // }
  DeleteFamilyMember family_Member_Delete_ResponseClass = DeleteFamilyMember();
  DeleteFamilyMember get Family_Member_Delete_Class => DeleteFamilyMember();

  set   Family_Member_Delete_Class(DeleteFamilyMember value) {
    family_Member_Delete_ResponseClass = value;
    notifyListeners();
  }

  Future<void> Family_Member_data(String id,String family_member_id) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Family_Member_Delete;
    print(url);
    try {
         final input = {'patient_id': id,'family_member_id':family_member_id};
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
        final appointmentModel = deleteFamilyMemberFromJson(response.body);
        Family_Member_Delete_Class = appointmentModel;
        //print(About_Us_Class.privacyPolicy.toString());
        //TermsAndConditions_Date_Class = appointmentModel.date!;
        //log(appointmentModel.data![0].doctorName.toString());
        notifyListeners();
        Get.off(Family_member(),);
      } else if (response.statusCode == 401) {
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
