import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/family%20Member%20Delete/family_Member_Delete_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/list_family_member/list_family_member_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/no%20Image/no_Image_Response_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/Edit%20Family%20Member/edit_Family_Member.dart';


class Family_member extends StatefulWidget {
  const Family_member({Key? key}) : super(key: key);

  @override
  _Family_memberState createState() => _Family_memberState();
}

class _Family_memberState extends State<Family_member> {
  String name = '';
  String id = '';
  String image = '';
  @override

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance.getid("id").then((value) => setState((){
      id=value.toString();
      print('irfan');
      print(id);
    }));
    Future.delayed(Duration.zero, () {
      no_imageprovider.getNo_Image();
      provider.Family_list(id).then((value) {
        print(provider.family_list_ResponseClass.length);
        // for (int i = 0; i < provider.parent_list_ResponseClass.length; i++) {
        //   print(provider.Family_list_Class[i].name.toString());
        //   name = provider.Family_list_Class[i].name.toString();
        //   age = provider.Family_list_Class[i].age.toString();
        //   image = provider.Family_list_Class[i].image.toString();
        // }
      });
      provider.notifyListeners();
    });
  }
  List_family_Member provider = List_family_Member();
  No_Image no_imageprovider=No_Image();
  Family_Member_Delete_Notifier provider_fam_delete = Family_Member_Delete_Notifier();
  @override
  Widget build(BuildContext context) {
    return Consumer<List_family_Member>(
      builder: (context, provider, _) {
        this.provider = provider;
        return ModalProgressHUD(
            inAsyncCall: provider.isLoading,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xffF5F6FC),
                body: buildBody(context),
              ),
            ));
      },
    );

  }


  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(13),
                  bottomRight: Radius.circular(13)),
              color: Color(0xff4889FD),
            ),
          ),
          Positioned(
            top: -17,
            right: -40,
            child: Container(
              height: 190,
              width: 190,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(150)),
              child: Icon(
                Icons.groups_outlined,
                color: Color(0xffFFFFF),
                size: 80,
              ),
            ),
          ),
          Column(
            children: [
              backButton(context),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20, left: 20),
              //   child: Align(
              //       alignment: Alignment.topLeft,
              //       child: Text('Family Member', style: ProfileStyle(context))),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        buildImage(context),
                        buildFamilyList(context),
                        //buildAddNewMember(context),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              build_Add_Member_Button(context)
            ],
          ),
          // SizedBox(
          //   height: 15,
          // ),
          // buildButton(context)
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    placeholder: (context, url) =>
                        Image.asset('assets/images/giphy.gif'),
                    imageUrl:provider.parent_list_ResponseClass.image==null?DataConstants.LIVE_BASE_URL+'/'+no_imageprovider.no_ImageResponseClass: DataConstants.LIVE_BASE_URL+'/'+provider.parent_list_ResponseClass.image.toString()
                //        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRLe5PABjXc17cjIMOibECLM7ppDwMmiDg6Dw&usqp=CAU"
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider.parent_list_ResponseClass.headOfTheFamily.toString(),
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.w700)),
                  Text(
                    provider.parent_list_ResponseClass.age.toString() + ' Years old',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff8F9BB3)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Color(0xffEDF1F7),
          ),
        ],
      ),
    );
  }

  Widget buildFamilyList(BuildContext context) {
    return provider.Family_list_Class.isEmpty?Column(
      mainAxisAlignment:MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10,),
        Icon(Icons.people,color: Colors.grey,size: 80,),
        SizedBox(height: 5,),
        Text('No Family Member',style: TextStyle(fontSize: 18),),
        SizedBox(height: 10,),
      ],
    ):ListView.builder(
            itemCount: provider.Family_list_Class.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.22,
              motion: DrawerMotion(), children: [
                SlidableAction(
                  onPressed: (context){
                    provider_fam_delete.Family_Member_data(12.toString(),provider.family_list_ResponseClass[index].id.toString());
                    provider_fam_delete.notifyListeners();
                    print(provider.family_list_ResponseClass[index].id.toString());

                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
              ),
                    child: GestureDetector(
                      onTap: (){
                        print(provider.family_list_ResponseClass[index].gender);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Edit_Family_Member(id:provider.family_list_ResponseClass[index].id.toString(),name:provider.family_list_ResponseClass[index].name.toString(),images:provider.family_list_ResponseClass[index].image.toString(),age:provider.family_list_ResponseClass[index].age.toString(),gender:provider.family_list_ResponseClass[index].gender.toString())));
                      },
                      child: ListTile(
                        leading: DataConstants.LIVE_BASE_URL+'/'+provider.Family_list_Class[index].image.toString() != DataConstants.LIVE_BASE_URL+'/'+"null"
                            ? Container(
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            //color: Color(0xff4889FD).withOpacity(0.3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.network(
                              DataConstants.LIVE_BASE_URL+'/'+provider.Family_list_Class[index].image.toString(),
                              //color: Color(0xff4889FD),
                            ),
                          ),
                        )
                            : Container(
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff4889FD).withOpacity(0.3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: Color(0xff4889FD),
                            ),
                          ),
                        ),
                        title: Text(
                          provider.Family_list_Class[index].name.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Color(0xff222B45),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xffEDF1F7),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              );
            });
  }

  Widget buildAddNewMember(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30, left: 55, right: 55),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            print("hi");
            if(provider.family_list_ResponseClass.length==5){

              Scaffold.of(context).showSnackBar(SnackBar(content: Text('You Can\'t Add More Then Five People')));
            }else {
              Navigator.pushNamed(context, RoutePaths.Add_Family__Member);
            }
          },
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                color: Color(0xff6EA7FA),
                width: 2,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Add New Member',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff6EA7FA),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build_Add_Member_Button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, bottom: 20, left: 25),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Builder(
          builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  if(provider.family_list_ResponseClass.length==5){

                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('You Can\'t Add More Then Five People')));
                }else {
                    Navigator.popAndPushNamed(
                        context, RoutePaths.Add_Family__Member);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_alt,color: Colors.white,),
                    SizedBox(width: 10,),
                    Text(
                      'Add Family Member',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff4889FD),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))));
          }
        ),
      ),
    );
  }

  Widget backButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03, left: 15),
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:EdgeInsets.only(top: 23,
          //    left: MediaQuery.of(context).size.width*0.02
          ),
          child: Text('Family Member', style: ProfileStyle(context)),
        ),
        SizedBox(width: 30,)
        // Padding(
        //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,right: 10),
        //   child: SizedBox(
        //     height: 30,
        //     child: OutlinedButton(
        //       onPressed: () {
        //         // Navigator.push(context,
        //         //     MaterialPageRoute(builder: (context) => AddDoctor()));
        //         Navigator.pushNamed(context, RoutePaths.Add_Family__Member);
        //       },
        //       style: ButtonStyle(
        //         side: MaterialStateProperty.all(
        //           const BorderSide(
        //             color: Colors.white,
        //             width: 2,
        //           ),
        //         ),
        //         shape: MaterialStateProperty.all(
        //           RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(20.0),
        //           ),
        //         ),
        //       ),
        //       child: Icon(Icons.person_add_alt,color: Colors.white,),
        //       // child:  Text(
        //       //   'Add +',
        //       //   style: TextStyle(
        //       //     fontSize: 18,
        //       //     fontWeight: FontWeight.w600,
        //       //     color: Colors.white,
        //       //   ),
        //       // ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
