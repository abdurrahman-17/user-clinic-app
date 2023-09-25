class DataConstants {
  DataConstants._internal();

  static const LIVE_BASE_URL = 'https://almuhasabah.colanapps.in/admin/clinic2/public';
  //static const User_Image_Base_Url = '$LIVE_BASE_URL/uploads/app_users/';



  static const String Login = "/api/patient_login";
  static const String Register = "/api/patient_register";
  static const String Email_Otp = "/api/patient_sendotp";
  static const String pin_Otp = "/api/sendPatternOtp";
  static const String Verify_otp = "/api/patient_otpverify";
  static const String pin_Verify_otp = "/api/otpPaternVerification";
  static const String Change_new_password = "/api/patient_newpassword";
  static const String gender = "/api/patient_ageandgender";
  static const String carousel = "/api/get_doctor";
  static const String Drproifle = "/api/get_doctor_doctor_id";
  static const String Notification = "/api/update_notification";
  static const String password_change_setting = "/api/update_newpassword";
  static const String email_change_setting = "/api/update_email";
  static const String mobile_update_setting = "/api/update_mobile";
  static const String Add_Family_Member = "/api/add_family_member";
  static const String MY_appointment = "/api/get_all_appointment";
  static const String Past_appointment = "/api/patientDoneAppoinment";
  static const String list_family_member = "/api/patientfamilydetail";
  static const String Pharamacy = "/api/get_appointment_detail";
  static const String Get_Report = "/api/GetpatientReports";
  static const String Get_Report_by_id = "/api/GetpatientReportbyid";
  static const String family_list_by_id = "/api/familyMemberFilterAPI";
  static const String Get_Report_by_id_filter = "/api/Get_all_patientReports";
  static const String Get_Report_by_name_filter = "/api/healthrecordnamewise";
  static const String My_Doctor = "/api/get_Patient_doctor";
  static const String Get_Appointment_by_id_filter = "/api/Get_appointment_filter";
  static const String Terms_And_Conditions = "/api/termsCondtion";
  static const String Privacy_Policy = "/api/PatientprivacyPolicy";
  static const String About_Us = "/api/PatientAboutUs";
  static const String Family_Member_Delete = "/api/patientFamilyMemberDelete";
  static const String UpdatePatientProfile = "/api/patient_updateProfile";
  static const String UpdateFamilyProfile = "/api/familyMemberProfileUpdate";
  static const String get_Doctor_Schedule = "/api/get_doctor_schedule_day";
  static const String Add_Appointment = "/api/add_appointment";
  static const String Update_Appointment = "/api/editpatientAppoinment";
  static const String get_Token_Doctor_Schedule = "/api/get_doctor_schedule_day_token_based";
  static const String Cancel_Appointment = "/api/CancelAppoinment";
  static const String No_Image_PlaceHolder = "/api/get_NoImageFoundPleacholder";
  static const String All_Notification = "/api/get_all_notification";
  static const String read_Notification = "/api/read_notification";
  static const String Notification_count = "/api/notification_count";



}

