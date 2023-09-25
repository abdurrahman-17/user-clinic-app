import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/DATE/date_picker_widget.dart';
import 'package:user_clinic_token_app/core/request_response/add%20Token%20Appointment/add_Token_Appointment_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/add%20Token%20Appointment/add_Token_Appointment_Response.dart';
import 'package:user_clinic_token_app/core/request_response/get%20Doctor%20Schedule/get_Doctor_Schedule_Response.dart';
import 'package:user_clinic_token_app/core/request_response/get%20Token%20Response/get_Token_Schedule_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/update%20Token/update_Token_Notifier.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
import 'package:user_clinic_token_app/view/Token_Success/Token_success.dart';

class Update_Toke_Appointment_New extends StatefulWidget {
  final app_id;
   Update_Toke_Appointment_New({Key? key,required this.app_id}) : super(key: key);

  @override
  _Update_Toke_Appointment_NewState createState() => _Update_Toke_Appointment_NewState();
}
class Tech {
  String label;
  bool isSelected;

  Tech(this.label, this.isSelected);
}
class Gender
{
  String label;
  //Color color;
  Gender(this.label,);
}
String? selectedValue;
var items = [
  'Mohammed Saad',
  'Shadab Ahmed',
  'Mohammed Irfan',
  'Abdul Rahman',
  'Nadeem Ahmed',
];

class _Update_Toke_Appointment_NewState extends State<Update_Toke_Appointment_New> {

  get_Doctor_Token_Schedule_Notifier provider=get_Doctor_Token_Schedule_Notifier();
  update_Token_Notifier provider1=update_Token_Notifier();
  String valueselected = '';
  DateTime _selectedValue = DateTime.now();
  List<String> chips = <String>[];
  List? _myActivities;
  int? selectedIndex;
  int? selectedIndex2;
  List<Gender> _chipsList2 = [
    Gender("Male",),
    Gender("Female",),
  ];
  final List<Tech> _chipsList = <Tech>[
    Tech("01", false),
    Tech("02", false),
    Tech("03", false),
    Tech("04", false),
    Tech("05", false),
    Tech("06", false),
    Tech("07", false),
    Tech("08", false),
    Tech("09", false),
    Tech("10", false),
    Tech("11", false),
    Tech("12", false),
    Tech("13", false),
    Tech("14", false),
    Tech("15", false),
    Tech("16", false),
    Tech("17", false),
    Tech("18", false),
    Tech("19", false),
    Tech("20", false),
    Tech("21", false),
    Tech("22", false),
    Tech("23", false),
    Tech("24", false),
    Tech("25", false),
  ];
  String? formatted;
  String? outputDate;
  String selected='';
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    date();
    print('irfan'+ _selectedValue.toString());
    Future.delayed(Duration.zero,(){
      provider.get_Doctor_token_Schedule(46.toString(), outputDate!, 12.toString());
      provider.notifyListeners();
      print(provider.doctor_token_Schedule_ResponseClass.length);
    });
  }
  void date(){
    //final DateFormat formatter=DateFormat("dd-MMMM-yyy");
    // formatted=formatter.format();
    // print(formatted);

    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(_selectedValue.toString()); // <-- dd/MM 24H format

    var outputFormat = DateFormat('E');
    outputDate = outputFormat.format(inputDate).toLowerCase();
    print('irfan'+outputDate!); // 12/31/2000 11:59 PM <-- MM/dd 12H format

  }

  DateTime? selectedDate;
  DatePickerController _controller = DatePickerController();
  TextEditingController _description=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<get_Doctor_Token_Schedule_Notifier>(
      builder: (context,provider,_){
        this.provider=provider;
        return ModalProgressHUD(inAsyncCall: provider.isloading, child:
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(60), child: buildAppBar(context)),
            body:_buildBody(context),
          ),
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
          child: Padding(
            padding:  EdgeInsets.only(left: 6.0),
            child: IconButton(
              icon:Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,),
              onPressed: () { Navigator.pop(context); },
            ),
          ),
        ),
      ),
      title: Text(
        'Update Token Appointment',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      centerTitle: true,
    );
  }
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDateSelector(context),
          buildSelectDate(context),
          buildSingleToken(context),
          buildpatientdetails(context),
          // buildAge(context),
          // buildGender(context),
          //buildWriteProblem(context),
          buildButton(context),
        ],
      ),
    );
  }
  Widget buildDateSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 25),
      child: Row(
        children: [
          Text(
            'Select A Date',
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w500),
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
                  var inputDate = inputFormat.parse(_selectedValue.toString()); // <-- dd/MM 24H format

                  var outputFormat = DateFormat('E');
                  outputDate = outputFormat.format(inputDate).toLowerCase();
                  print('abdul'+outputDate!); // 12
                  provider.get_Doctor_token_Schedule(46.toString(), outputDate.toString(), 12.toString());
                  provider.notifyListeners();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget buildSingleToken(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30, bottom: 15),
          child: Text(
            "Token",
            style: const TextStyle(fontSize: 22),
          ),
        ),
        Center(
          child: provider.doctor_token_Schedule_ResponseClass.length==0?Text('No data'):Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                direction: Axis.horizontal,
                children: listChip(),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget buildpatientdetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:25,right: 25,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              'Pateint Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          // Text(
          //   'Full Name',
          //   style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Color(0xff6B779A)),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      Icon(
                        Icons.people_alt_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Select User',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  items: provider.addedFamily_ResponseClass
                      .map((item) => DropdownMenuItem<String>(
                    value: item.id.toString(),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.person,color: Colors.grey,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            item.name.toString().toUpperCase(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                      valueselected = value;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.grey,
                  iconDisabledColor: Colors.grey,
                  buttonHeight: 50,
                  buttonWidth: 160,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Color(0xff6B779A).withOpacity(0.05),
                  ),
                  buttonElevation: 0,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 400,
                  dropdownWidth: MediaQuery.of(context).size.width,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color(0xffF6F6F6),
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset:  Offset(-20, 0),
                ),
              ),
            ),
          ),
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
  //           child: TextField(
  //             keyboardType: TextInputType.number,
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
  Widget buildWriteProblem(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left: 25,right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Text('Write Your Problem',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Color(0xff6B779A)),),
          SizedBox(height: 10,),
          TextField(
            controller: _description,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none
              ),
              hintText: 'Write Your Problem',
              filled: true,
              fillColor:Color(0xff6B779A).withOpacity(0.05),
            ),
            maxLines: 5,
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }
  Widget buildButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(right: 25,bottom: 20,left: 25),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(onPressed: (){
          print(selected);
          print(selectedValue);
          print(outputDate);
          print(selectedDate);
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          final String formatted = formatter.format(_selectedValue);
          print(formatted);
          if(selected.isEmpty){
            Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Please Select Appointment Time')));
          }
          else if(selectedValue==null){
            Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Please Select User')));
          }
          else{
            provider1.Update_Token_class(widget.app_id.toString(), outputDate!, selectedValue.toString(), formatted, selected);
          }
          //provider1.Add_Token_Appointment_class(46.toString(), outputDate!, selectedValue!, formatted, 2.toString(), selected, _description.text);
          //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Token_Suceess()));
        },
            child: Text('Book Token',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
            style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
        ),
      ),
    );
  }

  List<Widget> listChip() {
    List<Widget> chips = [];
    for (int i = 0; i < provider.doctor_token_Schedule_ResponseClass.length; i++) {
      for (int j = 0; j < provider.doctor_token_Schedule_ResponseClass[i].tokenTime!.length; j++) {
        Widget item = Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ChoiceChip(
            label: Container(
              height: 45,
              width: 30,
              child: Center(
                child: Text(
                  provider.doctor_token_Schedule_ResponseClass[i].tokenTime![j],
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedIndex == j
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.blueAccent)),
            backgroundColor: Colors.transparent,
            selectedColor: Theme.of(context).primaryColor,
            selected: selectedIndex == j,
            onSelected: (bool value) {
              setState(() {
                print(i);
                selectedIndex = j;
                selected=provider.doctor_token_Schedule_ResponseClass[i].tokenTime![j];
                print(selected);
              });
            },
          ),
        );
        chips.add(item);
      }

    }
    return chips;
  }

  // Iterable<Widget> get listChip sync* {
  //   for (final Tech chip in _chipsList) {
  //     yield Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //       child: ChoiceChip(
  //         label: Container(
  //           height: 45,
  //           width: 30,
  //           child: Center(
  //             child: Text(
  //               chip.label,
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: chips.contains(chip.label)
  //                     ? Colors.white
  //                     : Colors.blueAccent,
  //               ),
  //             ),
  //           ),
  //         ),
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(5),
  //             side: BorderSide(color: Colors.blueAccent)),
  //         backgroundColor: Colors.transparent,
  //         selectedColor: Theme.of(context).primaryColor,
  //         selected: chips.contains(chip.label),
  //         onSelected: (bool value) {
  //           setState(() {
  //
  //             // if (value) {
  //             //   if (_myActivities!.isNotEmpty) {
  //             //     if (chips.length <= _myActivities!.length -1) {
  //             //       chips.add(chip.label);
  //             //     } else {
  //             //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             //         content: Text('User Exceeded'),
  //             //       ));
  //             //     }
  //             //   } else {
  //             //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             //       content: Text('User not selected'),
  //             //     ));
  //             //   }
  //             // } else {
  //             //   chips.removeWhere((String name) {
  //             //     return name == chip.label;
  //             //   });
  //             // }
  //           });
  //         },
  //       ),
  //     );
  //   }
  // }

  List<Widget> techChips2() {
    List<Widget> chips = [];
    for (int j = 0; j < _chipsList2.length; j++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ChoiceChip(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey.shade200)),
          label: Container(
              width: 60,
              child: Center(child: Text(_chipsList2[j].label))),
          labelStyle: TextStyle(
              color: selectedIndex2 == j
                  ? Colors.white
                  : Theme.of(context).primaryColorLight),
          selectedColor: Color(0xff4889FD),
          backgroundColor: Colors.white,
          disabledColor: Colors.red,
          selected: selectedIndex2 == j,
          onSelected: (bool value) {
            setState(() {
              print(j);
              selectedIndex2 = j;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

}
