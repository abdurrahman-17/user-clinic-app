import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/Add%20Appointment/add_Appointment_Response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/view/Token_Success/Token_success.dart';
import 'package:user_clinic_token_app/view/success_appointment/success.dart';
import '../../../utils/common/app_route_paths.dart';
import 'add_Token_Appointment_Response.dart';

class add_Token_Appointment_Notifier extends BaseChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  Add_Appointment_Data add_appointment_ResponseClass = Add_Appointment_Data();

  Add_Appointment_Data get Add_Appointment_ResponseClass =>
      add_appointment_ResponseClass;

  set Add_Appointment_ResponseClass(Add_Appointment_Data value) {
    add_appointment_ResponseClass = value;
    notifyListeners();
  }

  // List<AddedFamily> addedFamily_ResponseClass = [];
  // List<AddedFamily> get AddedFamilyResponseClass => addedFamily_ResponseClass;
  //
  // set   AddedFamilyResponseClass(List<AddedFamily> value) {
  //   addedFamily_ResponseClass = value;
  //   notifyListeners();
  // }

  Future<void> Add_Token_Appointment_class(String doctor_id, String days,
      String patient_id, String date, String schedule_type,
      String token_no, String description) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Add_Appointment;
    print(url);

    final input = {
      'doctor_id': doctor_id,
      'day': days,
      'patient_id': patient_id,
      'date': date,
      'schedule_type': schedule_type,
      'token_no': token_no,
      'description': description
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
    final add_Token_appointment_model_Response =
    addTokenAppointmentFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      // String? drname;
      // //String drspec='';
      // //String draddress='';
      // String? drimage;
      try {
        final add_Token_appointment_model_Response =
        addTokenAppointmentFromJson(response.body);
        if (add_Token_appointment_model_Response.status == true) {
          final String name=add_Token_appointment_model_Response.data!.patientName.toString();
          final String age=add_Token_appointment_model_Response.data!.age.toString();
          final String date=add_Token_appointment_model_Response.data!.date.toString();
          final String time=add_Token_appointment_model_Response.data!.day.toString();
          final String token=add_Token_appointment_model_Response.data!.tokenNo.toString();
          final String drname=add_Token_appointment_model_Response.data!.doctorInfo!.name.toString();
          final String drspec=add_Token_appointment_model_Response.data!.doctorInfo!.specialist.toString();
          final String draddress=add_Token_appointment_model_Response.data!.doctorInfo!.clinicAddress.toString();
          final String drimage=add_Token_appointment_model_Response.data!.doctorInfo!.image.toString();

          print(drname);
          // print(drimage);
          Get.to(Token_Suceess(),arguments: [
            {"name": name},
            {"age": age},
            {"date": date},
            {"time": time},
            {"token": token},
            {"drname": drname},
             {"drspec": drspec},
             {"draddress": draddress},
             {"drimage": drimage},
          ]);
          //Get.offAndToNamed(RoutePaths.Setting, arguments: true);
        } else {
          appShowToast(add_Token_appointment_model_Response.message!);
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
      appShowToast(add_Token_appointment_model_Response.message!);
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

