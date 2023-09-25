import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:developer' as developer;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/pushnotification.dart';
import 'package:user_clinic_token_app/core/request_response/carousel/DoctorList_notifier.dart';
import 'package:user_clinic_token_app/core/request_response/no%20Image/no_Image_Response_Notifier.dart';
import 'package:user_clinic_token_app/core/request_response/notification_Count/notification_Notifier.dart';
import 'dart:ui';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/innershadow.dart';
import 'package:user_clinic_token_app/utils/sharedpreference/shared_preference.dart';
import 'package:user_clinic_token_app/view/Dr_profile/dr_profile.dart';
import 'package:user_clinic_token_app/view/drawer/drawer.dart';
import 'package:user_clinic_token_app/view/health_record/Health_Record.dart';
import 'package:user_clinic_token_app/view/profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Doctor provider = Doctor();
  No_Image no_imageprovider = No_Image();
  Notification_Count_Notifier notification_count_notifier=Notification_Count_Notifier();
  String name = '';
  String token = '';
  String id = '';
  String image = '';
  String count='';
  Timer? timer;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult? connection;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      connection = await _connectivity.checkConnectivity();
      print(result);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(connection.toString())));
    } on PlatformException catch (e) {
      print(e);
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print('irfan');
      print(_connectionStatus.toString());
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(_connectionStatus.toString())));
    });
  }
  
  void refresh(){
    timer=Timer.periodic(Duration(seconds: 2), (timer) {
      Future.delayed(Duration.zero,(){
        notification_count_notifier.Notification_count_data(id);
        notification_count_notifier.notifyListeners();
      });
      print('irfan');
      print(notification_count_notifier.Notification_count);
      setState(() {
        count=notification_count_notifier.Notification_count;
      });
    });
  }

  @override
  void initState() {
    no_imageprovider.getNo_Image().then((value) {
      image=no_imageprovider.no_ImageResponseClass;
      print(image);
      print('abdur'+image+'irfan');
    });
    no_imageprovider.notifyListeners();
    // TODO: implement initState
    super.initState();
    refresh();
    Future.delayed(Duration.zero,(){

      no_imageprovider.getNo_Image().then((value) {

        image=no_imageprovider.no_ImageResponseClass;
        print(image);
        print('abdur'+image+'irfan');
      });
      no_imageprovider.notifyListeners();

    });
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    print("saad");

    MySharedPreferences.instance.getToken("token").then((value) {
      token = value;
      print(value);
    });
    MySharedPreferences.instance.getid("id").then((value) {
      id = value.toString();
      print(value);
    });

    print("saad");
    print(token);
    print(id);

    Future.delayed(Duration.zero, () {
      provider.getDrProfile();
      provider.notifyListeners();
    });
    MySharedPreferences.instance
        .getusername("name")
        .then((value) => setState(() {
              name = value;
              print(name);
            }));

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message!.notification!.body!=null){
        Navigator.pushNamed(context, RoutePaths.Notification_New);
        //refresh();
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification!=null){
        print(message.notification!.body);
        print(message.notification!.title);
        LocalNotification.display(message);
        //refresh();
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if(message.notification!=null){
        print('hi');
        Navigator.of(context).pushNamed(RoutePaths.Notification_New);
      }
    });
    LocalNotification.initialize(context);
    //refresh();
  }
  void getDoctor(){
    Future.delayed(Duration.zero, () {
      provider.getDrProfile();
      provider.notifyListeners();
    });
  }
  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();

  }
  @override

  int _currentindex = 0;
  Widget build(BuildContext context) {
    if (kReleaseMode) {}
    return Consumer<Doctor>(
      builder: (context, provider, _) {
        this.provider = provider;
        return ModalProgressHUD(
            inAsyncCall: provider.isloading,
            child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: Color(0xff4889FD),
                  elevation: 0,
                  centerTitle: true,
                  //toolbarHeight: kToolbarHeight-1,
                  title: Text(
                    'Hi, ' + name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  actions: [
                    Consumer<Notification_Count_Notifier>(
                      builder: (context,provider,_){
                        notification_count_notifier=provider;
                        return ModalProgressHUD(inAsyncCall: provider.isloading, child:IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutePaths.Notification_New).then((value) {
                              setState(() {
                                getDoctor();
                              });
                            });
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Badge(
                              badgeContent: Text(provider.Notification_count,style: TextStyle(fontSize: 12,color: Colors.white),),
                              child: Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ) );
                      },
                    ),
                  ],
                ),
                backgroundColor: const Color(0xffF5F6FC),
                drawer: DrawerWidget(),
                body: OrientationBuilder(
                  builder: (context, orientation) {
                    if (orientation == Orientation.portrait) {
                      return buildBody(context);
                    } else {
                      return landscapeBuild(context);
                    }
                  },
                ),
              ),
            ));
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        buildCardContainerPortrait(context),
        buildCategoryCardPortrait(context),
      ],
    );
  }

  Widget landscapeBuild(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildCardContainer(context),
          buildCategoryCard(context),
        ],
      ),
    );
  }

  // Widget buildAppBar(context) {
  //   return
  //   //   Container(
  //   //   decoration: BoxDecoration(
  //   //     color: Theme.of(context).primaryColor,
  //   //   ),
  //   //   child: Row(
  //   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //     children: [
  //   //       // IconButton(
  //   //       //   icon: Icon(
  //   //       //     Icons.settings,
  //   //       //     color: Colors.white,
  //   //       //   ),
  //   //       //   onPressed: () {
  //   //       //     //_scaffoldKey.currentState!.openDrawer();
  //   //       //     Navigator.pushNamed(context, RoutePaths.Setting);
  //   //       //   },
  //   //       // ),
  //   //       Text(
  //   //         'Hi, '+name+ "Welcome Back",
  //   //         style: TextStyle(fontSize: 20,color: Colors.white),
  //   //       ),
  //   //       IconButton(
  //   //         onPressed: (){Navigator.pushNamed(context, RoutePaths.Notification);},
  //   //         icon: Icon(
  //   //           Icons.notifications_none,
  //   //           color: Colors.white,
  //   //         ),
  //   //       ),
  //   //     ],
  //   //   ),
  //   // );
  // }

  Widget buildCardContainer(context) {
    final postget = Provider.of<Doctor>(context);
    return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(children: [
          Align(
            alignment: Alignment.topRight,
            child: CustomPaint(
              painter: MyPainter(),
              child: Container(
                width: 40,
                height: 30,
              ),
            ),
          ),
          // Text(
          //   'Hi, '+name+ " Welcome Back",
          //   style: TextStyle(fontSize: 20),
          // ),
          //SizedBox(height: 10,),
          provider.doctorResponseClass.isEmpty
              ? Column(
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          )
              : SizedBox(
            height: 250,
            width: double.infinity,
            child:
            // Column(
            //   mainAxisAlignment:MainAxisAlignment.center,
            //   children: [
            //     FaIcon(FontAwesomeIcons.userMd,color: Colors.grey,size: 80,),
            //     SizedBox(height: 5,),
            //     Text('No Doctor Is Availabel',style: TextStyle(fontSize: 18),)
            //   ],
            // )
            CarouselSlider.builder(
              itemCount: provider.doctorResponseClass.length,
              options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  scrollDirection: Axis.horizontal,
                  autoPlay: false,
                  autoPlayAnimationDuration: Duration(seconds: 2),
                  //enlargeCenterPage: true,
                  onPageChanged: (value, _) {
                    setState(() {
                      _currentindex = value;
                      print(_currentindex);
                    });
                  }),
              itemBuilder: (context, it, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xff619AFF),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dr.' +
                                    provider.doctorResponseClass[index].name
                                        .toString() +
                                    '  ' +
                                    provider.doctorResponseClass[index].degree
                                        .toString(),
                                // 'Dr. Chinnaswami Muthuswami Venugopal Iyer M.B.B.S',

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              SizedBox(
                                width: 250,
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    provider.doctorResponseClass[index]
                                        .experience
                                        .toString() +
                                        ' YRS EXP',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  width:
                                  MediaQuery.of(context).size.width * 1,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.stethoscope,
                                              size: 15,
                                              color: Colors.white,
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: AutoSizeText(
                                            provider
                                                .doctorResponseClass[
                                            index]
                                                .specialist
                                                .toString(),
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  provider.doctorResponseClass[index].image ==
                                      null
                                      ? ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(50.0),
                                    child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Image.network(
                                        DataConstants.LIVE_BASE_URL+
                                            '/'+
                                            image,
                                        fit: BoxFit.fill,
                                        height: 60.0,
                                        width: 60.0,
                                      ),
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(50.0),
                                    child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Image.network(
                                        DataConstants.LIVE_BASE_URL +
                                            '/' +
                                            provider
                                                .doctorResponseClass[
                                            index]
                                                .image
                                                .toString(),
                                        fit: BoxFit.fill,
                                        //'https://thumbs.dreamstime.com/b/portrait-happy-arabic-doctor-male-blue-background-square-smiling-to-camera-wearing-white-uniform-posing-headshot-cheerful-233544543.jpg',
                                        height: 60.0,
                                        width: 60.0,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      height: 40,
                                      width:
                                      MediaQuery.of(context).size.width *
                                          0.42,
                                      child: InnerShadow(
                                        color: Colors.black12,
                                        offset: const Offset(0, 0),
                                        blur: 2,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Navigator.pushNamed(
                                            //     context, RoutePaths.PROFILE);
                                          },
                                          child: GestureDetector(
                                            onTap: () {
                                              // setState(() {
                                              //   String? id=postget.doctorList.data![index].id.toString();
                                              //   id=doctorid;
                                              // });
                                              print(provider
                                                  .doctorResponseClass[index]
                                                  .id
                                                  .toString());
                                              // print(postget.doctorList.data![index].id.toString());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          DrProfile(
                                                              selected: provider
                                                                  .doctorResponseClass[
                                                              index]
                                                                  .id
                                                                  .toString(),
                                                              type: provider
                                                                  .doctorResponseClass[
                                                              index]
                                                                  .type
                                                                  .toString()))).then((value) {
                                                setState(() {
                                                  getDoctor();
                                                });
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xff4889FD),
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5),
                                                  child: FittedBox(
                                                    child: Text(
                                                      'Book Appointment',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.w600,
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
                                  ),
                                  InnerShadow(
                                    color: Colors.black12,
                                    offset: const Offset(1.0, 1.0),
                                    blur: 1,
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        color: Color(0xff4889FD),
                                        borderRadius:
                                        BorderRadius.circular(50),
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
                          ),
                        ),
                      ),
                    ],
                    overflow: Overflow.visible,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: provider.doctorResponseClass.map((url) {
              int index = provider.doctorResponseClass.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentindex == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          )
          //``` Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: listPaths.map((url) {
          //     int index = listPaths.indexOf(url);
          //     return Container(
          //       width: 8.0,
          //       height: 8.0,
          //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: _currentindex == index
          //             ? Color.fromRGBO(0, 0, 0, 0.9)
          //             : Color.fromRGBO(0, 0, 0, 0.4),
          //       ),
          //     );
          //   }).toList(),
          // ),```
        ]));
  }

  Widget buildCardContainerPortrait(context) {
    final postget = Provider.of<Doctor>(context);

    return Column(children: [
      Align(
        alignment: Alignment.topRight,
        child: CustomPaint(
          painter: MyPainter(),
          child: Container(
            width: 40,
            height: 30,
          ),
        ),
      ),
      provider.doctorResponseClass.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            )
          : SizedBox(
              height: 250,
              width: double.infinity,
              child:
                  // Column(
                  //   mainAxisAlignment:MainAxisAlignment.center,
                  //   children: [
                  //     FaIcon(FontAwesomeIcons.userMd,color: Colors.grey,size: 80,),
                  //     SizedBox(height: 5,),
                  //     Text('No Doctor Is Availabel',style: TextStyle(fontSize: 18),)
                  //   ],
                  // )
                  CarouselSlider.builder(
                itemCount: provider.doctorResponseClass.length,
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    scrollDirection: Axis.horizontal,
                    autoPlay: false,
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    //enlargeCenterPage: true,
                    onPageChanged: (value, _) {
                      setState(() {
                        _currentindex = value;
                        print(_currentindex);
                      });
                    }),
                itemBuilder: (context, it, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xff619AFF),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dr.' +
                                      provider.doctorResponseClass[index].name
                                          .toString() +
                                      '  ' +
                                      provider.doctorResponseClass[index].degree
                                          .toString(),
                                  // 'Dr. Chinnaswami Muthuswami Venugopal Iyer M.B.B.S',

                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      provider.doctorResponseClass[index]
                                              .experience
                                              .toString() +
                                          ' YRS EXP',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: FaIcon(
                                            FontAwesomeIcons.stethoscope,
                                            size: 15,
                                            color: Colors.white,
                                          )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: AutoSizeText(
                                              provider
                                                      .doctorResponseClass[
                                                          index]
                                                      .specialist
                                                      .toString(),
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    provider.doctorResponseClass[index].image ==
                                            null
                                        ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: Image.network(
                                                  DataConstants.LIVE_BASE_URL+
                                                      '/'+
                                                      image,
                                                  fit: BoxFit.fill,
                                                  height: 60.0,
                                                  width: 60.0,
                                                ),
                                              ),
                                            )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Image.network(
                                                DataConstants.LIVE_BASE_URL +
                                                    '/' +
                                                    provider
                                                        .doctorResponseClass[
                                                            index]
                                                        .image
                                                        .toString(),
                                                fit: BoxFit.fill,
                                                //'https://thumbs.dreamstime.com/b/portrait-happy-arabic-doctor-male-blue-background-square-smiling-to-camera-wearing-white-uniform-posing-headshot-cheerful-233544543.jpg',
                                                height: 60.0,
                                                width: 60.0,
                                              ),
                                            ),
                                          ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        child: InnerShadow(
                                          color: Colors.black12,
                                          offset: const Offset(0, 0),
                                          blur: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigator.pushNamed(
                                              //     context, RoutePaths.PROFILE);
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                // setState(() {
                                                //   String? id=postget.doctorList.data![index].id.toString();
                                                //   id=doctorid;
                                                // });
                                                print(provider
                                                    .doctorResponseClass[index]
                                                    .id
                                                    .toString());
                                                // print(postget.doctorList.data![index].id.toString());
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            DrProfile(
                                                                selected: provider
                                                                    .doctorResponseClass[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                type: provider
                                                                    .doctorResponseClass[
                                                                        index]
                                                                    .type
                                                                    .toString()))).then((value) {
                                                                      setState(() {
                                                                        getDoctor();
                                                                      });
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff4889FD),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: FittedBox(
                                                      child: Text(
                                                        'Book Appointment',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                    ),
                                    InnerShadow(
                                      color: Colors.black12,
                                      offset: const Offset(1.0, 1.0),
                                      blur: 1,
                                      child: Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          color: Color(0xff4889FD),
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                            ),
                          ),
                        ),
                      ],
                      overflow: Overflow.visible,
                    ),
                  );
                },
              ),
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: provider.doctorResponseClass.map((url) {
          int index = provider.doctorResponseClass.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentindex == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]);
  }

  // Widget buildCard(context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
  //     child: Stack(
  //       children: [
  //         Container(
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             color: Theme.of(context).primaryColorDark,
  //             borderRadius: BorderRadius.circular(20),
  //             boxShadow: [
  //               const BoxShadow(
  //                 offset: Offset(0, 4),
  //                 blurRadius: 4,
  //                 color: Colors.black26,
  //               ),
  //             ],
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Dr. Chinnaswami Muthuswami Venugopal Iyer M.B.B.S',
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.w600,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 SizedBox(
  //
  //                   height: 10,
  //                 ),
  //                 SizedBox(
  //
  //                   width: 250,
  //                   child: Divider(
  //                     thickness: 1,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 SizedBox(
  //
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       '14 YRS EXP',
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w800,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     SizedBox(
  //
  //                       width: 10,
  //                     ),
  //                     Icon(Icons.local_hospital_outlined,size: 15,color: Colors.white,),
  //                     Text(
  //                       'Heart Surgeon',
  //                       style: TextStyle(
  //                         fontSize: 17,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //
  //                   height: 20,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     ClipRRect(
  //                       borderRadius: BorderRadius.circular(50.0),
  //                       child: Image.network(
  //                         'https://thumbs.dreamstime.com/b/portrait-happy-arabic-doctor-male-blue-background-square-smiling-to-camera-wearing-white-uniform-posing-headshot-cheerful-233544543.jpg',
  //                         height: 60.0,
  //                         width: 60.0,
  //                       ),
  //                     ),
  //                     Align(
  //                       alignment: Alignment.centerRight,
  //                       child: SizedBox(
  //
  //                         height: 40,
  //                         width: MediaQuery.of(context).size.width*0.46,
  //                         child: InnerShadow(
  //                           color:
  //                           Theme.of(context).primaryColorLight.withOpacity(0.25),
  //                           offset: const Offset(0.5, 0.5),
  //                           blur: 20,
  //                           child: GestureDetector(
  //                             onTap: () {
  //                               // Navigator.pushNamed(
  //                               //     context, RoutePaths.PROFILE);
  //                             },
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                 color: Theme.of(context).primaryColor,
  //                                 borderRadius: BorderRadius.circular(15),
  //                               ),
  //                               child: Center(
  //                                 child: Padding(
  //                                   padding:
  //                                   const EdgeInsets.symmetric(horizontal: 5),
  //                                   child: FittedBox(
  //                                     child: Text(
  //                                       'Book Appointment',
  //                                       style: TextStyle(
  //                                         fontSize: 15,
  //                                         fontWeight: FontWeight.w600,
  //                                         color: Colors.white,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     InnerShadow(
  //                       color: Theme.of(context).primaryColorLight.withOpacity(0.25),
  //                       offset: const Offset(1.0, 1.0),
  //                       blur: 10,
  //                       child: Container(
  //                         height: 55,
  //                         width: 55,
  //                         decoration: BoxDecoration(
  //                           color: Theme.of(context).primaryColor,
  //                           borderRadius: BorderRadius.circular(50),
  //                         ),
  //                         child: const Center(
  //                           child: Text(
  //                             '19',
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 30,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           bottom: -24,
  //           right: -32,
  //           child: Image.asset(
  //             'assets/images/seth_end.png',
  //           ),
  //         ),
  //         Positioned(
  //           bottom: -10,
  //           left: -31,
  //           child: RotationTransition(
  //             turns: const AlwaysStoppedAnimation(2 / 360),
  //             child: Image.asset(
  //               'assets/images/seth_top.png',
  //             ),),
  //         ),
  //       ],
  //       overflow: Overflow.visible,
  //     ),
  //   );
  // }
  Widget buildCategoryCard(context) {
    return Container(
      //height: MediaQuery.of(context).size.height*0.6,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: GridView.count(
                childAspectRatio: 4 / 3.5,
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.NoOFAppointment).then((value) {
                        getDoctor();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: Container(
                        // height: 155,
                        // width: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 4,
                              spreadRadius: 2,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              'assets/images/mainscreen/MyAppoinment.svg',
                              color: Color(0xff31B8FF),
                            ),
                            Text(
                              'My appointment',
                              style: TextStyle(color: Color(0xff31B8FF)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.FAMILYMEMEBER).then((value) {
                        setState(() {
                          getDoctor();
                        });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 5),
                      child: Container(
                        // height: 155,
                        // width: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 4,
                              spreadRadius: 2,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('assets/images/mainscreen/family.svg',
                                color: Color(0xffE8899E)),
                            Text(
                              'Family Members',
                              style: TextStyle(color: Color(0xffE8899E)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Profile())).then((value) {
                                setState(() {
                                  getDoctor();
                                });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 5),
                      child: Container(
                        // height: 155,
                        // width: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 4,
                              spreadRadius: 2,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('assets/images/profile.svg',
                                color: Color(0xffF7C480)),
                            Text(
                              'Profile',
                              style: TextStyle(color: Color(0xffFFB830)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Health_Record())).then((value) {
                                    setState(() {
                                      getDoctor();
                                    });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 5),
                      child: Container(
                        // height: 155,
                        // width: 145,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 4,
                              spreadRadius: 2,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('assets/images/mainscreen/health_record.svg',
                                color: Color(0xff1EC760)),
                            Text(
                              'Health Records',
                              style: TextStyle(color: Color(0xff1EC760)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // );
  }

  Widget buildCategoryCardPortrait(context) {
    return Expanded(
      child: Container(
        //height: MediaQuery.of(context).size.height*0.554,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Center(
                child: GridView.count(
                  childAspectRatio: 4 / 3.5,
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutePaths.NoOFAppointment).then((value) {
                              setState(() {
                                getDoctor();
                              });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        child: Container(
                          // height: 155,
                          // width: 145,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 4,
                                spreadRadius: 2,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                'assets/images/mainscreen/MyAppoinment.svg',
                                color: Color(0xff31B8FF),
                              ),
                              Text(
                                'My appointment',
                                style: TextStyle(color: Color(0xff31B8FF)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.FAMILYMEMEBER).then((value) {
                          setState(() {
                            getDoctor();
                          });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 5),
                        child: Container(
                          // height: 155,
                          // width: 145,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 4,
                                spreadRadius: 2,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset('assets/images/mainscreen/family.svg',
                                  color: Color(0xffE8899E)),
                              Text(
                                'Family Members',
                                style: TextStyle(color: Color(0xffE8899E)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Profile())).then((value) {
                                  setState(() {
                                    getDoctor();
                                  });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 5),
                        child: Container(
                          // height: 155,
                          // width: 145,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 4,
                                spreadRadius: 2,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset('assets/images/profile.svg',
                                  color: Color(0xffF7C480)),
                              Text(
                                'Profile',
                                style: TextStyle(color: Color(0xffFFB830)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Health_Record())).then((value) {
                                      setState(() {
                                        getDoctor();
                                      });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: Container(
                          // height: 155,
                          // width: 145,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 4,
                                spreadRadius: 2,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset('assets/images/mainscreen/health_record.svg',
                                  color: Color(0xff1EC760)),
                              Text(
                                'Health Records',
                                style: TextStyle(color: Color(0xff1EC760)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xff4889FD);
    path = Path();
    path.lineTo(size.width, 0);
    path.cubicTo(size.width, 0, 0, 0, 0, 0);
    path.cubicTo(size.width * 0.78, size.height * 0.05, size.width,
        size.height * 0.69, size.width, size.height);
    path.cubicTo(size.width, size.height, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, 0, size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
