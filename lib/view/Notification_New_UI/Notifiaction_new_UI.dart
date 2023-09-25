import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/Notification%20API/notification_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/notification_Count/notification_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/notification_on_off/notification_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/read_Notification/read_Notification_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';

class Notification_New extends StatefulWidget {
  const Notification_New({Key? key}) : super(key: key);

  @override
  State<Notification_New> createState() => _Notification_NewState();
}

class _Notification_NewState extends State<Notification_New> {
  ALL_Notification_Notifier provider=ALL_Notification_Notifier();
  read_Notification_Notfier read_notification_notfier=read_Notification_Notfier();
  Notification_Count_Notifier notification_count_notifier=Notification_Count_Notifier();

  void refresh(){
    Future.delayed(Duration.zero,(){
      notification_count_notifier.Notification_count_data(id);
      notification_count_notifier.notifyListeners();
      print('irfan');
      print(notification_count_notifier.Notification_count);
    });

  }
  String id='';
  @override
  void initState() {
    MySharedPreferences.instance.getid('id').then((value) {
      id=value.toString();
      print(id);
    });
    refresh();
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero,(){
     provider.Notification_data(id);
     provider.notifyListeners();
     print('irfan'+provider.earlier_notification_ResponseClass.length.toString());
      });

  }
  @override
  void dispose() {
    refresh();
    Future.delayed(Duration.zero,(){
      read_notification_notfier.read_Notification_Data(id);
      Navigator.pop(context);
      print('check');
    });
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<ALL_Notification_Notifier>(
      builder: (context,provider,_){
        this.provider=provider;
        return ModalProgressHUD(inAsyncCall:provider.isLoading , child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: PreferredSize(
          //   preferredSize:  Size.fromHeight(60),
          //   child: buildAppbar(context),
          // ),
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: buildbody(context)),
        ));
      },

    );

  }
  Widget buildbody(context){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(context),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20),
              child: Text('Today',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
            ),
            provider.notification_ResponseClass.length==0?Center(child: Padding(
              padding: const EdgeInsets.only(top: 40,bottom: 40),
              child: Text('No New Notification'),
            )):ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.notification_ResponseClass.length,itemBuilder: (context,index){
              return provider.notification_ResponseClass[index].readStatus==0?Container(
                child: Container(
                  color: Colors.blueAccent.withOpacity(0.2),
                  child: ListTile(
                  contentPadding: EdgeInsets.only(top: 10,left: 10,right: 10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(DataConstants.LIVE_BASE_URL+'/'+provider.notification_ResponseClass[index].image.toString()),
                    ),
                    title: Text(provider.notification_ResponseClass[index].title.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(provider.notification_ResponseClass[index].body.toString()),
                    ),
                  ),
                ),
              ):ListTile(
                contentPadding: EdgeInsets.only(top: 10,left: 10,right: 10),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(DataConstants.LIVE_BASE_URL+'/'+provider.notification_ResponseClass[index].image.toString()),
                ),
                title: Text(provider.notification_ResponseClass[index].title.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(provider.notification_ResponseClass[index].body.toString()),
                ),
              );
            }),Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Earlier',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
            ),
            provider.earlier_notification_ResponseClass.length==0?Center(child: Padding(
              padding: const EdgeInsets.only(top: 40,bottom: 40),
              child: Text('No Earlier Notification'),
            )):ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.earlier_notification_ResponseClass.length,itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(DataConstants.LIVE_BASE_URL+'/'+provider.earlier_notification_ResponseClass[index].image.toString()),
                  ),
                  title: Text(provider.earlier_notification_ResponseClass[index].title.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(provider.earlier_notification_ResponseClass[index].body.toString()),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
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
            padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
            child: Text('Notification',style:GoogleFonts.roboto(fontSize: 25),),
          ),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
  Widget buildAppbar(context){
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding:  EdgeInsets.only(left: 5),
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
        'Notification',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
