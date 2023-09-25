import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';
import 'package:user_clinic_token_app/core/request_response/Get_report_By_Id/Get_Report_Byid_Notifier.dart';
import 'package:user_clinic_token_app/utils/common/app_text_style.dart';

class Prescription extends StatefulWidget {
  final appointment_id;
  Prescription({
    Key? key,
    required this.appointment_id,
  }) : super(key: key);

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  Get_Report_Id_Notifier provider = Get_Report_Id_Notifier();

  String drname = '';
  String Specialist = '';
  String Time = '';
  String image = '';
  DateTime? Dates;
  String? formatted;
  String? outputDate;
  String file = '';
  String? savePath;
  //String fileurl="https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg";
  bool imageblur = false;

  // final DateTime now = DateTime(Dates);
  // final DateFormat formats=DateFormat('yyy-MM-dd');
  // final String formatted=formats.format(Dates!);
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      provider.Get_Report_Byid_data(30.toString()).then((value) {
        provider.notifyListeners();
        for (int i = 0;
            i < provider.get_report_byid_ResponseClass.length;
            i++) {
          drname =
              provider.get_report_byid_ResponseClass[i].doctorName.toString();
          image =
              provider.get_report_byid_ResponseClass[i].prescription.toString();
          Dates = provider.get_report_byid_ResponseClass[i].date!;
          Time = provider.get_report_byid_ResponseClass[i].yourAppointmentOn
              .toString();
        }
        print(Dates);
        print(widget.appointment_id.toString());
        date();
        //permission();
        filename();
        // TODO: implement initState
        super.initState();
      });
    });
  }

  void filename() {
    setState(() {
      file = image.split('/').last;
      print(file);
    });
  }

  // Future<void> permission() async {
  //   var dir = await DownloadsPathProvider.downloadsDirectory;
  //   if(dir != null){
  //     String downloadfolder = dir.path;
  //     print(downloadfolder); //output: /storage/emulated/0/Download
  //   }else{
  //     print("No download folder found.");
  //   }
  // }
  void date() {
    final DateFormat formatter = DateFormat("dd-MMMM-yyy");
    formatted = formatter.format(Dates!);
    print(formatted);

    var inputFormat = DateFormat('HH:mm');
    var inputDate = inputFormat.parse(Time); // <-- dd/MM 24H format

    var outputFormat = DateFormat('hh:mm a');
    outputDate = outputFormat.format(inputDate);
    print(outputDate); // 12/31/2000 11:59 PM <-- MM/dd 12H format
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Get_Report_Id_Notifier>(
      builder: (context, provider, _) {
        this.provider = provider;
        return ModalProgressHUD(
            inAsyncCall: provider.isloading,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xffF7F9FC),
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
          buildBackgroundImage(context),
          Column(
            children: [
              buildColumn(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBackgroundImage(BuildContext context) {
    return ClipPath(
      clipper: CurveImage(),
      child: Container(
        color: Color(0xff4889FD),
        width: MediaQuery.of(context).size.width,
        height: 200,
      ),
    );
    // SvgPicture.asset('assets/images/BGn.svg',width: MediaQuery.of(context).size.width,);
  }

  Widget buildColumn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          backButton(context),
          //buildTitle(context),
          buildPrescriptionContainer(context),
          //buildButton(context),
        ],
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 0),
      child: Text(
        'Prescription',
        style: ProfileStyle(context),
      ),
    );
  }

  Widget buildPrescriptionContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              buildimage(context),
              //buildDownloadImage(context),
              buildPrescriptionBy(context),
              buildDateandTime(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildDownloadImage(BuildContext context){
  //   return GestureDetector(
  //     onTap: (){
  //       _requestDownload();
  //       DataConstants.LIVE_BASE_URL+'/'+image;
  //       print( DataConstants.LIVE_BASE_URL+'/'+image);
  //     },
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         SizedBox(height: 40,),
  //         Text('Download',style: GoogleFonts.roboto(fontWeight: FontWeight.w300,fontSize: 20,color: Color(0xffA6A6A6)),),
  //         Icon(Icons.download_outlined,color: Color(0xffA6A6A6),)
  //       ],
  //     ),
  //   );
  // }
  Widget buildPrescriptionBy(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
        ),
        Text(
          'Prescription',
          style: PrescriptionStyle(context),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'By ' + drname,
          style: DoctorByName(context),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Heart surgen',
          style: PrescriptionSpecialist(context),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }

  Widget buildimage(BuildContext context) {
    Directory? directory;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => RouteTwo(
                          image: DataConstants.LIVE_BASE_URL + '/' + image)));
            },
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/giphy.gif',
                  image: DataConstants.LIVE_BASE_URL + '/' + image,
                  //'https://www.researchgate.net/profile/Sandra-Benavides/publication/228331607/figure/fig4/AS:667613038387209@1536182760366/Indicate-why-the-prescription-is-not-appropriate-as-written.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
              child: imageblur == false
                  ? Container(
                      height: 200,
                      color: Colors.white70,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: IconButton(
                              onPressed: () async {
                                Map<Permission, PermissionStatus> statuses =
                                    await [
                                  Permission.manageExternalStorage,
                                  Permission.storage,
                                  Permission.accessMediaLocation,

                                  //add more permission to request here.
                                ].request();

                                if (statuses[Permission.storage]!.isGranted &&
                                    statuses[Permission.accessMediaLocation]!
                                        .isGranted &&
                                    statuses[Permission.manageExternalStorage]!
                                        .isGranted) {
                                  if (await statuses[Permission.storage]!
                                      .isGranted) {
                                    directory =
                                        await getExternalStorageDirectory();
                                    String newPath = "";
                                    print(directory);
                                    List<String> paths =
                                        directory!.path.split("/");
                                    for (int x = 1; x < paths.length; x++) {
                                      String folder = paths[x];
                                      if (folder != "Android") {
                                        newPath += "/" + folder;
                                      } else {
                                        break;
                                      }
                                    }
                                    newPath = newPath + "/UserClinicAPP";
                                    directory = Directory(newPath);
                                    print('irfan');
                                    print(directory);
                                  } else {
                                    return null;
                                  }

                                  //var dir = await DownloadsPathProvider.downloadsDirectory;
                                  if (directory != null) {
                                    String savename = file;
                                    savePath = directory!.path + "/$savename";
                                    print(savePath);
                                    //output:  /storage/emulated/0/Download/banner.png

                                    try {
                                      await Dio().download(
                                          DataConstants.LIVE_BASE_URL +
                                              '/' +
                                              image,
                                          savePath,
                                          onReceiveProgress: (received, total) {
                                        if (total != -1) {
                                          print((received / total * 100)
                                                  .toStringAsFixed(0) +
                                              "%");
                                          //you can build progressbar feature too
                                        }
                                      });
                                      print(
                                          "File is saved to download folder.");
                                    } on DioError catch (e) {
                                      print(e.message);
                                    }
                                  }
                                } else {
                                  print("No permission to read and write.");
                                }
                                setState(() {
                                  imageblur = true;
                                });
                              },
                              icon: Icon(
                                Icons.download,
                                color: Colors.black,
                                size: 50,
                              ),
                            )),
                      ),
                    )
                  : null),
        ],
      ),
    );
  }

  Widget buildDateandTime(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              offset: Offset(0, 2),
              blurRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Date and Time',
                      style: DateContainerStyle(context),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Text(
                  formatted.toString(),
                  style: DateContainer1Style(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Your Appointment on ' + outputDate.toString(),
                  style: DateContainer1Style(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, bottom: 10, left: 25, top: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              // final DateTime Hi=DateTime.now();
              //  print(Hi);
              Navigator.pop(context);
            },
            child: Text(
              'Back',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color(0xff4889FD),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
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
                top: MediaQuery.of(context).size.height * 0.03, left: 0),
            child: Align(
              alignment: Alignment.topLeft,
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
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03, left: 10),
          child: Text(
            'Prescription',
            style: ProfileStyle(context),
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}

class CurveImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 30);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

void _requestDownload() async {
  final _download = await getDownloadsDirectory();
  print(_download);
  await FlutterDownloader.enqueue(
      url: 'http://barbra-coco.dyndns.org/student/learning_android_studio.pdf',
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: _download.toString(),
      showNotification: true,
      openFileFromNotification: true);
}

class Photoitem {
  final String image;
  Photoitem(this.image);
}

class RouteTwo extends StatelessWidget {
  final String image;

  const RouteTwo({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.contain)),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close))
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Container(),
      ),
    );
  }
}
