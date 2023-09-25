import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/add_family_member/add_family_member_notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/common/app_validators.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';


class Add_Family_Member extends StatefulWidget {
  const Add_Family_Member({Key? key}) : super(key: key);

  @override
  _Add_Family_MemberState createState() => _Add_Family_MemberState();
}
class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}
class _Add_Family_MemberState extends State<Add_Family_Member> {
  Add_Family_Member_Notifier? add_family_member_notifier;
  TextEditingController _name=TextEditingController();
  TextEditingController _age=TextEditingController();
  TextEditingController _issues=TextEditingController();
  GlobalKey<FormState> _key=GlobalKey();
  TextEditingController calc = TextEditingController();
  int? _result;
  String Gen='';
  String filename='';
  String filename_report='';
  File? _image;
  File? _image_report;
  final picker = ImagePicker();
  final picker_report = ImagePicker();
  var _images_report;
  var _images_profile;
  String? dropdownValue;
  String? Gender;
  String birthDate = "";
  int age = -1;

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

  List users = [
    const Item('Male',Icon(Icons.male_outlined,color:   Color(0xFF167F67),)),
    const Item('Female',Icon(Icons.female_outlined,color:   Color(0xFF167F67),)),
    const Item('Others',Icon(Icons.transgender_outlined,color:   Color(0xFF167F67),)),
  ];
  String id='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance.getid("id").then((value) => setState((){
      id=value.toString();
      print('irfan');
      print(id);
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Add_Family_Member_Notifier>(
      builder: (context,provider,_) {
        return ModalProgressHUD(
            inAsyncCall: provider.isLoading, child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xffF5F6FC),
            body: buildBody(context),
          ),
        ));
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
      //height: MediaQuery.of(context).size.height*0.4,
      height: 300,
      width: double.infinity,
      color: Color(0xff4889FD),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(13),bottomRight: Radius.circular(13)
      //   ),
      //   color: Color(0xff4889FD),
      // ),
      child: Column(
        children: [
          backButton(context),
          SizedBox(height: 20,),
          image(context),
          // Container(
          //   height: 234,
          //   width: 234,
          //   decoration: BoxDecoration(color:Colors.black.withOpacity(0.05),borderRadius: BorderRadius.circular(150)),
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
        decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Add info',style: GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff4889FD)),)),
              ),
              SizedBox(height: 10,),
              Divider(color: Color(0xffEDF1F7),),
              TextFormField(
                validator: validateText,
                controller:_name ,
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
              ),
              // SizedBox(height: 20,),
              // Text('Age',style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w400,color: Color(0xff5F5F5F)),),
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
                            validator: validateText,
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
                      padding:  EdgeInsets.only(top: 20.0),
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
               Text('Gender',style: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 20),),
              SizedBox(height: 20,),
              // Container(
              //   width: double.infinity,
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<String>(
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
              // ),
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
        ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text("Medical Report",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w400),),
                  Spacer(),
                  Text('(Optional)',style: GoogleFonts.roboto(fontWeight: FontWeight.w300,fontSize: 15,color: Color(0xffC9C9C9)),)
                ],
              ),
              Divider(color: Color(0xffEDF1F7),),
              //SizedBox(height: 20,),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10,bottom: 5),
              //   child: Text('Previous Issue',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
              // ),
              // TextField(
              //   controller: _issues,
              //   maxLines: 4,
              //   decoration: InputDecoration(
              //       enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //           borderSide: BorderSide(color: Color(0xff4482F0))
              //       ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     hintText: 'write your problem',
              //     hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 16)
              //   ),
              // ),
              SizedBox(height: 0,),
              buildReportAndChoose(context),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
  Widget buildReportAndChoose(BuildContext context){
    return Row(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              // side:BorderSide(color: Colors.black),
              primary:Color(0xff4889FD)),
            onPressed: (){
              //print('abdul');

              showOptions_Report();
            }, child: Text('Upload',style: TextStyle(color: Colors.white),)),
        SizedBox(width: 15,),
        filename_report==''?SizedBox(width: 10,):Expanded(
          child: Row(
            children: [
              Icon(Icons.file_copy_outlined,color: Color(0xff6B779A,),),
              Expanded(child: Text(filename_report,style: TextStyle(color: Color(0xff6B779A,),fontSize: 10,fontWeight: FontWeight.w400),))
            ],
          ),
        )
      ],
    );
  }
  Widget buildSaveButton(BuildContext context){
    add_family_member_notifier =

    Provider.of<Add_Family_Member_Notifier?>(context, listen: false)!;
    return Padding(
        padding: const EdgeInsets.only(top:10,bottom: 20,left: 20,right: 20),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Builder(
            builder: (context) {
              return ElevatedButton(onPressed: (){
                print(Gen.toString());
                if(_key.currentState!.validate()&&_age.text.isNotEmpty&&Gen.isNotEmpty){
                  print('check');
                  add_family_member_notifier?.Add_famil_person(id, _name.text, calc.text, Gen,_images_profile.toString(),filename.toString(),_images_report.toString(),filename_report.toString());
                }else if(_age.text.isEmpty){
                  Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Please Select Date of Birth')));
                }else if(Gen.isEmpty){
                  Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Please Select Gender')));
                }
                // add_family_member_notifier?.Add_famil_person(12.toString(), _name.text.toString(), _age.text.toString(),Gen.toString(),_issues.text.toString());
                //Navigator.pop(context);
              },
                  child: Text('Save',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                  style: ElevatedButton.styleFrom(primary:Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
              );
            }
          ),
        ));
  }
  Widget image(BuildContext context){
    return GestureDetector(
      onTap: () {
        //print('irfan');
        showOptions();
      },
      child: CircleAvatar(
        radius: 55,
        backgroundColor: Color(0xffFDCF09),
        child: _image != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.file(_image!,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
        )
            : Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(50)),
          width: 100,
          height: 100,
          child: Icon(
            Icons.camera_alt,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
    //   ClipRRect(
    //   borderRadius: BorderRadius.circular(80),
    //   child: CachedNetworkImage(
    //       fit: BoxFit.cover,
    //       width: 100,
    //       height: 100,
    //       placeholder: (context, url) => Image.asset('assets/images/giphy.gif'),
    //       imageUrl:
    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRLe5PABjXc17cjIMOibECLM7ppDwMmiDg6Dw&usqp=CAU"),
    // );
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
            padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: 20),
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
          padding:  EdgeInsets.only(top:  MediaQuery.of(context).size.height*0.03,right: 20),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text('Add Members',style: ProfileStyle(context))),
        ),
        SizedBox(width: 20,)
      ],
    );
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

  Future getImageFromGallery_Report() async {
    final pickedFile_report = await picker_report.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile_report != null) {
        _image_report= File(pickedFile_report.path);
        // print(_image);
         filename_report=pickedFile_report.path.split('/').last;
         print("irfan");
        _images_report= pickedFile_report.path;
         print(pickedFile_report.path);
         print(_image_report);
         print(filename);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera_Report() async {
    final pickedFile_report = await picker_report.getImage(source: ImageSource.camera);
   print(pickedFile_report);
    print(_images_report);
    print('abdur');
    setState(() {
      if (pickedFile_report != null){
        _image_report = File(pickedFile_report.path);
        print("irfan");
        filename_report=pickedFile_report.path.split('/').last;
        _images_report= pickedFile_report.path;
        print(_images_report);
        print('abdur');
        print(_image_report);
        print(filename_report);
      }
    });
  }
  Future showOptions() async {
    print('abdul');

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
  Future showOptions_Report() async {
    print('irfan');
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
              getImageFromGallery_Report();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera_Report();
            },
          ),
        ],
      ),
    );
  }

}

