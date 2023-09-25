
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/update_patient_profile/updatePatientProfileNotifier.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/common/app_validators.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({Key? key}) : super(key: key);

  @override
  _Edit_ProfileState createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  int? _result;
//  bool _isEditingText = false;
  TextEditingController _editingController = TextEditingController();
  TextEditingController _Address = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController calc = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  GlobalKey<FormState> _key=GlobalKey();
  String userNames = "Irfan";
  String userID='';
  String userGender='M';
  int? userAge;
  final picker = ImagePicker();
  var _images_profile;
  String filename='';
  File? _image;
  late UpdatePatientProfileNotifier? updatePatientProfileNotifier;
  String? dropdownValue;
  String? Gender;
  String Gen='';
  String birthDate = "";
  int age = -1;
  String id='';
  String name='';
  String address='';
  String imagestored='';
  String gender='';
  String agestored='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance.getid("id").then((value) => setState((){
      id=value.toString();
      //_editingController.text=id;
      print('irfan');
      print(id);
    }));
    MySharedPreferences.instance.getusername('name').then((value) {
      name=value.toString();
      _editingController.text=name;
      print(name);
    });
    MySharedPreferences.instance.getaddress('address').then((value) {
      address=value.toString();
      _Address.text=address;
      print(address);
    });
    MySharedPreferences.instance.getage('age').then((value) {
      agestored=value.toString();
      _age.text=agestored;
      print(agestored);
    });
    MySharedPreferences.instance.getImage('image').then((value) {
      imagestored=value.toString();
      print(imagestored);
    });
    MySharedPreferences.instance.getgender('gender').then((value) {
      gender=value.toString();
      print(gender);
      if(gender=="M"){
        _result=0;
        Gen='M';
      }else{
        _result=1;
        Gen='F';
      }
      print(gender);
    });
  }

  // getData() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   userNames = prefs.getString('userName1')!;
  //   userID = prefs.getInt('userId');
  //   userAge = prefs.getInt('userAge');
  //   userGender = prefs.getString('userGender');
  //   print('$userNames' + 'Hello ' +'$userID' + '$userGender');
  // }

  // @override
  // void dispose() {
  //   _editingController!.dispose();
  //   super.dispose();
  // }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  selectDate(BuildContext context, DateTime initialDateTime,
      {required DateTime lastDate}) async {
    Completer completer = Completer();
    String _selectedDateInString;
    if (Platform.isAndroid)
      showDatePicker(
          context: context,
          initialDate: initialDateTime,
          firstDate: DateTime(1970),
          lastDate: lastDate == null
              ? DateTime(initialDateTime.year + 10)
              : lastDate)
          .then((temp) {
        if (temp == null) return null;
        completer.complete(temp);
        setState(() {});
      });
    return completer.future;
  }
  Future getImageFromGallery_Profile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // print(_image);
        filename=pickedFile.path.split('/').last;
        print("irfan");
        _images_profile= pickedFile.path;
        print(pickedFile.path);
        print(_images_profile);
        print(filename);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera_Profile() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    print(pickedFile);
    print(_images_profile);
    print('abdur');
    setState(() {
      if (pickedFile != null){
        _image = File(pickedFile.path);
        print("irfan");
        filename=pickedFile.path.split('/').last;
        _images_profile= pickedFile.path;
        print(_images_profile);
        print('abdur');
        print(_image);
        print(filename);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery_Profile();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera_Profile();
            },
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<UpdatePatientProfileNotifier>(
        builder: (context, provider, _) {
          return ModalProgressHUD(
            inAsyncCall: provider.isLoading,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: buildBody(context),
              ),
            ),
          );
        }
    );
  }


  Widget buildBody(BuildContext context){
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  buildBackgroundandTitle(context),
                  buildProfileList(context),
                ],
              ),
            ),
          ),
        );
      });
  }
  Widget buildBackgroundandTitle(BuildContext context){
    return Container(
       height: 300,
      width: double.infinity,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(13),bottomRight: Radius.circular(13)
        //),
        color: Color(0xff4889FD),
      //),
      child: Column(
        children: [
          backButton(context),
          SizedBox(height: 20,),
          image(context),
          // Padding(
          //   padding: const EdgeInsets.only(top: 30.0),
          //   child: Container(
          //     height: 234,
          //     width: 234,
          //     decoration: BoxDecoration(color:Colors.black.withOpacity(0.05),borderRadius: BorderRadius.circular(150)),
          //   ),
          // )
        ],
      ),
    );
  }
  Widget buildProfileList(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Column(
        children: [
          Form(
              key: _key,
              child: buildUsernameAndWidgets(context)),
          // Spacer(),
          Expanded(child: Container()),
          buildSaveButton(context),

        ],
      ),
    );
  }
  Widget buildUsernameAndWidgets(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),  color: Colors.white,),
        // width: double.infinity,

         child:Padding(
           padding: const EdgeInsets.symmetric(horizontal: 15),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               // Padding(
               //   padding: const EdgeInsets.only(top: 60),
               //   child: Align(
               //       alignment: Alignment.center,
               //       child: Text('Change Profile',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 16,color: Color(0xff8B8B8B)),)),
               // ),
                SizedBox(height: 20,),
               // Divider(color: Color(0xffEDF1F7),),
               //Text('Name',style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w400,color: Color(0xff5F5F5F)),),
               editingTextField(context),

               //SizedBox(height: 20,),
               //Text('Age',style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w400,color: Color(0xff5F5F5F)),),
               // TextField(
               //   keyboardType: TextInputType.number,
               //   maxLength: 2,
               //   controller: _ageController,
               //   decoration: InputDecoration(
               //     counterText: '',
               //     focusedBorder: UnderlineInputBorder(
               //       borderSide: BorderSide(color:Color(0xff4889FD)),
               //     ),
               //
               //     // enabledBorder: OutlineInputBorder(
               //     //     borderRadius: BorderRadius.circular(10),
               //     //     borderSide: BorderSide(color: Color(0xff4482F0))
               //     // ),
               //
               //     hintText: '23',
               //     hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),
               //   ),
               // ),

               SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Flexible(
                     child: GestureDetector(
                         onTap: ()async{
                           DateTime birthdate=await selectDate(context, DateTime.now(), lastDate: DateTime.now());
                           final df=new DateFormat('dd-MMM-yyy');
                           this.birthDate=df.format(birthdate);
                           this.age=calculateAge(birthdate);

                           setState(() {
                             _age.text=birthDate.toString();
                             calc.text=age.toString();
                             print(calc.text);
                           });
                         },
                         child: SizedBox(
                           width: 130,
                           child: TextFormField(
                             controller: _age,
                             enabled: false,
                             // initialValue: userNames ,
                             decoration: InputDecoration(
                               focusedBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Color(0xff4889FD)),
                               ),
                               labelText: 'DOB',
                               labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),
                             ),
                           ),
                         )),
                   ),
                   SizedBox(width: 50,),
                   Flexible(
                       child:Padding(
                         padding:EdgeInsets.only(top: 20.0),
                         child: calc.text==""?Text('',style: TextStyle(fontSize: 20),):Text('Age :  '+calc.text,style: TextStyle(fontSize: 20),),
                       )
                     // TextFormField(
                     //   enabled: false,
                     //   controller: calc,
                     //   // initialValue: userNames ,
                     //   decoration: InputDecoration(
                     //     focusedBorder: UnderlineInputBorder(
                     //       borderSide: BorderSide(color: Color(0xff4889FD)),
                     //     ),
                     //     hintText: 'Age',
                     //     hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),
                     //   ),
                     // ),
                   )
                   // Container(width: 130,
                   //   child: Material(
                   //     child: TextField(
                   //       controller: _age,
                   //       decoration: InputDecoration(
                   //         focusedBorder: UnderlineInputBorder(
                   //           borderSide: BorderSide(color: Color(0xff4889FD)),
                   //         ),
                   //         labelText: 'Age',
                   //         labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),
                   //       ),
                   //     ),
                   //   ),
                   // ),
                   // Container(
                   //   width: 130,
                   //   child: TextField(
                   //     controller: _height,
                   //     decoration: InputDecoration(
                   //       enabledBorder: OutlineInputBorder(
                   //           borderRadius: BorderRadius.circular(10),
                   //           borderSide: BorderSide(color: Color(0xff4482F0))
                   //       ),
                   //       border: OutlineInputBorder(
                   //         borderRadius: BorderRadius.circular(10),
                   //       ),
                   //       labelText: 'height',
                   //       labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),
                   //     ),
                   //   ),
                   // )
                 ],
               ),
                SizedBox(height: 20,),
                AddressTextField(context),
               SizedBox(height: 20,),
               Text('Gender',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xff5F5F5F)),),
               Row(
                 children: [
                   Flexible(
                     child: RadioListTile(
                       activeColor: Colors.blue,
                       value: 0,
                       groupValue: _result,
                       onChanged: (ind) => setState((){ _result = ind as int?;
                       if(_result==0){
                         Gen='M';
                       }
                       print(Gen);
                       }
                       ),
                       title:  Text("Male",style: TextStyle(fontSize: 18,color: Color(0xffAAAAAA)),),
                     ),
                   ),
                   Flexible(
                     child: RadioListTile(
                       activeColor: Colors.blue,
                       value: 1,
                       groupValue: _result,
                       onChanged: (ind) => setState(() { _result = ind as int?;
                       if(_result==1){
                         Gen='F';
                       }
                       print(Gen);
                       },),
                       title: Text("Female",style: TextStyle(fontSize: 18,color: Color(0xffAAAAAA)),),
                     ),
                   ),
                 ],
               )

             /*  Row(
                 children: [
                   Flexible(
                     child: RadioListTile(
                       activeColor: Colors.blue,
                       value: 1,
                       groupValue: _result,
                       onChanged: (ind) => setState(() => _result = ind as int?),
                       title:  Text("Male",style: TextStyle(fontSize: 18,color: Color(0xffAAAAAA)),),
                     ),
                   ),
                   Flexible(
                     child: RadioListTile(
                       activeColor: Colors.blue,
                       value: 2,
                       groupValue: _result,
                       onChanged: (ind) => setState(() => _result = ind as int?),
                       title: Text("Female",style: TextStyle(fontSize: 18,color: Color(0xffAAAAAA)),),
                     ),
                   ),
                 ],
               ),*/
               // SizedBox(height: 30,),
               // Row(
               //   children: [
               //     Text("Issues",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w400),),
               //     Spacer(),
               //     Text('(Optional)',style: GoogleFonts.roboto(fontWeight: FontWeight.w300,fontSize: 15,color: Color(0xffC9C9C9)),)
               //   ],
               // ),
               // Divider(color: Color(0xffEDF1F7),),
               // // SizedBox(height: 60,),
               // // Text('Trafalgar D. Water Law',style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w700),),
               // // SizedBox(height: 5,),
               // // Text('20 Years old',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xff8F9BB3)),),
               // // SizedBox(height: 20,),
               // // Divider(color: Color(0xffEDF1F7),),
               // // Row(
               // //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               // //   children: [
               // //     Column(
               // //       children: [
               // //         CircleAvatar(
               // //           radius: 40,
               // //           backgroundColor: Color(0xff7ACEFA).withOpacity(0.15),
               // //           child: Icon(Icons.person,color: Color(0xff7ACEFA),),
               // //         ),
               // //         SizedBox(height: 10,),
               // //         Text('Saved',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),),
               // //         Text('Doctors',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),)
               // //       ],
               // //     ),
               // //     Column(
               // //       children: [
               // //         CircleAvatar(
               // //           radius: 40,
               // //           backgroundColor: Color(0xffE8899E).withOpacity(0.15),
               // //           child: Icon(Icons.file_copy,color: Color(0xffE8899E),),
               // //         ),
               // //         SizedBox(height: 10,),
               // //         Text('Saved',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),),
               // //         Text('Articles',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),)
               // //       ],
               // //     ),
               // //     Column(
               // //       children: [
               // //         CircleAvatar(
               // //           radius: 40,
               // //           backgroundColor: Color(0xffF7C480).withOpacity(0.15),
               // //           child: Icon(Icons.favorite_border,color: Color(0xffF7C480),),
               // //         ),
               // //         SizedBox(height: 10,),
               // //         Text('Health',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),),
               // //         Text('Dairy',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),)
               // //       ],
               // //     ),
               // //   ],
               // // ),
               // //SizedBox(height: 20,),
               // // Divider(color: Color(0xffEDF1F7),),
               // // SizedBox(height: 5,),
               // // ListTile(
               // //   leading: Container(
               // //     decoration: BoxDecoration(
               // //       borderRadius: BorderRadius.circular(5),
               // //       color: Color(0xff4889FD).withOpacity(0.08),
               // //     ),
               // //     child: Padding(
               // //       padding: const EdgeInsets.all(12),
               // //       child: Icon(Icons.calendar_today,color: Color(0xff231F20),),
               // //     ),
               // //   ),
               // //   title: Text('Appointment',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
               // //   trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
               // // ),
               // // Divider(color: Color(0xffEDF1F7),),
               // // SizedBox(height: 5,),
               // // ListTile(
               // //   leading: Container(
               // //     decoration: BoxDecoration(
               // //       borderRadius: BorderRadius.circular(5),
               // //       color: Color(0xff4889FD).withOpacity(0.08),
               // //     ),
               // //     child: Padding(
               // //       padding: const EdgeInsets.all(12),
               // //       child: Icon(Icons.opacity_outlined,color: Color(0xff231F20),),
               // //     ),
               // //   ),
               // //   title: Text('Pills Remainder',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
               // //   trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
               // // ),
               // // Divider(color: Color(0xffEDF1F7),),
               // // SizedBox(height: 5,),
               // // GestureDetector(
               // //   onTap: (){Navigator.pushNamed(context, RoutePaths.My_Doctor);},
               // //   child: ListTile(
               // //     leading: Container(
               // //       decoration: BoxDecoration(
               // //         borderRadius: BorderRadius.circular(5),
               // //         color: Color(0xff4889FD).withOpacity(0.08),
               // //       ),
               // //       child: Padding(
               // //         padding: const EdgeInsets.all(12),
               // //         child: Icon(Icons.person_outline,color: Color(0xff231F20),),
               // //       ),
               // //     ),
               // //     title: Text('My Doctor',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
               // //     trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
               // //   ),
               // // ),
               // // Divider(color: Color(0xffEDF1F7),),
               // // SizedBox(height: 5,),
               // // GestureDetector(
               // //   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Family_member()));},
               // //   child: ListTile(
               // //     leading: Container(
               // //       decoration: BoxDecoration(
               // //         borderRadius: BorderRadius.circular(5),
               // //         color: Color(0xff4889FD).withOpacity(0.08),
               // //       ),
               // //       child: Padding(
               // //         padding: const EdgeInsets.all(12),
               // //         child: Icon(Icons.groups_outlined,color: Color(0xff231F20),),
               // //       ),
               // //     ),
               // //     title: Text('Family Member',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
               // //     trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
               // //   ),
               // // ),
               // // Divider(color: Color(0xffEDF1F7),),
               // // SizedBox(height: 5,),
               // // GestureDetector(
               // //   onTap: (){Navigator.pushNamed(context, RoutePaths.Health_Record);},
               // //   child: ListTile(
               // //     leading: Container(
               // //       decoration: BoxDecoration(
               // //         borderRadius: BorderRadius.circular(5),
               // //         color: Color(0xff4889FD).withOpacity(0.08),
               // //       ),
               // //       child: Padding(
               // //         padding: const EdgeInsets.all(12),
               // //         child: Icon(Icons.file_copy_outlined,color: Color(0xff231F20),),
               // //       ),
               // //     ),
               // //     title: Text('EHR File',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
               // //     trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
               // //   ),
               // // ),
               // // Divider(color: Color(0xffEDF1F7),),
               // // SizedBox(height: 5,),
               // // ListTile(
               // //   leading: Container(
               // //     decoration: BoxDecoration(
               // //       borderRadius: BorderRadius.circular(5),
               // //       color: Color(0xff4889FD).withOpacity(0.08),
               // //     ),
               // //     child: Padding(
               // //       padding: const EdgeInsets.all(12),
               // //       child: Icon(Icons.payment_outlined,color: Color(0xff231F20),),
               // //     ),
               // //   ),
               // //   title: Text('Payment History',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
               // //   trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
               // // ),
               // // Divider(color: Color(0xffEDF1F7),),
               // SizedBox(height: 20,),
               // Padding(
               //   padding: const EdgeInsets.only(left: 10,bottom: 5),
               //   child: Text('Previous Issue',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
               // ),
               // TextField(
               //   maxLines: 4,
               //   decoration: InputDecoration(
               //       enabledBorder: OutlineInputBorder(
               //           borderRadius: BorderRadius.circular(10),
               //           borderSide: BorderSide(color: Color(0xff4482F0))
               //       ),
               //       border: OutlineInputBorder(
               //         borderRadius: BorderRadius.circular(10),
               //       ),
               //       hintText: 'write your problem',
               //       hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 16)
               //   ),
               // ),
               // SizedBox(height: 20,),
               // buildReportAndChoose(context),
               // SizedBox(height: 20,)

               // Container(
               //   width: double.infinity,
               //   child: DropdownButtonHideUnderline(
               //     child: DropdownButton<String>(
               //
               //       value: dropdownValue,
               //       isExpanded: true,
               //       isDense: true,
               //       hint: Text("Select Gender",style:GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),),
               //       //icon: const Icon(Icons.arrow_downward),
               //       elevation: 16,
               //       style:  TextStyle(color: Colors.black87),
               //       underline: Container(
               //         height: 2,
               //         color: Colors.grey,
               //       ),
               //       onChanged: (String? newValue) {
               //         setState(() {
               //           dropdownValue = newValue!;
               //           if(newValue=='Male'){
               //             setState(() {
               //               Gender='M';
               //             });
               //           }else if(newValue=='Female'){
               //             setState(() {
               //               Gender='F';
               //             });
               //           }else if(newValue=='Others'){
               //             setState(() {
               //               Gender='O';
               //             });
               //           }
               //           print(Gender);
               //         });
               //       },
               //       items: <String>['Male', 'Female', 'Others']
               //           .map<DropdownMenuItem<String>>((String value) {
               //         return DropdownMenuItem<String>(
               //           value: value,
               //           child: Text(value,style: TextStyle(fontSize: 20,color: Color(0xff5F5F5F))),
               //         );
               //       }).toList(),
               //     ),
               //   ),
               // )
             ],
           ),
         )
          //Stack(
        //   alignment: Alignment.center,
        //   children: [
        //      image(context),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20),
        //       child: ,
        //     ),
        //   ],
        //   overflow: Overflow.visible,
        // ),
      ),
    );
  }
  Widget buildReportAndChoose(BuildContext context){
    return Row(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                side:BorderSide(color: Colors.black),
                primary:Color(0xff4889FD)),
            onPressed: (){}, child: Text('Report',style: TextStyle(color: Colors.white),)),
        SizedBox(width: 15,),
        Row(
          children: [
            Icon(Icons.file_copy_outlined,color: Color(0xff6B779A,),),
            Text('Choose File',style: TextStyle(color: Color(0xff6B779A,),fontSize: 10,fontWeight: FontWeight.w400),)
          ],
        )
      ],
    );
  }
  Widget buildSaveButton(BuildContext context){
    updatePatientProfileNotifier =
    Provider.of<UpdatePatientProfileNotifier?>(context, listen: false)!;
    return Padding(
        padding:  EdgeInsets.only(top:50,bottom: 10,left: 20,right: 20),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Builder(
            builder: (context) {
              return ElevatedButton(onPressed: (){
                if(_key.currentState!.validate()&&Gen.isNotEmpty){
                  updatePatientProfileNotifier!.patientUpdateProfile(id, _editingController.text, calc.text.isEmpty?_age.text:calc.text, Gen,_images_profile.toString(),filename.toString());
                }else if(_age.text.isEmpty){
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please Select Date of Birth')));
                }else if(Gen.isEmpty){
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please Select Gender')));
                }

                // Navigator.pop(context);
              },
                  child: Text('Save',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                  style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
              );
            }
          ),
        ));
  }
  Widget image(BuildContext context){
    return
      Stack(
        children: [
          GestureDetector(
            onTap: () {
              showOptions();
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xffFDCF09),
              child: _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  DataConstants.LIVE_BASE_URL+'/'+imagestored,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(80),
          //   child: CachedNetworkImage(
          //       fit: BoxFit.cover,
          //       width: 100,
          //       height: 100,
          //       placeholder: (context, url) => Image.asset('assets/images/giphy.gif'),
          //       imageUrl:
          //       "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRLe5PABjXc17cjIMOibECLM7ppDwMmiDg6Dw&usqp=CAU"),
          // ),
          Positioned(
            top: 70,
            left: 75,
            child: CircleAvatar(
                backgroundColor: Color(0xff6BA0FF),
                child: Icon(Icons.camera_alt_outlined,color: Colors.white,)),
          )
        ],
        overflow: Overflow.visible,
      );
  }
  Widget backButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(left:6),
                  child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.031),
          child: Align(
              alignment: Alignment.center,
              child: Text('Edit Profile',style: TextStyle(fontSize: 25,color: Colors.white))),
        ),
        const SizedBox(width: 45,)
        // TextButton(onPressed: (){
        //   updatePatientProfileNotifier!.patientUpdateProfile(12.toString(), 'Irfan', _ageController.text.toString(), 'M',_images_profile,filename);
        // }, child: Padding(
        //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.031,right: 10),
        //   child: Text('Save',style: TextStyle(fontSize: 16,color: Colors.white)),
        // ))
      ],
    );
  }

  Widget editingTextField(context){
     return TextFormField(
       validator: validateText,
       controller:_editingController ,
       decoration: InputDecoration(
         focusedBorder: UnderlineInputBorder(
           borderSide: BorderSide(color: Color(0xff4889FD)),
         ),
         // enabledBorder: OutlineInputBorder(
         //   borderRadius: BorderRadius.circular(10),
         //   borderSide: BorderSide(color: Color(0xff4482F0))
         // ),
         // border: OutlineInputBorder(
         //   borderRadius: BorderRadius.circular(10),
         // ),
         labelText: 'Name',
         labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),
       ),
     );
       //TextFormField(
    //   controller: _editingController,
    //   // initialValue: userNames ,
    //   decoration: InputDecoration(
    //     focusedBorder: UnderlineInputBorder(
    //       borderSide: BorderSide(color: Color(0xff4889FD)),
    //     ),
    //     hintText: 'Praveen',
    //     hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),
    //   ),
    // );
  }
  Widget AddressTextField(context){
     return TextFormField(
       maxLines: 3,
       minLines: 1,
       validator: validateAddress,
       controller:_Address ,
       decoration: InputDecoration(
         focusedBorder: UnderlineInputBorder(
           borderSide: BorderSide(color: Color(0xff4889FD)),
         ),
         // enabledBorder: OutlineInputBorder(
         //   borderRadius: BorderRadius.circular(10),
         //   borderSide: BorderSide(color: Color(0xff4482F0))
         // ),
         // border: OutlineInputBorder(
         //   borderRadius: BorderRadius.circular(10),
         // ),
         labelText: 'Address',
         labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),
       ),
     );
       //TextFormField(
    //   controller: _editingController,
    //   // initialValue: userNames ,
    //   decoration: InputDecoration(
    //     focusedBorder: UnderlineInputBorder(
    //       borderSide: BorderSide(color: Color(0xff4889FD)),
    //     ),
    //     hintText: 'Praveen',
    //     hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),
    //   ),
    // );
  }
}

// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
//
// class Edit_Profile extends StatefulWidget {
//   const Edit_Profile({Key? key}) : super(key: key);
//
//   @override
//   _Edit_ProfileState createState() => _Edit_ProfileState();
// }
//
//
// class _Edit_ProfileState extends State<Edit_Profile> {
//   int? _result;
//   final picker = ImagePicker();
//   var _images_profile;
//   String filename='';
//   File? _image;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: buildBody(context),
//       ),
//     );
//   }
//
//   Widget buildBody(BuildContext context) {
//     return SingleChildScrollView(
//       child: Stack(
//         children: [
//           buildBackgroundandTitle(context),
//           buildProfileList(context),
//         ],
//       ),
//     );
//   }
//
//   Widget buildBackgroundandTitle(BuildContext context) {
//     return Container(
//       // height: MediaQuery.of(context).size.height*0.4,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(13), bottomRight: Radius.circular(13)),
//         color: Color(0xff4889FD),
//       ),
//       child: Column(
//         children: [
//           backButton(context),
//           Padding(
//             padding: const EdgeInsets.only(top: 20, left: 20),
//             child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Text('Edit Profile', style: ProfileStyle(context))),
//           ),
//           Container(
//             height: 234,
//             width: 234,
//             decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.05),
//                 borderRadius: BorderRadius.circular(150)),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget buildProfileList(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 200),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             buildUsernameAndWidgets(context),
//             buildBackButton(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildUsernameAndWidgets(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(20)),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Positioned(top: -50, child: image(context)),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 60),
//                   child: Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         'Change Profile',
//                         style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             color: Color(0xff8B8B8B)),
//                       )),
//                 ),
//                 SizedBox(
//                   height: 18,
//                 ),
//                 Divider(
//                   color: Color(0xffEDF1F7),
//                 ),
//                 Text(
//                   'Name',
//                   style: GoogleFonts.roboto(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff5F5F5F)),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintText: 'Praveen',
//                     hintStyle: GoogleFonts.roboto(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 20,
//                         color: Color(0xffC9C9C9)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   'Age',
//                   style: GoogleFonts.roboto(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff5F5F5F)),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 130,
//                       child: TextField(
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Color(0xff4482F0))),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           hintText: '23',
//                           hintStyle: GoogleFonts.roboto(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 20,
//                               color: Color(0xffC9C9C9)),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 50),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Edit',
//                             style: GoogleFonts.roboto(
//                                 color: Color(0xffAAAAAA),
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 19),
//                           ),
//                           Icon(
//                             Icons.edit,
//                             color: Color(0xffAAAAAA),
//                           )
//                         ],
//                       ),
//                     )
//                     // Container(
//                     //   width: 130,
//                     //   child: TextField(
//                     //     decoration: InputDecoration(
//                     //       enabledBorder: OutlineInputBorder(
//                     //           borderRadius: BorderRadius.circular(10),
//                     //           borderSide: BorderSide(color: Color(0xff4482F0))
//                     //       ),
//                     //       border: OutlineInputBorder(
//                     //         borderRadius: BorderRadius.circular(10),
//                     //       ),
//                     //       labelText: 'height',
//                     //       labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20,color: Color(0xffC9C9C9)),
//                     //     ),
//                     //   ),
//                     // )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   'Gender',
//                   style: GoogleFonts.roboto(
//                       fontWeight: FontWeight.w400, fontSize: 20),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   children: [
//                     Flexible(
//                       child: RadioListTile(
//                         activeColor: Colors.blue,
//                         value: 1,
//                         groupValue: _result,
//                         onChanged: (ind) =>
//                             setState(() => _result = ind as int?),
//                         title: Text(
//                           "Male",
//                           style:
//                               TextStyle(fontSize: 18, color: Color(0xffAAAAAA)),
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       child: RadioListTile(
//                         activeColor: Colors.blue,
//                         value: 2,
//                         groupValue: _result,
//                         onChanged: (ind) =>
//                             setState(() => _result = ind as int?),
//                         title: Text(
//                           "Female",
//                           style:
//                               TextStyle(fontSize: 18, color: Color(0xffAAAAAA)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // SizedBox(height: 30,),
//                 // Row(
//                 //   children: [
//                 //     Text("Issues",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w400),),
//                 //     Spacer(),
//                 //     Text('(Optional)',style: GoogleFonts.roboto(fontWeight: FontWeight.w300,fontSize: 15,color: Color(0xffC9C9C9)),)
//                 //   ],
//                 // ),
//                 // Divider(color: Color(0xffEDF1F7),),
//                 // // SizedBox(height: 60,),
//                 // // Text('Trafalgar D. Water Law',style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w700),),
//                 // // SizedBox(height: 5,),
//                 // // Text('20 Years old',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xff8F9BB3)),),
//                 // // SizedBox(height: 20,),
//                 // // Divider(color: Color(0xffEDF1F7),),
//                 // // Row(
//                 // //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 // //   children: [
//                 // //     Column(
//                 // //       children: [
//                 // //         CircleAvatar(
//                 // //           radius: 40,
//                 // //           backgroundColor: Color(0xff7ACEFA).withOpacity(0.15),
//                 // //           child: Icon(Icons.person,color: Color(0xff7ACEFA),),
//                 // //         ),
//                 // //         SizedBox(height: 10,),
//                 // //         Text('Saved',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),),
//                 // //         Text('Doctors',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),)
//                 // //       ],
//                 // //     ),
//                 // //     Column(
//                 // //       children: [
//                 // //         CircleAvatar(
//                 // //           radius: 40,
//                 // //           backgroundColor: Color(0xffE8899E).withOpacity(0.15),
//                 // //           child: Icon(Icons.file_copy,color: Color(0xffE8899E),),
//                 // //         ),
//                 // //         SizedBox(height: 10,),
//                 // //         Text('Saved',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),),
//                 // //         Text('Articles',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),)
//                 // //       ],
//                 // //     ),
//                 // //     Column(
//                 // //       children: [
//                 // //         CircleAvatar(
//                 // //           radius: 40,
//                 // //           backgroundColor: Color(0xffF7C480).withOpacity(0.15),
//                 // //           child: Icon(Icons.favorite_border,color: Color(0xffF7C480),),
//                 // //         ),
//                 // //         SizedBox(height: 10,),
//                 // //         Text('Health',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),),
//                 // //         Text('Dairy',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff8F9BB3)),)
//                 // //       ],
//                 // //     ),
//                 // //   ],
//                 // // ),
//                 // //SizedBox(height: 20,),
//                 // // Divider(color: Color(0xffEDF1F7),),
//                 // // SizedBox(height: 5,),
//                 // // ListTile(
//                 // //   leading: Container(
//                 // //     decoration: BoxDecoration(
//                 // //       borderRadius: BorderRadius.circular(5),
//                 // //       color: Color(0xff4889FD).withOpacity(0.08),
//                 // //     ),
//                 // //     child: Padding(
//                 // //       padding: const EdgeInsets.all(12),
//                 // //       child: Icon(Icons.calendar_today,color: Color(0xff231F20),),
//                 // //     ),
//                 // //   ),
//                 // //   title: Text('Appointment',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
//                 // //   trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
//                 // // ),
//                 // // Divider(color: Color(0xffEDF1F7),),
//                 // // SizedBox(height: 5,),
//                 // // ListTile(
//                 // //   leading: Container(
//                 // //     decoration: BoxDecoration(
//                 // //       borderRadius: BorderRadius.circular(5),
//                 // //       color: Color(0xff4889FD).withOpacity(0.08),
//                 // //     ),
//                 // //     child: Padding(
//                 // //       padding: const EdgeInsets.all(12),
//                 // //       child: Icon(Icons.opacity_outlined,color: Color(0xff231F20),),
//                 // //     ),
//                 // //   ),
//                 // //   title: Text('Pills Remainder',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
//                 // //   trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
//                 // // ),
//                 // // Divider(color: Color(0xffEDF1F7),),
//                 // // SizedBox(height: 5,),
//                 // // GestureDetector(
//                 // //   onTap: (){Navigator.pushNamed(context, RoutePaths.My_Doctor);},
//                 // //   child: ListTile(
//                 // //     leading: Container(
//                 // //       decoration: BoxDecoration(
//                 // //         borderRadius: BorderRadius.circular(5),
//                 // //         color: Color(0xff4889FD).withOpacity(0.08),
//                 // //       ),
//                 // //       child: Padding(
//                 // //         padding: const EdgeInsets.all(12),
//                 // //         child: Icon(Icons.person_outline,color: Color(0xff231F20),),
//                 // //       ),
//                 // //     ),
//                 // //     title: Text('My Doctor',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
//                 // //     trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
//                 // //   ),
//                 // // ),
//                 // // Divider(color: Color(0xffEDF1F7),),
//                 // // SizedBox(height: 5,),
//                 // // GestureDetector(
//                 // //   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Family_member()));},
//                 // //   child: ListTile(
//                 // //     leading: Container(
//                 // //       decoration: BoxDecoration(
//                 // //         borderRadius: BorderRadius.circular(5),
//                 // //         color: Color(0xff4889FD).withOpacity(0.08),
//                 // //       ),
//                 // //       child: Padding(
//                 // //         padding: const EdgeInsets.all(12),
//                 // //         child: Icon(Icons.groups_outlined,color: Color(0xff231F20),),
//                 // //       ),
//                 // //     ),
//                 // //     title: Text('Family Member',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
//                 // //     trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
//                 // //   ),
//                 // // ),
//                 // // Divider(color: Color(0xffEDF1F7),),
//                 // // SizedBox(height: 5,),
//                 // // GestureDetector(
//                 // //   onTap: (){Navigator.pushNamed(context, RoutePaths.Health_Record);},
//                 // //   child: ListTile(
//                 // //     leading: Container(
//                 // //       decoration: BoxDecoration(
//                 // //         borderRadius: BorderRadius.circular(5),
//                 // //         color: Color(0xff4889FD).withOpacity(0.08),
//                 // //       ),
//                 // //       child: Padding(
//                 // //         padding: const EdgeInsets.all(12),
//                 // //         child: Icon(Icons.file_copy_outlined,color: Color(0xff231F20),),
//                 // //       ),
//                 // //     ),
//                 // //     title: Text('EHR File',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
//                 // //     trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
//                 // //   ),
//                 // // ),
//                 // // Divider(color: Color(0xffEDF1F7),),
//                 // // SizedBox(height: 5,),
//                 // // ListTile(
//                 // //   leading: Container(
//                 // //     decoration: BoxDecoration(
//                 // //       borderRadius: BorderRadius.circular(5),
//                 // //       color: Color(0xff4889FD).withOpacity(0.08),
//                 // //     ),
//                 // //     child: Padding(
//                 // //       padding: const EdgeInsets.all(12),
//                 // //       child: Icon(Icons.payment_outlined,color: Color(0xff231F20),),
//                 // //     ),
//                 // //   ),
//                 // //   title: Text('Payment History',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700),),
//                 // //   trailing: Icon(Icons.chevron_right,color:Color(0xff222B45),),
//                 // // ),
//                 // // Divider(color: Color(0xffEDF1F7),),
//                 // SizedBox(height: 20,),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(left: 10,bottom: 5),
//                 //   child: Text('Previous Issue',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
//                 // ),
//                 // TextField(
//                 //   maxLines: 4,
//                 //   decoration: InputDecoration(
//                 //       enabledBorder: OutlineInputBorder(
//                 //           borderRadius: BorderRadius.circular(10),
//                 //           borderSide: BorderSide(color: Color(0xff4482F0))
//                 //       ),
//                 //       border: OutlineInputBorder(
//                 //         borderRadius: BorderRadius.circular(10),
//                 //       ),
//                 //       hintText: 'write your problem',
//                 //       hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 16)
//                 //   ),
//                 // ),
//                 // SizedBox(height: 20,),
//                 // buildReportAndChoose(context),
//                 // SizedBox(height: 20,)
//                 SizedBox(
//                   height: 20,
//                 )
//               ],
//             ),
//           ),
//         ],
//         overflow: Overflow.visible,
//       ),
//     );
//   }
//
//   Widget buildReportAndChoose(BuildContext context) {
//     return Row(
//       children: [
//         ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 side: BorderSide(color: Colors.black),
//                 primary: Color(0xff4889FD)),
//             onPressed: () {},
//             child: Text(
//               'Report',
//               style: TextStyle(color: Colors.white),
//             )),
//         SizedBox(
//           width: 15,
//         ),
//         Row(
//           children: [
//             Icon(
//               Icons.file_copy_outlined,
//               color: Color(
//                 0xff6B779A,
//               ),
//             ),
//             Text(
//               'Choose File',
//               style: TextStyle(
//                   color: Color(
//                     0xff6B779A,
//                   ),
//                   fontSize: 10,
//                   fontWeight: FontWeight.w400),
//             )
//           ],
//         )
//       ],
//     );
//   }
//
//   Widget buildBackButton(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.only(
//           top: 10,
//           bottom: 20,
//         ),
//         child: SizedBox(
//           height: 50,
//           width: double.infinity,
//           child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Back',
//                 style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
//               ),
//               style: ElevatedButton.styleFrom(
//                   primary: Color(0xff4889FD),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)))),
//         ));
//   }
//
//   Widget image(BuildContext context) {
//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: () {
//             showOptions();
//           },
//           child: CircleAvatar(
//             radius: 55,
//             backgroundColor: Color(0xffFDCF09),
//             child: _image != null
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(50),
//                     child: Image.file(
//                       _image!,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.fill,
//                     ),
//                   )
//                 : Container(
//                     decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(50)),
//                     width: 100,
//                     height: 100,
//                     child: Icon(
//                       Icons.camera_alt,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//           ),
//         ),
//         // ClipRRect(
//         //   borderRadius: BorderRadius.circular(80),
//         //   child: CachedNetworkImage(
//         //       fit: BoxFit.cover,
//         //       width: 100,
//         //       height: 100,
//         //       placeholder: (context, url) => Image.asset('assets/images/giphy.gif'),
//         //       imageUrl:
//         //       "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRLe5PABjXc17cjIMOibECLM7ppDwMmiDg6Dw&usqp=CAU"),
//         // ),
//         Positioned(
//           top: 65,
//           left: 65,
//           child: CircleAvatar(
//               backgroundColor: Color(0xff6BA0FF),
//               child: Icon(
//                 Icons.camera_alt_outlined,
//                 color: Colors.white,
//               )),
//         )
//       ],
//       overflow: Overflow.visible,
//     );
//   }
//   Future getImageFromGallery_Profile() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         // print(_image);
//         filename=pickedFile.path.split('/').last;
//         print("irfan");
//         _images_profile= pickedFile.path;
//         print(pickedFile.path);
//         print(_images_profile);
//         print(filename);
//       }
//     });
//   }
//
//   //Image Picker function to get image from camera
//   Future getImageFromCamera_Profile() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//     print(pickedFile);
//     print(_images_profile);
//     print('abdur');
//     setState(() {
//       if (pickedFile != null){
//         _image = File(pickedFile.path);
//         print("irfan");
//         filename=pickedFile.path.split('/').last;
//         _images_profile= pickedFile.path;
//         print(_images_profile);
//         print('abdur');
//         print(_image);
//         print(filename);
//       }
//     });
//   }
//
//   Future showOptions() async {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoActionSheet(
//         actions: [
//           CupertinoActionSheetAction(
//             child: Text('Photo Gallery'),
//             onPressed: () {
//               // close the options modal
//               Navigator.of(context).pop();
//               // get image from gallery
//               getImageFromGallery_Profile();
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: Text('Camera'),
//             onPressed: () {
//               // close the options modal
//               Navigator.of(context).pop();
//               // get image from camera
//               getImageFromCamera_Profile();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget backButton(context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pop(context);
//       },
//       child: Padding(
//         padding: EdgeInsets.only(
//             top: MediaQuery.of(context).size.height * 0.03, left: 20),
//         child: Align(
//           alignment: Alignment.topLeft,
//           child: Container(
//             height: 36,
//             width: 36,
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 2),
//                 borderRadius: const BorderRadius.all(Radius.circular(20))),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 6),
//               child: Icon(
//                 Icons.arrow_back_ios,
//                 size: 15,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }