import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/privacyPolicy/privacyPolicy_Notifier.dart';

class Privacy_Policy extends StatefulWidget {
   Privacy_Policy({Key? key}) : super(key: key);

  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
  Privacy_Policy_Notifier provider=Privacy_Policy_Notifier();
  @override
  void initState() {

    Future.delayed(Duration.zero,(){
      provider.PrivacyPolicy_data();
      provider.notifyListeners();
      print(provider.privacyPolicy_ResponseClass.privacyPolicy);
      //print(provider.privacyPolicy_ResponseClass.updateDate.toString());
    });
    // TODO: implement initState
    super.initState();

   }

  @override
  Widget build(BuildContext context) {
    return Consumer<Privacy_Policy_Notifier>(
      builder: (context,provider,_){
        this.provider=provider;
        return ModalProgressHUD(inAsyncCall: provider.isloading, child:
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              centerTitle: true,
              elevation:0,
              leading:GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:  EdgeInsets.only(top: 10,left: 10),
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
              title: Text('Privacy Policy'),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Image.network(DataConstants.LIVE_BASE_URL+'/'+'logo/icons8-terms-and-conditions-64.png',height: 80,width: 80,fit: BoxFit.fill,),
                  //     Text('Terms And Conditions',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800),)
                  //   ],
                  // ),
                  Image.asset('assets/images/mainscreen/privacy-policy-illustration-design-concept-illustration-websites-landing-pages-mobile-applications-posters-banners_108061-890.jpg',height: 300,width: double.infinity,),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 15),
                  //   child: Row(
                  //     children: [
                  //       Flexible(child: Text('Last Updated: ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)),
                  //       Flexible(child: Html(data: provider.termsAndConditions_Date_ResponseClass.updateDate)),
                  //     ],
                  //   ),
                  // ),
                  Html(data: provider.privacyPolicy_ResponseClass.privacyPolicy??'')
                ],
              ),
            ),
          ),
        ) );
      },

    );
  }
}
