import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/carousel/DoctorList.dart';
import 'package:user_clinic_token_app/core/request_response/profile/profile_response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';
import 'no_Image_Response.dart';

class No_Image extends BaseChangeNotifier {
  //final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
   String no_ImageResponseClass ='';
   get No_ImageResponseClass => no_ImageResponseClass;

  set   No_ImageResponseClass( value) {
    no_ImageResponseClass = value;
    notifyListeners();
  }
  // DoctorAvailable doctor_timeResponseClass = DoctorAvailable();
  // DoctorAvailable get Doctor_timeResponseClass => doctor_timeResponseClass;
  //
  // set   Doctor_timeResponseClass(DoctorAvailable value) {
  //   doctor_timeResponseClass = value;
  //   notifyListeners();
  // }

  Future<void> getNo_Image() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.No_Image_PlaceHolder;
    print(url);
    try {
      //final input = {'doctor_id': id};
      //print(input);
      final response = await http.get(
        Uri.parse(url),
        //body: input,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
          //'Authorization': 'Bearer ${_prefs.getToken()}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final voucherTypeModel = noImageFromJson(response.body);
        No_ImageResponseClass = voucherTypeModel.data;
        //Doctor_timeResponseClass = voucherTypeModel.doctorAvailable!;
        notifyListeners();
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


//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
// import 'package:user_clinic_token_app/core/data_constants.dart';
// import 'DoctorList.dart';
// class Doctor extends BaseChangeNotifier {
//
//   DoctorList doctorList=DoctorList();
//   bool isloading=false;
//
//   getPostData(context) async {
//     isloading = true;
//     doctorList =await getSinglePostData(context);
//     isloading = false;
//
//     notifyListeners();
//   }
// }
//
//   Future<DoctorList> getSinglePostData(context) async {
//     final prefs = await SharedPreferences.getInstance();
//      DoctorList? result;
//     try {
//       //super.isLoading = true;
//          String url = DataConstants.LIVE_BASE_URL + DataConstants.carousel;
//          print(url);
//       final response = await http.get(
//              Uri.parse(url),
//              // body: (input),
//              headers: {
//                'Authorization': 'Bearer ${prefs.getString('token')}',
//                'Accept': 'application/json'
//              },
//            );
//       print(response.body);
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         final item =json.decode(response.body);
//         result=DoctorList.fromJson(item);
//         print(DoctorList.fromJson(item).data![0].name);
//         print(result.data![0].experience);
//       } else {
//         print("Data not found",);
//       }
//     } catch (e) {
//       print(e);
//     }
//     return result!;
//   }


