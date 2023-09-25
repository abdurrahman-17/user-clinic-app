import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:user_clinic_token_app/DATE/date_picker_widget.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';

class TokenAppointment extends StatefulWidget {
  const TokenAppointment({Key? key}) : super(key: key);

  @override
  _TokenAppointmentState createState() => _TokenAppointmentState();
}

class Tech {
  String label;
  bool isSelected;

  Tech(this.label, this.isSelected);
}

class _TokenAppointmentState extends State<TokenAppointment> {
  List? _myActivities;
  final formKey = GlobalKey<FormState>();
  bool selected = false;
  final DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  List<String> chips = <String>[];

  int? selectedIndex;
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



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildProfile(context),
              builddateandtime(context),
              buildSelectDate(context),
              buildUserSelection(context),
              buildSingleToken(context),
              buildMakeAppointment(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfile(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30)),
        color: Theme.of(context).primaryColor,
        // gradient: LinearGradient(
        //     begin: Alignment.centerLeft,
        //     end: Alignment.centerRight,
        //     colors: [Color(0xff6CA5FC), Color(0xff4F96FF)]),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10, bottom: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.28,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYSe8PeHEIJGERK3kEK9bzgSq-nXsf8sP4-Q&usqp=CAU'))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Dr. Nadeem',
                      style: NameStyle(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Heart Surgeon',
                      style: SpecialistStyle(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                   Text('Fees ₹ 200',style: SpecialistStyle(context),)
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Text(
                      '14 years EXP',
                      style: ExpStyle(context),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget builddateandtime(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Text('April 2022', style: DateTitleStyle(context)),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset(
                      AppImages.SETTING,
                      color: Colors.blueAccent,
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSelectDate(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
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
          DatePicker(
            DateTime.now(),
            width: 65,
            height: 90,
            controller: _controller,
            initialSelectedDate: DateTime.now(),
            selectionColor: Theme.of(context).primaryColor,
            selectedTextColor: Colors.white,
            dateTextStyle: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
            dayTextStyle: TextStyle(
              color: Theme.of(context).primaryColorLight,
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
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildUserSelection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: MultiSelectFormField(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {},
          ),
          autovalidate: AutovalidateMode.disabled,
          chipBackGroundColor: Theme.of(context).primaryColor,
          chipLabelStyle:
          const TextStyle( color: Colors.white),
          dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          checkBoxActiveColor: Colors.blue,
          checkBoxCheckColor: Colors.white,
          fillColor: Colors.white,
          border: InputBorder.none,
          dialogShapeBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          title: Text(
            "User List",
            style: DateTitleStyle(context),
          ),
          dataSource: const [
            {
              "display": "Abdur",
              "value": "Running",
            },
            {
              "display": "Irfan",
              "value": "Climbing",
            },
            {
              "display": "Shadab",
              "value": "Walking",
            },
            {
              "display": "Rifaq",
              "value": "Hi",
            },
            {
              "display": "Irbaz",
              "value": "Love Boy",
            },
            {
              "display": "Javeed",
              "value": "Married",
            },
            {
              "display": "Saad",
              "value": "TL",
            },
          ],
          textField: 'display',
          valueField: 'value',
          okButtonLabel: 'OK',
          cancelButtonLabel: 'CANCEL',
          hintWidget: const Text('Please choose user to book token'),
          initialValue: _myActivities,
          onSaved: (value) {
            if (value == null) return;
            setState(() {
              _myActivities = value;
              // print(_myActivities);
            });
          },
        ),
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
            Languages.of(context)!.token,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                direction: Axis.horizontal,
                children: listChip.toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMakeAppointment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20,bottom: 20, left: 30, right: 30),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutePaths.Token_Done);
          },
          child: Text(
            Languages.of(context)!.booktoken,
            style: TextButtonStyle(context),
          ),
          style: AppointmentbuttonStyle(context),
        ),
      ),
    );
  }

  Iterable<Widget> get listChip sync* {
    for (final Tech chip in _chipsList) {
      yield Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: FilterChip(
          label: Container(
            height: 45,
            width: 30,
            child: Center(
              child: Text(
                chip.label,
                style: TextStyle(
                  fontSize: 16,
                  color: chips.contains(chip.label)
                      ? Colors.white
                      : Colors.blueAccent,
                ),
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Colors.blueAccent)),
          backgroundColor: Colors.transparent,
          selectedColor: Theme.of(context).primaryColor,
          showCheckmark: false,
          selected: chips.contains(chip.label),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                if (_myActivities!.isNotEmpty) {
                  if (chips.length <= _myActivities!.length -1) {
                    chips.add(chip.label);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                           content: Text('User Exceeded'),
                         ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('User not selected'),
                  ));
                }
              } else {
                chips.removeWhere((String name) {
                  return name == chip.label;
                });
              }
            });
          },
        ),
      );
    }
  }
}