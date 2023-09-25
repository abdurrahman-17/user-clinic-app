import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/DATE/date_picker_widget.dart';
import 'package:user_clinic_token_app/core/request_response/get%20Doctor%20Schedule/get_Doctor_schedule_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/update_appointment/update_Appointment_Notifier.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';

class Update_appointment extends StatefulWidget {
  DateTime? selectedDate;
  final app_id;
  final doctor_id;
  Update_appointment({
    Key? key,
    required this.app_id,required this.doctor_id,
  }) : super(key: key);

  @override
  _Update_appointmentState createState() => _Update_appointmentState();
}

class Tech {
  String label;

  //Color color;
  Tech(
      this.label,
      );
}

class Gender {
  String label;
  //Color color;
  Gender(
      this.label,
      );
}

class _Update_appointmentState extends State<Update_appointment> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  get_Doctor_Schedule_Notifier provider = get_Doctor_Schedule_Notifier();
  update_Appointment_Notifier provider1 = update_Appointment_Notifier();
  TextEditingController _problem = TextEditingController();
  String valueselected = '';
  DateTime? selectedDate;
  DateTime? selectedDates;
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  String dateFormat = DateFormat('MMMM').format(DateTime.now());
  String? formatted;
  String outputDate = '';
  String? outputDatedate;
  String selected = '';
  int? data;
  int? morning;
  bool appList = false;
  String? selectedValue;
  List<String> chips = <String>[];
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String id = '';
  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance.getid("id").then((value) => setState(() {
      id = value.toString();
      print('irfan');
      print(id);
    }));
    selectedDate = DateTime.now();
    date();
    print('irfan' + _selectedValue.toString());
    Future.delayed(Duration.zero, () {
      provider.get_Doctor_Schedule(
          widget.doctor_id, outputDate, id, outputDatedate.toString());
      provider.notifyListeners();
      Future.delayed(Duration(seconds: 5), () {
        print('object');
        print(provider.doctor_Schedule_ResponseClass.doctorId);
      });
    });
  }

  void date() {
    //final DateFormat formatter=DateFormat("dd-MMMM-yyy");
    // formatted=formatter.format();
    // print(formatted);
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate =
    inputFormat.parse(_selectedValue.toString()); // <-- dd/MM 24H format

    var outputFormat = DateFormat('E');
    outputDate = outputFormat.format(inputDate).toLowerCase();
    var outputFormatdate = DateFormat('yyyy-MM-dd');
    outputDatedate = outputFormatdate.format(inputDate);
    print('irfan' + outputDate);
    print('abdul' +
        outputDatedate.toString()); // 12/31/2000 11:59 PM <-- MM/dd 12H format
  }

  int? selectedIndex;
  int? selectedIndex2;
  int? selectedIndex3;
  int? selectedIndex4;
  List<Gender> _chipsList2 = [
    Gender(
      "Male",
    ),
    Gender(
      "Female",
    ),
  ];
  List<Tech> _chipsList = [
    Tech(
      "08:30AM",
    ),
    Tech(
      "09:00AM",
    ),
    Tech(
      "09:30AM",
    ),
    Tech(
      "10:00AM",
    ),
    Tech(
      "10:30AM",
    ),
    Tech(
      "11:00AM",
    ),
    Tech(
      "05:30PM",
    ),
    Tech(
      "06:00PM",
    ),
    Tech(
      "06:30PM",
    ),
    Tech(
      "07:00PM",
    ),
    Tech(
      "07:30PM",
    ),
    Tech(
      "08:00PM",
    ),
  ];

  //String? selectedValue;
  var items = [
    'Mohammed Saad',
    'Shadab Ahmed',
    'Mohammed Irfan',
    'Abdul Rahman',
    'Nadeem Ahmed',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<update_Appointment_Notifier>(
      builder: (context, providers, _) {
        this.provider1 = providers;
        return ModalProgressHUD(
            inAsyncCall: providers.isLoading,
            child: Scaffold(
              backgroundColor: Colors.white,
              // appBar: PreferredSize(
              //     preferredSize: Size.fromHeight(60),
              //     child: buildAppBar(context)),
              body: _buildBody(context,providers),
            ));
      },
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        'New Appointment',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context,update_Appointment_Notifier providers) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backButton(context),
                  buildDateSelector(context),
                  buildSelectDate(context),
                  Consumer<get_Doctor_Schedule_Notifier>(
                      builder: (context, provider, _) {
                        this.provider = provider;
                        return ModalProgressHUD(
                          inAsyncCall: provider.isloading,child:provider.isLoading?Center(child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(color: Colors.blue,),
                        )):Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildAvailableTime(context),
                            buildTimeList(context),
                            buildAfternoonTime(context),
                            buildAfternoonList(context),
                            buildEveningTime(context),
                            buildEveningList(context),
                            buildNightTime(context),
                            buildNightList(context),
                            buildpatientdetails(context),
                          ],
                        ),
                        );}
                  ),
                  // buildAge(context),
                  // buildGender(context),
                  Expanded(child: Container()),
                  buildButton(context,providers),
                ],
              ),
            ),
          ),
        );
      });
  }

  Widget backButton(context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left:6),
                    child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.black,),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,right: MediaQuery.of(context).size.height*0.03 ),
            child: Text( 'Update Appointment',
              style: TextStyle(fontSize: 18, color: Colors.black),),
          ),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
  Widget buildDateSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 25),
      child: Row(
        children: [
          Text(
            'Select Date',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 30,
          )
        ],
      ),
    );
  }

  Widget buildSelectDate(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text("You Selected:"),
          // Padding(
          //   padding: EdgeInsets.all(10),
          // ),
          // Text(_selectedValue.toString()),
          // Padding(
          //   padding: EdgeInsets.all(20),
          // ),
          Container(
            child: DatePicker(
              DateTime.now(),
              width: 65,
              height: 90,
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: Color(0xff4889FD),
              selectedTextColor: Colors.white,
              dateTextStyle: TextStyle(
                color: Colors.black,
              ),
              dayTextStyle: TextStyle(
                color: Colors.black,
              ),
              // inactiveDates: [
              //   DateTime.now().add(Duration(days: 3)),
              //    DateTime.now().add(Duration(days: 4)),
              //    DateTime.now().add(Duration(days: 7))
              // ],
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;
                  print(_selectedValue.toString());
                  var inputFormat = DateFormat('yyyy-MM-dd');
                  var inputDate = inputFormat
                      .parse(_selectedValue.toString()); // <-- dd/MM 24H format

                  var outputFormat = DateFormat('E');
                  outputDate = outputFormat.format(inputDate).toLowerCase();
                  var outputFormatdate = DateFormat('yyyy-MM-dd');
                  outputDatedate = outputFormatdate.format(inputDate);
                  print('abdul' + outputDate); // 12
                  print('irfan' + outputDatedate!); // 12
                  provider.get_Doctor_Schedule(
                      widget.doctor_id, outputDate, id, outputDatedate.toString());
                  Future.delayed(Duration(seconds: 5), () {
                    print(provider.doctor_Schedule_ResponseClass.doctorId);
                    print(provider.doctor_Schedule_ResponseClass.scheduleName);
                  });
                  // for(int a=0;a<provider.doctor_Schedule_ResponseClass.length;a++){
                  //   for(int b=0;b<provider.doctor_Schedule_ResponseClass[a].tokenTime!.length;b++)
                  //   {
                  //     if(provider.doctor_Schedule_ResponseClass[a].fromSession=='Evening'){
                  //       data=provider.doctor_Schedule_ResponseClass[a].tokenTime![b].length;
                  //       print(data);
                  //       print('irfan');
                  //     }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAvailableTime(BuildContext context) {
    return provider.getDoctorSchedules_morning.isEmpty&&
        provider.getDoctorSchedules_afternoon.isEmpty&&
        provider.getDoctorSchedules_evening.isEmpty&&
        provider.getDoctorSchedules_night.isEmpty?Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          height: 100,
          child: Center(child: Text('Doctor is Not Available in this date'))),
    ) :provider.getDoctorSchedules_morning.isEmpty
        ?Container():Padding(
      padding: const EdgeInsets.only(top: 30, left: 25),
      child: Text(
        'Morning Time',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }

  Widget buildAfternoonTime(BuildContext context) {
    return  provider.getDoctorSchedules_afternoon.isEmpty
        ?Container():Padding(
      padding: const EdgeInsets.only(top: 30, left: 25),
      child: Text(
        'Aternoon Time',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }
  Widget buildEveningTime(BuildContext context) {
    return  provider.getDoctorSchedules_evening.isEmpty
        ?Container():Padding(
      padding: const EdgeInsets.only(top: 30, left: 25),
      child: Text(
        'Evening Time',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }
  Widget buildNightTime(BuildContext context) {
    return  provider.getDoctorSchedules_night.isEmpty
        ?Container():Padding(
      padding: const EdgeInsets.only(top: 30, left: 25),
      child: Text(
        'Night Time',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }

  Widget buildTimeList(BuildContext context) {
    return provider.getDoctorSchedules_morning.isEmpty
        ? Container()
        :Padding(
      padding: const EdgeInsets.only(top: 20,left: 5,right: 5),
      child:
      //provider.doctor_Schedule_ResponseClass.length==0?Center(child: Text('No Data Found')):
      Column(
        children: [
          Wrap(
            // spacing: 30,
            direction: Axis.horizontal,
            children: techChipsMorning(),
          ),
        ],
      ),
    );
  }

  Widget buildAfternoonList(BuildContext context) {
    return  provider.getDoctorSchedules_afternoon.isEmpty
        ? Container()
        : Padding(
      padding: const EdgeInsets.only(top: 20,left: 5,right: 5),
      child:Wrap(
        // spacing: 30,
        direction: Axis.horizontal,
        children: techChipsAfternoon(),
      ),
    );
  }
  Widget buildEveningList(BuildContext context) {
    return  provider.getDoctorSchedules_evening.isEmpty
        ?Container()
        :Padding(
      padding: const EdgeInsets.only(top: 20,left: 5,right: 5),
      child: Wrap(
        // spacing: 30,
        direction: Axis.horizontal,
        children: techChipsEvening(),
      ),
    );
  }
  Widget buildNightList(BuildContext context) {
    return  provider.getDoctorSchedules_night.isEmpty
        ? Container()
        :Padding(
      padding: const EdgeInsets.only(top: 20,left: 5,right: 5),
      child: Wrap(
        // spacing: 30,
        direction: Axis.horizontal,
        children: techChipsNight(),
      ),
    );
  }

  Widget buildpatientdetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Text(
              'Pateint Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 20),
          //   child: Text(
          //     'Full Name',
          //     style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Color(0xff6B779A)),
          //   ),
          // ),
          DropdownButtonFormField2(
            isExpanded: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),

              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              //Add more decoration as you want here
              //Add label If you want but aZdd hint outside the decoration to be aligned in the button perfectly.
            ),
            hint: Text(
              'Select User',
              style: TextStyle(fontSize: 14),
            ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 30,
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            items: provider.addedFamily_ResponseClass
                .map((item) => DropdownMenuItem(
              value: item.id,
              child: Text(
                item.name!,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
            },
            onChanged: (value) {
              selectedValue = value.toString();
              print(selectedValue);

              //Do something when changing the item if you want.
            },
            onSaved: (value) {
              selectedValue = value.toString();
            },
          )
          // Padding(
          //   padding:  EdgeInsets.only(top: 10),
          //   child: Container(
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: DropdownButtonHideUnderline(
          //       child:
          //       DropdownButton2(
          //         //isExpanded: true,
          //         hint: Row(
          //           children:  [
          //             Icon(
          //               Icons.people_alt_outlined,
          //               size: 16,
          //               color: Colors.blueAccent,
          //             ),
          //             SizedBox(
          //               width: 10,
          //
          //             ),
          //             Text(
          //               'Select User',
          //               style: TextStyle(
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.grey,
          //               ),
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //           ],
          //         ),
          //         items: provider.addedFamily_ResponseClass
          //             .map((item) => DropdownMenuItem<String>(
          //           value: item.id.toString(),
          //           child: Row(
          //             children: [
          //               Icon(Icons.person,color: Colors.blueAccent,),
          //               Padding(
          //                 padding:EdgeInsets.only(left: 20),
          //                 child: Text(
          //                   item.name.toString().toUpperCase(),
          //                   style: const TextStyle(
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.black,
          //                   ),
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ))
          //             .toList(),
          //         value: selectedValue,
          //         onChanged: (value) {
          //           setState(() {
          //             selectedValue = value as String;
          //             valueselected = value;
          //             print(selectedValue);
          //           });
          //         },
          //         icon: const Icon(
          //           Icons.arrow_drop_down_circle_outlined,color: Colors.blueAccent,
          //         ),
          //         iconSize: 14,
          //         iconEnabledColor: Colors.grey,
          //         iconDisabledColor: Colors.grey,
          //         buttonHeight: 50,
          //         buttonWidth: 160,
          //         buttonPadding:  EdgeInsets.only(left: 14, right: 14),
          //         buttonDecoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(14),
          //           border: Border.all(
          //             color: Colors.black26,
          //           ),
          //           color: Color(0xff6B779A).withOpacity(0.05),
          //         ),
          //         buttonElevation: 0,
          //         itemHeight: 40,
          //         itemPadding:  EdgeInsets.only(left: 14, right: 14),
          //         dropdownMaxHeight: 400,
          //         dropdownWidth: MediaQuery.of(context).size.width,
          //         dropdownPadding: null,
          //         dropdownDecoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(14),
          //           color: Color(0xffF6F6F6),
          //         ),
          //         dropdownElevation: 8,
          //         scrollbarRadius:  Radius.circular(40),
          //         scrollbarThickness: 6,
          //         scrollbarAlwaysShow: true,
          //         offset: const Offset(-20, 0),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget buildAge(BuildContext context){
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 25,right: 25),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(top: 20),
  //           child: Text('Age',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Color(0xff6B779A),)),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(top: 10),
  //           child: TextField(keyboardType: TextInputType.number,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
  //                   borderSide: BorderSide.none),
  //               filled: true,
  //               fillColor:Color(0xff6B779A).withOpacity(0.05),
  //               hintText: 'Enter Your Age'
  //           ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  // Widget buildGender(BuildContext context){
  //   return Padding(
  //     padding: EdgeInsets.only(left: 25),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: 20,),
  //         Text('Gender',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Color(0xff6B779A))),
  //         SizedBox(height: 10,),
  //         Wrap(
  //           spacing: 3,
  //           direction: Axis.horizontal,
  //           children: techChips2(),
  //         )
  //       ],
  //     ),
  //   );
  // }
  // Widget buildWriteProblem(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 25, right: 25),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Text(
  //           'Write Your Problem',
  //           style: TextStyle(
  //               fontWeight: FontWeight.w400,
  //               fontSize: 14,
  //               color: Color(0xff6B779A)),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         TextField(
  //           controller: _problem,
  //           decoration: InputDecoration(
  //             counterText: '',
  //             border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(15),
  //                 borderSide: BorderSide.none),
  //             hintText: 'Write Your Problem',
  //             filled: true,
  //             fillColor: Color(0xff6B779A).withOpacity(0.05),
  //           ),
  //           maxLength: 250,
  //           maxLines: 5,
  //         ),
  //         SizedBox(
  //           height: 50,
  //         )
  //       ],
  //     ),
  //   );
  // }

// Widget buildAge(BuildContext context){
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 25,right: 25),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(top: 20),
  //           child: Text('Age',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Color(0xff6B779A),)),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(top: 10),
  //           child: TextField(keyboardType: TextInputType.number,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
  //                   borderSide: BorderSide.none),
  //               filled: true,
  //               fillColor:Color(0xff6B779A).withOpacity(0.05),
  //               hintText: 'Enter Your Age'
  //           ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  // Widget buildGender(BuildContext context){
  //   return Padding(
  //     padding: EdgeInsets.only(left: 25),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: 20,),
  //         Text('Gender',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Color(0xff6B779A))),
  //         SizedBox(height: 10,),
  //         Wrap(
  //           spacing: 3,
  //           direction: Axis.horizontal,
  //           children: techChips2(),
  //         )
  //       ],
  //     ),
  //   );
  // }
  // Widget buildWriteProblem(BuildContext context){
  //   return Padding(
  //     padding: EdgeInsets.only(left: 25,right: 25),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: 20,),
  //         Text('Write Your Problem',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Color(0xff6B779A)),),
  //         SizedBox(height: 10,),
  //         TextField(
  //           controller: _problem,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(15),
  //                 borderSide: BorderSide.none
  //             ),
  //             hintText: 'Write Your Problem',
  //             filled: true,
  //             fillColor:Color(0xff6B779A).withOpacity(0.05),
  //           ),
  //           maxLines: 5,
  //         ),
  //         SizedBox(height: 50,)
  //       ],
  //     ),
  //   );
  // }
  Widget buildButton(BuildContext context,update_Appointment_Notifier providers){
    return Padding(
      padding: const EdgeInsets.only(right: 25,bottom: 20,left: 25),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Builder(
          builder: (context) {
            return ElevatedButton(onPressed: (){
              print('irfan');
              print(selected);
              print(selectedValue);
              print(outputDate);
              print(selectedDate);
              final DateFormat formatter = DateFormat('yyyy-MM-dd');
              final String formatted = formatter.format(selectedDate!);
              print(formatted);
              print("abdul"+outputDatedate.toString());
              if (selected.isEmpty) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                    content: Text('Please Select Appointment Time')));
              } else if (selectedValue == null) {
                Scaffold.of(context).showSnackBar(
                    new SnackBar(content: Text('Please Select User')));
              }else{
                providers.Update_Appointment_class(widget.app_id.toString(), outputDate,selectedValue.toString(), outputDatedate.toString(), selected);
              }
              //provider1.Add_Appointment_class(doctor_id, days, patient_id, date, schedule_type, appointment_time, description)
              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Suceess()));
            },
                child: Text('Update Appointment',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
            );
          }
        ),
      ),
    );
  }
  List<Widget> techChipsMorning() {
    List<Widget> chips = [];
    for (int i = 0; i < provider.getDoctorSchedules_morning.length; i++) {
      //for(int j=0;j<provider.doctor_Schedule_ResponseClass[i].morning!.length;j++){
      Widget item = Padding(
          padding: EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex == i ? Colors.white : Colors.black,
            // ),
            label: Text(provider.getDoctorSchedules_morning[i].time12.toString()),
            labelStyle: TextStyle(
              color: selectedIndex == i ? Colors.white : Colors.black,
            ),
            disabledColor: Color(0xffeeeeee),
            selectedColor: Color(0xff4889FD),
            backgroundColor: Colors.white,
            selected: selectedIndex == i,
            onSelected: provider.getDoctorSchedules_morning[i].status == 1
                ? null
                : (bool value) {
              setState(() {
                print(i);
                if (selectedIndex2 != null) {
                  selectedIndex2 = null;
                  selectedIndex = i;
                  selected =
                      provider.getDoctorSchedules_morning[i].toString();
                } else if (selectedIndex3 != null) {
                  selectedIndex3 = null;
                  selectedIndex = i;
                  selected =
                      provider.getDoctorSchedules_morning[i].toString();
                } else if (selectedIndex4 != null) {
                  selectedIndex4 = null;
                  selectedIndex = i;
                  selected =
                      provider.getDoctorSchedules_morning[i].toString();
                } else if (selectedIndex2 == null && selectedIndex3 == null &&
                    selectedIndex4 == null) {
                  selectedIndex = i;
                  selected =
                      provider.getDoctorSchedules_morning[i].time.toString();
                }
                print('irfan' +
                    provider.getDoctorSchedules_morning[i].time.toString());
              });
            },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }

  List<Widget> techChipsAfternoon() {
    List<Widget> chips = [];
    for (int k = 0; k < provider.getDoctorSchedules_afternoon.length; k++) {
      //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
      Widget item = Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex2 == k ? Colors.white : Colors.black,
            // ),
            label:
            Text(provider.getDoctorSchedules_afternoon[k].time12.toString()),
            labelStyle: TextStyle(
              color: selectedIndex2 == k ? Colors.white : Colors.black,
            ),
            selectedColor: Color(0xff4889FD),
            disabledColor: Color(0xffeeeeee),
            backgroundColor: Colors.white,
            selected: selectedIndex2 == k,
            onSelected: provider.getDoctorSchedules_afternoon[k].status == 1
                ? null
                : (bool value) {
              setState(() {
                print(k);
                if (selectedIndex != null) {
                  selectedIndex = null;
                  selectedIndex2 = k;
                  selected =
                      provider.getDoctorSchedules_afternoon[k].time.toString();
                } else if (selectedIndex3 != null) {
                  selectedIndex3 = null;
                  selectedIndex2 = k;
                  selected = provider.getDoctorSchedules_afternoon[k].time
                      .toString();
                } else if (selectedIndex4 != null) {
                  selectedIndex4 = null;
                  selectedIndex2 = k;
                  selected = provider.getDoctorSchedules_afternoon[k].time
                      .toString();
                } else if (selectedIndex == null && selectedIndex3 == null &&
                    selectedIndex4 == null) {
                  selectedIndex2 = k;
                  selected = provider.getDoctorSchedules_afternoon[k].time
                      .toString();
                  print("sorry");
                }

                print('abdul' +
                    provider.getDoctorSchedules_afternoon[k].time.toString());
              });
            },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }

  List<Widget> techChipsEvening() {
    List<Widget> chips = [];
    for (int m = 0; m < provider.getDoctorSchedules_evening.length; m++) {
      //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
      Widget item = Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex3 == m ? Colors.white : Colors.black,
            // ),
            label:
            Text(provider.getDoctorSchedules_evening[m].time12.toString()),
            labelStyle: TextStyle(
              color: selectedIndex3 == m ? Colors.white : Colors.black,
            ),
            selectedColor: Color(0xff4889FD),
            disabledColor: Color(0xffeeeeee),
            backgroundColor: Colors.white,
            selected: selectedIndex3 == m,
            onSelected: provider.getDoctorSchedules_evening[m].status == 1
                ? null
                : (bool value) {
              setState(() {
                print(m);
                if (selectedIndex != null) {
                  selectedIndex = null;
                  selectedIndex3 = m;
                  selected = provider.getDoctorSchedules_evening[m].time
                      .toString();
                } else if (selectedIndex2 != null) {
                  selectedIndex2 = null;
                  selectedIndex3 = m;
                  selected = provider.getDoctorSchedules_evening[m].time
                      .toString();
                } else if (selectedIndex4 != null) {
                  selectedIndex4 = null;
                  selectedIndex3 = m;
                  selected = provider.getDoctorSchedules_evening[m].time
                      .toString();
                } else if (selectedIndex == null && selectedIndex2 == null &&
                    selectedIndex4 == null) {
                  selectedIndex3 = m;
                  selected = provider.getDoctorSchedules_evening[m].time
                      .toString();
                  print("sorry");
                }

                print(provider.getDoctorSchedules_evening[m].time);
              });
            },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }

  List<Widget> techChipsNight() {
    List<Widget> chips = [];
    for (int n = 0; n < provider.getDoctorSchedules_night.length; n++) {
      //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
      Widget item = Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex4 == n ? Colors.white : Colors.black,
            // ),
            label:
            Text(provider.getDoctorSchedules_night[n].time12.toString()),
            labelStyle: TextStyle(
              color: selectedIndex4 == n ? Colors.white : Colors.black,
            ),
            selectedColor: Color(0xff4889FD),
            disabledColor: Color(0xffeeeeee),
            backgroundColor: Colors.white,
            selected: selectedIndex4 == n,
            onSelected: provider.getDoctorSchedules_night[n].status == 1
                ? null
                : (bool value) {
              setState(() {
                print(n);
                if (selectedIndex != null) {
                  selectedIndex = null;
                  selectedIndex4 = n;
                  selected = provider.getDoctorSchedules_night[n].time
                      .toString();
                } else if (selectedIndex2 != null) {
                  selectedIndex2 = null;
                  selectedIndex4 = n;
                  selected = provider.getDoctorSchedules_night[n].time
                      .toString();
                } else if (selectedIndex3 != null) {
                  selectedIndex3 = null;
                  selectedIndex4 = n;
                  selected = provider.getDoctorSchedules_night[n].time
                      .toString();
                } else if (selectedIndex == null && selectedIndex2 == null &&
                    selectedIndex3 == null) {
                  selectedIndex4 = n;
                  selected = provider.getDoctorSchedules_night[n].time
                      .toString();
                  print("sorry");
                }

                print(provider.getDoctorSchedules_night[n].time);
              });
            },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }
  // List<Widget> techChipsMorning() {
  //   List<Widget> chips = [];
  //   for (int i = 0; i < provider.getDoctorSchedules_morning.length; i++) {
  //     //for(int j=0;j<provider.doctor_Schedule_ResponseClass[i].morning!.length;j++){
  //     Widget item = Padding(
  //         padding: const EdgeInsets.only(left: 5, right: 5),
  //         child: ChoiceChip(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(5),
  //               side: BorderSide(color: Colors.grey.shade200)),
  //           // avatar: Icon(
  //           //   CupertinoIcons.clock,
  //           //   size: 18,
  //           //   color: selectedIndex == i ? Colors.white : Colors.black,
  //           // ),
  //           label: Text(provider.getDoctorSchedules_morning[i].time12.toString()),
  //           labelStyle: TextStyle(
  //             color: selectedIndex == i ? Colors.white : Colors.black,
  //           ),
  //           disabledColor: Color(0xffeeeeee),
  //           selectedColor: Color(0xff4889FD),
  //           backgroundColor: Colors.white,
  //           selected: selectedIndex == i,
  //           onSelected: provider.getDoctorSchedules_morning[i].status == 1
  //               ? null
  //               : (bool value) {
  //             setState(() {
  //               print(i);
  //               if (selectedIndex2 != null) {
  //                 selectedIndex2 = null;
  //                 selectedIndex = i;
  //                 selected =
  //                     provider.getDoctorSchedules_morning[i].toString();
  //               }else if(selectedIndex3 != null) {
  //                 selectedIndex3 = null;
  //                 selectedIndex = i;
  //                 selected =
  //                     provider.getDoctorSchedules_morning[i].toString();
  //               }else if(selectedIndex4 != null) {
  //                 selectedIndex4 = null;
  //                 selectedIndex = i;
  //                 selected =
  //                     provider.getDoctorSchedules_morning[i].toString();
  //               } else if (selectedIndex2 == null&&selectedIndex3==null&&selectedIndex4==null) {
  //                 selectedIndex = i;
  //                 selected =
  //                     provider.getDoctorSchedules_morning[i].time.toString();
  //               }
  //               print('irfan'+provider.getDoctorSchedules_morning[i].time.toString());
  //             });
  //           },
  //         ));
  //     chips.add(item);
  //   }
  //   //}
  //   return chips;
  // }
  //
  // List<Widget> techChipsAfternoon() {
  //   List<Widget> chips = [];
  //   for (int k = 0; k < provider.getDoctorSchedules_afternoon.length; k++) {
  //     //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
  //     Widget item = Padding(
  //         padding: const EdgeInsets.only(left: 5, right: 5),
  //         child: ChoiceChip(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(5),
  //               side: BorderSide(color: Colors.grey.shade200)),
  //           // avatar: Icon(
  //           //   CupertinoIcons.clock,
  //           //   size: 18,
  //           //   color: selectedIndex2 == k ? Colors.white : Colors.black,
  //           // ),
  //           label:
  //           Text(provider.getDoctorSchedules_afternoon[k].time12.toString()),
  //           labelStyle: TextStyle(
  //             color: selectedIndex2 == k ? Colors.white : Colors.black,
  //           ),
  //           selectedColor: Color(0xff4889FD),
  //           disabledColor: Color(0xffeeeeee),
  //           backgroundColor: Colors.white,
  //           selected: selectedIndex2 == k,
  //           onSelected: provider.getDoctorSchedules_afternoon[k].status == 1
  //               ? null
  //               : (bool value) {
  //             setState(() {
  //               print(k);
  //               if (selectedIndex != null) {
  //                 selectedIndex = null;
  //                 selectedIndex2 = k;
  //                 selected = provider.getDoctorSchedules_afternoon[k].time.toString();
  //               } else if (selectedIndex3 != null) {
  //                 selectedIndex3 = null;
  //                 selectedIndex2 = k;
  //                 selected = provider.getDoctorSchedules_afternoon[k].time
  //                     .toString();
  //               } else if (selectedIndex4 != null) {
  //                 selectedIndex4 = null;
  //                 selectedIndex2 = k;
  //                 selected = provider.getDoctorSchedules_afternoon[k].time
  //                     .toString();
  //               } else if (selectedIndex == null&&selectedIndex3==null&&selectedIndex4==null) {
  //                 selectedIndex2 = k;
  //                 selected = provider.getDoctorSchedules_afternoon[k].time
  //                     .toString();
  //                 print("sorry");
  //               }
  //
  //               print('abdul'+provider.getDoctorSchedules_afternoon[k].time.toString());
  //             });
  //           },
  //         ));
  //     chips.add(item);
  //   }
  //   //}
  //   return chips;
  // }
  // List<Widget> techChipsEvening() {
  //   List<Widget> chips = [];
  //   for (int m = 0; m < provider.getDoctorSchedules_evening.length; m++) {
  //     //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
  //     Widget item = Padding(
  //         padding: const EdgeInsets.only(left: 5, right: 5),
  //         child: ChoiceChip(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(5),
  //               side: BorderSide(color: Colors.grey.shade200)),
  //           // avatar: Icon(
  //           //   CupertinoIcons.clock,
  //           //   size: 18,
  //           //   color: selectedIndex3 == m ? Colors.white : Colors.black,
  //           // ),
  //           label:
  //           Text(provider.getDoctorSchedules_evening[m].time12.toString()),
  //           labelStyle: TextStyle(
  //             color: selectedIndex3 == m ? Colors.white : Colors.black,
  //           ),
  //           selectedColor: Color(0xff4889FD),
  //           disabledColor: Color(0xffeeeeee),
  //           backgroundColor: Colors.white,
  //           selected: selectedIndex3 == m,
  //           onSelected: provider.getDoctorSchedules_evening[m].status == 1
  //               ? null
  //               : (bool value) {
  //             setState(() {
  //               print(m);
  //               if (selectedIndex != null) {
  //                 selectedIndex = null;
  //                 selectedIndex3 = m;
  //                 selected = provider.getDoctorSchedules_evening[m].time
  //                     .toString();
  //               }else if(selectedIndex2!= null) {
  //                 selectedIndex2 = null;
  //                 selectedIndex3 = m;
  //                 selected = provider.getDoctorSchedules_evening[m].time
  //                     .toString();
  //               }else if(selectedIndex4!= null) {
  //                 selectedIndex4 = null;
  //                 selectedIndex3 = m;
  //                 selected = provider.getDoctorSchedules_evening[m].time
  //                     .toString();
  //               } else if (selectedIndex == null&&selectedIndex2 == null&&selectedIndex4 == null) {
  //                 selectedIndex3 = m;
  //                 selected = provider.getDoctorSchedules_evening[m].time
  //                     .toString();
  //                 print("sorry");
  //               }
  //
  //               print(provider.getDoctorSchedules_evening[m].time);
  //             });
  //           },
  //         ));
  //     chips.add(item);
  //   }
  //   //}
  //   return chips;
  // }
  // List<Widget> techChipsNight() {
  //   List<Widget> chips = [];
  //   for (int n = 0; n < provider.getDoctorSchedules_night.length; n++) {
  //     //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
  //     Widget item = Padding(
  //         padding: const EdgeInsets.only(left: 5, right: 5),
  //         child: ChoiceChip(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(5),
  //               side: BorderSide(color: Colors.grey.shade200)),
  //           // avatar: Icon(
  //           //   CupertinoIcons.clock,
  //           //   size: 18,
  //           //   color: selectedIndex4 == n ? Colors.white : Colors.black,
  //           // ),
  //           label:
  //           Text(provider.getDoctorSchedules_night[n].time12.toString()),
  //           labelStyle: TextStyle(
  //             color: selectedIndex4 == n ? Colors.white : Colors.black,
  //           ),
  //           selectedColor: Color(0xff4889FD),
  //           disabledColor: Color(0xffeeeeee),
  //           backgroundColor: Colors.white,
  //           selected: selectedIndex4 == n,
  //           onSelected: provider.getDoctorSchedules_night[n].status == 1
  //               ? null
  //               : (bool value) {
  //             setState(() {
  //               print(n);
  //               if (selectedIndex != null) {
  //                 selectedIndex = null;
  //                 selectedIndex4 = n;
  //                 selected = provider.getDoctorSchedules_night[n].time
  //                     .toString();
  //               } else if(selectedIndex2 != null) {
  //                 selectedIndex2 = null;
  //                 selectedIndex4 = n;
  //                 selected = provider.getDoctorSchedules_night[n].time
  //                     .toString();
  //               } else if(selectedIndex3 != null) {
  //                 selectedIndex3 = null;
  //                 selectedIndex4 = n;
  //                 selected = provider.getDoctorSchedules_night[n].time
  //                     .toString();
  //               }else if (selectedIndex == null&&selectedIndex2 == null&&selectedIndex3 == null) {
  //                 selectedIndex4 = n;
  //                 selected = provider.getDoctorSchedules_night[n].time
  //                     .toString();
  //                 print("sorry");
  //               }
  //
  //               print(provider.getDoctorSchedules_night[n].time);
  //             });
  //           },
  //         ));
  //     chips.add(item);
  //   }
  //   //}
  //   return chips;
  // }
}
