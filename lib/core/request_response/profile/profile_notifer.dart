import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/profile/profile_response.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';

class Profile_Notifier extends BaseChangeNotifier {
  GetdoctorByid getdoctor_id = GetdoctorByid();
  bool isloading = false;

  getPostData(context) async {
    //isloading = true;
    getdoctor_id = await DrProfile_notifier(context);
    //isloading = false;

    notifyListeners();
  }

  Future<GetdoctorByid> DrProfile_notifier(String id) async {
    final prefs = await SharedPreferences.getInstance();
    GetdoctorByid? result;
    //super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Drproifle;
    print(url);
    final input = {'doctor_id': id};
    print(input);
    // var data = json.encode(input);
    final response = await http.post(
      Uri.parse(url),
      body: input,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
        'Accept': 'application/json'
      },
    );
    //super.isLoading = false;
    log(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = GetdoctorByid.fromJson(item);
      //prefs.setString("name", result.data![0].name.toString());
      MySharedPreferences.instance.setDrname("name", result.data![0].name.toString());
      print(MySharedPreferences.instance.getDrname("name"));
      // print(GetdoctorByid
      //     .fromJson(item)
      //     .data![0].name);
      print(result.data![0].experience);
    }
    return result!;
  }

}