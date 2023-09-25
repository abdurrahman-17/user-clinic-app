import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/add_family_member/add_family_member_response.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/view/family_member/family_member.dart';


class Add_Family_Member_Notifier extends BaseChangeNotifier {
  AddFamilyMember? addFamilyMember;

  Add_Family_Member_Notifier() {
  }



  Future<void> Add_famil_person(String id, String name,String age,String gender,String filepath,String filname,String filepath_report,String filname_report) async {
    final prefs=await SharedPreferences.getInstance();
    String token="";
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Add_Family_Member;
    print(url);
    final input = {'patient_id': id, 'name': name,'age':age,'gender':gender,'image':filepath,'filname':filname,'report':filepath_report,'filname':filname_report};
    print(input);

    //List<int> imagebytes=
    final request=http.MultipartRequest('POST',Uri.parse(url),);
    request.fields['patient_id']=id;
    request.fields['name']=name;
    request.fields['age']=age;
    request.fields['gender']=gender;
    filname.isEmpty?null:request.files.add(await http.MultipartFile.fromPath('image',filepath,filename: filname));
    filname_report.isEmpty?null:request.files.add(await http.MultipartFile.fromPath('report', filepath_report,filename: filname_report));
    request.headers.addAll({'Authorization': 'Bearer ${prefs.getString("token")}'});
    var response=await request.send();
    var responsed=await http.Response.fromStream(response);
    var responseData=json.decode(responsed.body.toString());
    // final response = await http.post(
    //   Uri.parse(url),
    //   body: (input),
    //   headers: {
    //     'Authorization': 'Bearer ${prefs.getString("token")}',
    //     'Accept': 'application/json'
    //   },
    // );
    super.isLoading = false;
    print(request);
    print("saad");
    print(response.statusCode);
    log(responseData.toString());

    if (response != null && response.statusCode == 200) {
      print('HI');
      print(responseData);

      try {
        final patientLoginResponse = AddFamilyMember.fromJson(jsonDecode(responsed.body));
        print('Yes');
        if (patientLoginResponse.status == true) {
          print('Me');
          Get.off(Family_member(), arguments: true);
          //Get.back();
        } else {
          appShowToast(patientLoginResponse.message!);
        }
      }
      catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }

  }

}
