import 'package:flutter/material.dart';
import 'package:user_clinic_token_app/core/request_response/gender&age/age&gender_Notifier.dart';
import 'package:user_clinic_token_app/view/onboard_screens/Age_Screen.dart';
import 'package:user_clinic_token_app/view/token_appointment_new/Token_Appointment_New.dart';


class GenderScreen extends StatefulWidget {
  final email;
  const GenderScreen({Key? key,required this.email}) : super(key: key);

  @override
  _GenderScreenState createState() => _GenderScreenState();
}
class Tech {
  String label;

  //Color color;
  Tech(
      this.label,
      );
}

class _GenderScreenState extends State<GenderScreen> {
  int selectedIndex = 0;
  int? gender;
  List<String> _chipsList = ['M','F'];

@override
  void initState() {
  print(widget.email);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image(image: AssetImage('assets/images/ageshape.png'),
                fit: BoxFit.fill,width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.3,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 300.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Wrap(
                        spacing: 50,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.horizontal,
                        children: techChips(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: ElevatedButton(onPressed: (){
                      print(_chipsList[selectedIndex]);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AgeScreen(selectedValue: _chipsList[selectedIndex],email:widget.email)));
                    }, child:
                        Text('Next',style: TextStyle(
                          fontSize: 20,
                        ),
                        ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side:BorderSide(color: Colors.blue),
                          ),
                        ),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = FilterChip(
        label: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(50),
          //   border: Border.all(
          //     color: Colors.blue,width: 2,
          //   )
          // ),
          height: 90,
          width: 75,
          child: Center(
            child: Text(
              _chipsList[i],
              style: TextStyle(
                fontSize: 30,
                color: selectedIndex == i
                    ? Colors.white
                    : Colors.blue,
              ),
            ),
          ),
        ),
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.blueAccent,width: 2)
         ),

        backgroundColor: Colors.transparent,
        selectedColor: Theme.of(context).primaryColor,
        showCheckmark: false,
        selected: selectedIndex == i,
        onSelected: (bool value) {
          setState(() {
            selectedIndex = i;
          }
          );
        },
      );
      chips.add(item);
    }
    return chips;
  }
}
