import 'dart:developer';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/update%20Token/update_Token_Response.dart';
import 'package:user_clinic_token_app/core/request_response/update_appointment/update_Appointment_Response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/view/update_Token_Appointment_done/update_Token_Appointment_done.dart';

import '../../../utils/common/app_route_paths.dart';

class update_Token_Notifier extends BaseChangeNotifier {


  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  Update_Token_Data update_token_ResponseClass = Update_Token_Data();

  Update_Token_Data get Update_Token_ResponseClass =>
      update_token_ResponseClass;

  set Update_Token_ResponseClass(Update_Token_Data value) {
    update_token_ResponseClass = value;
    notifyListeners();
  }

  // List<AddedFamily> addedFamily_ResponseClass = [];
  // List<AddedFamily> get AddedFamilyResponseClass => addedFamily_ResponseClass;
  //
  // set   AddedFamilyResponseClass(List<AddedFamily> value) {
  //   addedFamily_ResponseClass = value;
  //   notifyListeners();
  // }

  Future<void> Update_Token_class(
      String app_id,
      String days,
      String patient_id,
      String date,
      //String schedule_type,
      String token,
      //String description
      ) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Update_Appointment;
    print(url);

    final input = {
      'appointment_id': app_id,
      'day': days,
      'patient_id': patient_id,
      'date': date,
      //'schedule_type': schedule_type,
      'token_no': token,
      //'description': description
    };
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
    print(response.statusCode);
    final add_Appointment_model_Response = updateTokenFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        final add_Appointment_model_Response = updateAppointmentFromJson(response.body);
        if (add_Appointment_model_Response.status == true) {
          print('Booked');
          final String name=add_Appointment_model_Response.data!.patientName.toString();
          final String age=add_Appointment_model_Response.data!.age.toString();
          final String date=add_Appointment_model_Response.data!.date.toString();
          final String time=add_Appointment_model_Response.data!.day.toString();
          final String token=add_Appointment_model_Response.data!.tokenNo.toString();
          final String drname=add_Appointment_model_Response.data!.doctorInfo!.name.toString();
          final String drspec=add_Appointment_model_Response.data!.doctorInfo!.specialist.toString();
          final String draddress=add_Appointment_model_Response.data!.doctorInfo!.clinicAddress.toString();
          final String drimage=add_Appointment_model_Response.data!.doctorInfo!.image.toString();

          print(drname);
          // print(drimage);
          Get.to(update_token_done_page(name: name, age: age, time: time, date: date, drname: drname, drspec: drspec, drimage: drimage, draddress: draddress, token: token),
              arguments: [
            {"name": name},
            {"age": age},
            {"date": date},
            {"time": token},
            {"drname": drname},
            {"drspec": drspec},
            {"draddress": draddress},
            {"drimage": drimage},
          ]);
        } else {
          appShowToast(add_Appointment_model_Response.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }else {
      appShowToast(add_Appointment_model_Response.message!);
    }

    // if (response.statusCode == 200) {
    //   final voucherTypeModel = addAppointmentFromJson(response.body);
    //   Add_Appointment_ResponseClass = voucherTypeModel.data!;
    //   //log(voucherTypeModel.data![0].id.toString());
    //   print('abdul');
    //   print('irfan');
    //   if(voucherTypeModel.status==true){
    //     print('abdul');
    //     Get.to(Suceess);
    //   }else{
    //     print('sry');
    //   }
    //   print('irfan');
    // } else if (response.statusCode == 401) {
    //   appShowToast('You are unauthorized, please login again');
    // } else {
    //   print('error');
    // }
    // } catch (e) {
    //   print(e);
    // }
    isLoading = false;
  }
}
