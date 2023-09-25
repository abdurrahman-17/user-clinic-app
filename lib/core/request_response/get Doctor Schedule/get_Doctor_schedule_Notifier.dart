import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/get%20Doctor%20Schedule/get_Doctor_Schedule_Response.dart';
import 'package:user_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';

import '../../../utils/common/app_route_paths.dart';

class get_Doctor_Schedule_Notifier extends BaseChangeNotifier {
  final SharedPref _prefs = locator.get<SharedPref>();

  List doctor_details=[];
  bool isloading = false;
  add_Token_Appointment_Data doctor_Schedule_ResponseClass = add_Token_Appointment_Data();
  add_Token_Appointment_Data get Doctor_ScheduleResponseClass => doctor_Schedule_ResponseClass;

  set   Doctor_ScheduleResponseClass(add_Token_Appointment_Data value) {
    doctor_Schedule_ResponseClass = value;
    notifyListeners();
  }
  List<AddedFamily> addedFamily_ResponseClass = [];
  List<AddedFamily> get AddedFamilyResponseClass => addedFamily_ResponseClass;

  set AddedFamilyResponseClass(List<AddedFamily> value) {
    addedFamily_ResponseClass = value;
    notifyListeners();
  }
  List<Afternoon> getDoctorSchedules_morning = [];
  List<Afternoon> get GetDoctorSchedules_Morning => getDoctorSchedules_morning;

  set GetDoctorSchedules_Morning(List<Afternoon> value) {
    getDoctorSchedules_morning = value;
    notifyListeners();
  }
  List<Afternoon> getDoctorSchedules_afternoon = [];
  List<Afternoon> get GetDoctorSchedules_Afternoon => getDoctorSchedules_afternoon;

  set GetDoctorSchedules_Afternoon(List<Afternoon> value) {
    getDoctorSchedules_afternoon = value;
    notifyListeners();
  }
  List<Afternoon> getDoctorSchedules_evening = [];
  List<Afternoon> get GetDoctorSchedules_Evening => getDoctorSchedules_afternoon;

  set GetDoctorSchedules_Evening(List<Afternoon> value) {
    getDoctorSchedules_evening = value;
    notifyListeners();
  }
  List<Afternoon> getDoctorSchedules_night = [];
  List<Afternoon> get GetDoctorSchedules_Night => getDoctorSchedules_afternoon;

  set GetDoctorSchedules_Night(List<Afternoon> value) {
    getDoctorSchedules_night = value;
    notifyListeners();
  }
  // List morning_ResponseClass = [];
  // List get MorningResponseClass => morning_ResponseClass;
  //
  // set   MorningResponseClass(value) {
  //   morning_ResponseClass = value;
  //   notifyListeners();
  // }

  Future<void> get_Doctor_Schedule(int id,String days,String patient_id,String date) async {
    super.isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.get_Doctor_Schedule;
    print(url);
    try {
      final input = {'doctor_id': id.toString(),'days':days,'patient_id':patient_id,'date':date};
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
        print('check');
        print(response.statusCode);
        final  doctor_details= getDoctorScheduleFromJson(response.body);
        // print(doctor_details.data!.scheduleName.toString());
        // print(doctor_details.addedFamily!.length);
        Doctor_ScheduleResponseClass = doctor_details.data!;
        //print(Doctor_ScheduleResponseClass.morning);
        final addedfamily = getDoctorScheduleFromJson(response.body);
        AddedFamilyResponseClass = addedfamily.addedFamily!;
        final get_doctor_time = getDoctorScheduleFromJson(response.body);
        GetDoctorSchedules_Morning = get_doctor_time.doctorSchedule!.morning ?? [];
        GetDoctorSchedules_Afternoon = get_doctor_time.doctorSchedule!.afternoon ?? [];
        GetDoctorSchedules_Evening = get_doctor_time.doctorSchedule!.evening ?? [];
        GetDoctorSchedules_Night = get_doctor_time.doctorSchedule!.night ?? [];
        // print('abdul');
        // print(GetDoctorSchedules_Morning[0].time);
        // final Mor = getDoctorScheduleFromJson(response.body);
        // // MorningResponseClass = Mor.data!.thu!.morning;
        // print('irfan');
        // print(AddedFamilyResponseClass.length);
        //log(voucherTypeModel.data![0].id.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
    super.isLoading = false;
  }
}
