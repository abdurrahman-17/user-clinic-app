import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/login/loginresponse.dart';
import 'package:user_clinic_token_app/core/request_response/notification_on_off/notification_response.dart';
import 'package:user_clinic_token_app/utils/app_message.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';

import 'package:user_clinic_token_app/view/onboard_screens/Onboarding_Screen.dart';

class NotificationNotifier extends BaseChangeNotifier {
  NotificationModel? notificationModel;

  NotificationNotifier() {
  }



  Future<void> Notification_Setting(String userId, String notification) async {
    final prefs = await SharedPreferences.getInstance();
    String token="";
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Notification;
    print(url);
    final input = {'user_id': userId, 'notification': notification};
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
        'Accept': 'application/json'
      },
    );
    super.isLoading = false;
    log(response.body);

    if (response != null && response.statusCode == 200) {
      try {
        final Notification_model_Response =
        notificationModelFromJson(response.body);
        if (Notification_model_Response.status == true) {

        } else {
          appShowToast(Notification_model_Response.message!);
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
