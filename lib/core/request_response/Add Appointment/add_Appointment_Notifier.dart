import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/view/home_screen_new/home_screen.dart';
import 'package:user_clinic_token_app/view/success_appointment/success.dart';

import '../../../utils/common/app_route_paths.dart';
import 'add_Appointment_Response.dart';

class add_Appointment_Notifier extends BaseChangeNotifier {


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

  Future<void> Add_Appointment_class(
      int doctor_id,
      String days,
      int patient_id,
      String date,
      int schedule_type,
      String appointment_time,
      String description
      ) async {
    super.isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Add_Appointment;
    print(url);

    final input = {
      'doctor_id': doctor_id.toString(),
      'day': days.toString(),
      'patient_id': patient_id.toString(),
      'date': date.toString(),
      'schedule_type': schedule_type.toString(),
      'appointment_time': appointment_time.toString(),
      'description': description.toString()
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
    final add_Appointment_model_Response = addAppointmentFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        final add_Appointment_model_Response = addAppointmentFromJson(response.body);
        if (add_Appointment_model_Response.status == true) {
          final String name=add_Appointment_model_Response.data!.patientName.toString();
          final String age=add_Appointment_model_Response.data!.age.toString();
          final String date=add_Appointment_model_Response.data!.date.toString();
          final String time=add_Appointment_model_Response.data!.day.toString();
          final String app_time=add_Appointment_model_Response.data!.appointmentTime.toString();
          final String drname=add_Appointment_model_Response.data!.doctorInfo!.name.toString();
          final String drspec=add_Appointment_model_Response.data!.doctorInfo!.specialist.toString();
          final String draddress=add_Appointment_model_Response.data!.doctorInfo!.clinicAddress.toString();
          final String drimage=add_Appointment_model_Response.data!.doctorInfo!.image.toString();

          print(drname);
          // print(drimage);
          Get.to(Suceess(),arguments: [
            {"name": name},
            {"age": age},
            {"date": date},
            {"time": app_time},
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
    super.isLoading = false;
  }
}
