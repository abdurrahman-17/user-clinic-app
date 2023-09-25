import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/request_response/terms%20And%20Conditions/termsAndConditions_Notifier.dart';

class Terms_And_Condition extends StatefulWidget {
  const Terms_And_Condition({Key? key}) : super(key: key);

  @override
  State<Terms_And_Condition> createState() => _Terms_And_ConditionState();
}

class _Terms_And_ConditionState extends State<Terms_And_Condition> {
  TermsAndCondition_Notifier provider=TermsAndCondition_Notifier();
  String date='';
  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      provider.TermsAndConditions_data();
      provider.notifyListeners();
      print(provider.termsAndConditions_ResponseClass.termsCondition);
      print(provider.termsAndConditions_Date_ResponseClass.updateDate);
      final dates=provider.termsAndConditions_Date_ResponseClass.updateDate!;
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
       date = dateFormat.format(dates);
      //print(string);

    });
    // TODO: implement initState
    super.initState();

  }

    @override
  Widget build(BuildContext context) {
    return Consumer<TermsAndCondition_Notifier>(
          builder: (context,provider,_){
            this.provider=provider;
            return ModalProgressHUD(inAsyncCall: provider.isloading, child:SafeArea(
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
                  title: Text('Terms And Condition'),
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
                     Image.asset('assets/images/mainscreen/terms-conditions-concept-illustration_108061-451-removebg-preview (2) 1 (1).png',height: 300,width: double.infinity,),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Flexible(child: Text('Last Updated: ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)),
                            Flexible(child: Text(date)),
                          ],
                        ),
                      ),
                      Html(data: provider.termsAndConditions_ResponseClass.termsCondition ?? '')
                    ],
                  ),
                ),
              ),
            ) );
          },

    );
  }
}
