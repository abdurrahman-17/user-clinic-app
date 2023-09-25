import 'package:flutter/material.dart';
import 'package:user_clinic_token_app/utils/common/app_images.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:user_clinic_token_app/utils/common/innershadow.dart';
import 'package:user_clinic_token_app/utils/localization/language/languages.dart';
import 'package:user_clinic_token_app/view/drawer/drawer.dart';

class FamilyMember extends StatelessWidget {
  const FamilyMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //drawer: DrawerScreen(),
        appBar: AppBar(
          actions: [
            IconButton(onPressed: null, icon: Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50))
                ),
                child: Column(
                  children: [
                    buildTextMember(context),
                    buildImageRow(context),
                    buildListContainer(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration:  BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [

        ],
      ),
    );
  }

  Widget buildTextMember(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        Languages.of(context)!.familymember,
        style: TextStyle(
          color: Color(0xff4889fd),
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget buildImageRow(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Stack(
              children: [
                Container(
                  height: 120,
                  width: 105,
                  decoration: BoxDecoration(
                    color: const Color(0xff4889fd),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(4, 4),
                        blurRadius: 4,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 117,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).textSelectionColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      fit: BoxFit.fill,
                      height: 114,
                      width: 95,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Trafalgar D. Water Law'),
              const Text('24'),
              Row(
                children: const [
                  Icon(
                    Icons.male_outlined,
                    color: Color(0xff4889FD),
                  ),
                  Icon(
                    Icons.female_outlined,
                    color: Color(0xffFEA2C2),
                  ),
                ],
              ),
              const Text('Total appointments : 5'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildListContainer(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top:20,right: 12.0),
        child: InnerShadow(
          color: Theme.of(context).shadowColor,
          offset: const Offset(0.5, 0.5),
          blur: 3,
          child: Container(
            width: double.infinity,
            decoration:  BoxDecoration(
              color:Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 50.0, right: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYSe8PeHEIJGERK3kEK9bzgSq-nXsf8sP4-Q&usqp=CAU',
                            fit: BoxFit.fill,
                            height: 65,
                            width: 65,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Roronoa Zoro'),
                          const Text('23'),
                          Row(
                            children: const [
                              Icon(
                                Icons.male_outlined,
                                color: Color(0xff4889FD),
                              ),
                              Icon(
                                Icons.female_outlined,
                                color: Color(0xffFEA2C2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 320,
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 25),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYSe8PeHEIJGERK3kEK9bzgSq-nXsf8sP4-Q&usqp=CAU',
                              fit: BoxFit.fill,
                              height: 65,
                              width: 65,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Roronoa Zoro'),
                            const Text('23'),
                            Row(
                              children: const [
                                Icon(
                                  Icons.male_outlined,
                                  color: Color(0xff4889FD),
                                ),
                                Icon(
                                  Icons.female_outlined,
                                  color: Color(0xffFEA2C2),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 320,
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RoutePaths.BOTTOMNAVIGATION);
                        },
                        child: Image.asset(AppImages.ADDCIRCLE)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
