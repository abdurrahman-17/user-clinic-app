import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/innershadow.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';

class Doctor_list extends StatelessWidget {
  const Doctor_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text('Doctor\'s List',style: TextStyle(fontSize: 25,),),
              buildlistviewDoctor(context)
          ],
        ),
      ),);
  }
  Widget buildlistviewDoctor(BuildContext context){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context,int){
      return Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              height: 200,
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://thumbs.dreamstime.com/b/portrait-happy-arabic-doctor-male-blue-background-square-smiling-to-camera-wearing-white-uniform-posing-headshot-cheerful-233544543.jpg',
                              height: 73.0,
                              width: 73.0,
                            ),
                          ),
                          Column(
                            children: [
                              const Text(
                                'Dr. Nadeem',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                width: 110,
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.SETHOSCOPE,
                                    height: 18,
                                    width: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Heart Surgeon',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InnerShadow(
                            color: Theme.of(context)
                                .primaryColorLight
                                .withOpacity(0.25),
                            offset: const Offset(1.0, 1.0),
                            blur: 10,
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Text(
                                  '19',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 45,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '14 YRS EXP.',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 40,
                              width: 220,
                              child: InnerShadow(
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(0.25),
                                offset: const Offset(0.5, 0.5),
                                blur: 20,
                                child: GestureDetector(
                                  onTap: () {
                                   /* Navigator.pushNamed(
                                        context, RoutePaths.DrPROFILE);*/
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor,
                                      borderRadius:
                                      BorderRadius.circular(15),
                                    ),
                                    child:  Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: AutoSizeText(
                                          Languages.of(context)!.bookappoinment,maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 20,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -16,
              right: -20,
              child: Image.asset(
                AppImages.SETHOSCOPEFRONT,
              ),
            ),
            Positioned(
              top: -9,
              left: -46,
              child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(-6 / 360),
                  child: Image.asset(
                    AppImages.SETHOSCOPEBACK,
                  )),
            ),
          ],
        ),
      );
    });
  }
}
