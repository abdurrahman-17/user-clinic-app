import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/innershadow.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
import 'package:user_clinic_token_app/view/profile/profile.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      body: buildBody(context),
    );
  }
  Widget buildBody(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildWelcomeBack(context),
        buildCard(context),
        buildCategoryCard(context),
      ],
    );
  }
  Widget buildWelcomeBack(BuildContext context){
    return Text(
      'Hi, Sulaiman '+ Languages.of(context)!.welcomeback,
      style: TextStyle(fontSize: 20),
    );
  }
  Widget buildCarousleSlider(BuildContext context){
    return Container(

    ); }
  Widget buildCard(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                const BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Colors.black26,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dr. Chinnaswami Muthuswami Venugopal Iyer M.B.B.S',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(

                    height: 10,
                  ),
                  SizedBox(

                    width: 250,
                    child: Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(

                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '14 YRS EXP',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(

                        width: 10,
                      ),
                      Icon(Icons.local_hospital_outlined,size: 15,color: Colors.white,),
                      Text(
                        'Heart Surgeon',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(

                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          'https://thumbs.dreamstime.com/b/portrait-happy-arabic-doctor-male-blue-background-square-smiling-to-camera-wearing-white-uniform-posing-headshot-cheerful-233544543.jpg',
                          height: 60.0,
                          width: 60.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(

                          height: 40,
                          width: 150,
                          child: InnerShadow(
                            color:
                            Theme.of(context).primaryColorLight.withOpacity(0.25),
                            offset: const Offset(0.5, 0.5),
                            blur: 20,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, RoutePaths.PROFILE);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                    child: FittedBox(
                                      child: Text(
                                        'Book Appointment',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InnerShadow(
                        color: Theme.of(context).primaryColorLight.withOpacity(0.25),
                        offset: const Offset(1.0, 1.0),
                        blur: 10,
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              '19',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -24,
            right: -32,
            child: Image.asset(
              'assets/images/seth_end.png',
            ),
          ),
          Positioned(
            bottom: -10,
            left: -31,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(2 / 360),
              child: Image.asset(
                'assets/images/seth_top.png',
              ),),
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
  Widget buildCategoryCard(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
      ),
      child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  childAspectRatio: 4/3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: [
                    GestureDetector(
                      onTap: (){Navigator.pushNamed(context, RoutePaths.NoOFAppointment);},
                      child: Container(
                        // height: 155,
                        // width: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/images/doc_appointment.png',
                              color: Color(0xff31B8FF),

                            ),
                            Text('No.of appointment',style: TextStyle(color: Color(0xff31B8FF)),)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){Navigator.pushNamed(context, RoutePaths.FAMILYMEMEBER);},
                      child: Container(
                        // height: 155,
                        // width: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(AppImages.FAMILY,
                                color: Color(0xffE8899E)),
                            Text('Family Members',style: TextStyle(color: Color(0xffE8899E)),)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){Navigator.pushNamed(context, RoutePaths.Setting);},
                      child: Container(
                        // height: 155,
                        // width: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(AppImages.WORKINGSCHEDULE,
                                color:Color(0xffF7C480)),
                            Text('Last Visited',style: TextStyle(color: Color(0xffFFB830)),)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Profile()));},
                      child: Container(
                        // height: 155,
                        // width: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(AppImages.BED,
                                color: Color(0xff1EC760)),
                            Text('Health Records',style: TextStyle(color: Color(0xff1EC760)),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
            // Column(
            //   children: [
            //     SizedBox(height: 10,),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         GestureDetector(
            //           onTap: () {
            //             Navigator.pushNamed(
            //                 context, RoutePaths.Doctor_Profile_token);
            //           },
            //           child: Container(
            //              height: MediaQuery.of(context).size.height*0.15,
            //              width: 145,
            //             decoration: BoxDecoration(
            //               color: Theme.of(context).scaffoldBackgroundColor,
            //               borderRadius:
            //               BorderRadius.only(topLeft: Radius.circular(20)),
            //               boxShadow: [
            //                 BoxShadow(
            //                   offset: Offset(0, 4),
            //                   blurRadius: 4,
            //                   color: Colors.black26,
            //                 ),
            //               ],
            //             ),
            //             child: Image.asset(
            //               AppImages.DOCTORAPPOINTMENT,
            //                 height: 10,width: 10,
            //               color: Theme.of(context).iconTheme.color,
            //             ),
            //           ),
            //         ),
            //         const SizedBox(
            //           width: 25,
            //         ),
            //         GestureDetector(
            //           onTap: () {
            //             Navigator.pushNamed(
            //                 context, RoutePaths.FAMILYMEMEBER);
            //           },
            //           child: Container(
            //             height: MediaQuery.of(context).size.height*0.15,
            //             width: 145,
            //             decoration: BoxDecoration(
            //               color: Theme.of(context).scaffoldBackgroundColor,
            //               borderRadius: BorderRadius.only(
            //                   topRight: Radius.circular(20)),
            //               boxShadow: [
            //                 BoxShadow(
            //                   offset: Offset(0, 4),
            //                   blurRadius: 4,
            //                   color: Colors.black26,
            //                 ),
            //               ],
            //             ),
            //             child: Image.asset(AppImages.FAMILY,
            //                 color: Theme.of(context).iconTheme.color),
            //           ),
            //         ),
            //       ],
            //     ),
            //     const SizedBox(
            //       height: 25,
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         GestureDetector(
            //           onTap: () {
            //             //Navigator.pushNamed(context, RoutePaths.SIGNUP);
            //           },
            //           child: Container(
            //             height: MediaQuery.of(context).size.height*0.15,
            //             width: 145,
            //             decoration: BoxDecoration(
            //               color: Theme.of(context).scaffoldBackgroundColor,
            //               borderRadius: BorderRadius.only(
            //                   bottomLeft: Radius.circular(20)),
            //               boxShadow: [
            //                 BoxShadow(
            //                   offset: Offset(0, 4),
            //                   blurRadius: 4,
            //                   color: Colors.black26,
            //                 ),
            //               ],
            //             ),
            //             child: Image.asset(AppImages.WORKINGSCHEDULE,
            //                 color: Theme.of(context).iconTheme.color),
            //           ),
            //         ),
            //         const SizedBox(
            //           width: 25,
            //         ),
            //         GestureDetector(
            //           onTap: (){},
            //           child: Container(
            //             height: MediaQuery.of(context).size.height*0.15,
            //             width: 145,
            //             decoration: BoxDecoration(
            //               color: Theme.of(context).scaffoldBackgroundColor,
            //               borderRadius: BorderRadius.only(
            //                   bottomRight: Radius.circular(20)),
            //               boxShadow: [
            //                 BoxShadow(
            //                   offset: Offset(0, 4),
            //                   blurRadius: 4,
            //                   color: Colors.black26,
            //                 ),
            //               ],
            //             ),
            //             child: Image.asset(AppImages.BED,
            //                 color: Theme.of(context).iconTheme.color),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
