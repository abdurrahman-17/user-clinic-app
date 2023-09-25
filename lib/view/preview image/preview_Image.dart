import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:user_clinic_token_app/core/data_constants.dart';


class PhotoViewDemo extends StatefulWidget {
  final List<String> images;

  PhotoViewDemo({Key? key,required this.images}) : super(key: key);
  @override
  _PhotoViewDemoState createState() => _PhotoViewDemoState();
}

class _PhotoViewDemoState extends State<PhotoViewDemo> {

  int _currentindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding:  EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                onPressed: () {Navigator.pop(context);},
                icon: Padding(
                  padding:  EdgeInsets.only(left: 3.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,size: 20,
                  ),
                ),
              ),
            ),
          ),
          title: Text("Prescription"),
        ),
        // add this body tag with container and photoview widget
        body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                //margin: EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                child: PhotoViewGallery.builder(
                  onPageChanged: (index){
                    setState(() {
                      _currentindex=index;
                      print(_currentindex);

                    });
                  },
                  itemCount: widget.images.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(DataConstants.LIVE_BASE_URL+'/'+
                        widget.images[index],
                      ),
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    );
                  },
                  scrollPhysics: BouncingScrollPhysics(),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  enableRotation: true,
                  // loadingBuilder: (context, event) => Center(
                  //   child: Container(
                  //     width: 30.0,
                  //     height: 30.0,
                  //     child: CircularProgressIndicator(
                  //       backgroundColor: Colors.orange,
                  //     ),
                  //   ),
                  // ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.map((url) {
                    int index = widget.images.indexOf(url);
                    print(_currentindex);
                    //print(index);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentindex == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4)
                      ),
                    );
                  }).toList(),
                ),
              ),
            ]
        )

    );
  }
}