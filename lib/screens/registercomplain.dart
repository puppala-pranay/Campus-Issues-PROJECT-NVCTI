import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:project_NVCTI/Functions/auth_functions.dart';

import 'package:project_NVCTI/constants/Theme.dart';
import 'package:project_NVCTI/screens/home1.dart';

//widgets
import 'package:project_NVCTI/widgets/navbar.dart';
import 'package:project_NVCTI/widgets/input.dart';

import 'package:project_NVCTI/widgets/drawer.dart';
//Function
import 'package:project_NVCTI/Functions/database.dart';

class RegisterComplain extends StatefulWidget {
  final User user;
  RegisterComplain(this.user);
  @override
  _RegisterComplainState createState() => _RegisterComplainState();
}

class _RegisterComplainState extends State<RegisterComplain> {
  String complaintTopic ;
  String complaintTitle ;
  String complaintDescription;
  bool loading = false;
  bool _isLoaderVisible = false;


  final double height = window.physicalSize.height;

  void localComplaintRegister()async{
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    dynamic list  = await DatabaseFunctions().registerComplaint(complaintTopic, complaintTitle, complaintDescription, widget.user.personalNo);
    String remark;
    if(!list[0]) {
      remark = list[1];

    }
    else remark = "Complaint Registered";
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Complaint Status'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(remark)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }, );
    setState(() {
      loading= false;
      _isLoaderVisible = context.loaderOverlay.visible;
    });

  }

  @override
  Widget build(BuildContext context) {
    const complaintTopicsArray = ["Hostel" , "Academics" , "Security" , "Administration", "Co-Curriculum" ];
    return Scaffold(
        appBar: Navbar(
          title: "Register Complaint",

        ),
        extendBodyBehindAppBar: false,
        drawer: NowDrawer("RegisterComplaint",widget.user),
        body: LoaderOverlay(
          useDefaultLoading: true,
          overlayColor: Colors.orangeAccent,
          overlayOpacity: 0.4,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/imgs/register-bg.png"),
                        fit: BoxFit.cover)),
              ),
              SafeArea(
                child: loading? Text("Loading"):
                ListView(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16.0, right: 16.0, bottom: 32),
                    child: Card(
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.78,
                            color: NowUIColors.bgColorScreen,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 24.0, bottom: 8),
                                        child: Center(
                                            child: Text("Register Complaint",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600))),
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(padding: const EdgeInsets.only(
                                            top: 8.0,
                                            left : 8.0,
                                            right : 8.0,
                                            bottom : 0,
                                          ),
                                            child : DropdownButton<String>(
                                              value: complaintTopic,
                                              isExpanded:  true,
                                              hint: Text("Topic .."),
                                              icon: const Icon(Icons.arrow_downward),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: const TextStyle(color: Colors.deepPurple),
                                              underline: Container(
                                                height: 2,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  complaintTopic = newValue;
                                                });
                                              },
                                              items: complaintTopicsArray
                                                  .map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              onChanged:(text)=>{
                                                setState((){
                                                  complaintTitle = text;
                                                })
                                              } ,

                                              placeholder: "Complaint Name",
                                              prefixIcon:
                                              Icon(Icons.school, size: 20),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                               maxLines: 8,
                                                onChanged:(text)=>{
                                                  setState((){
                                                    complaintDescription = text;
                                                  })
                                                } ,
                                                placeholder: "Complaint Description",
                                                prefixIcon:
                                                Icon(Icons.email, size: 20)),
                                          ),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:[ RaisedButton(
                                          textColor: NowUIColors.white,
                                          color: NowUIColors.primary,
                                          onPressed: () {
                                            localComplaintRegister();
                                            setState(() {
                                              loading = true;
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(32.0),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 32.0,
                                                  right: 32.0,
                                                  top: 12,
                                                  bottom: 12),
                                              child: Text("Register",
                                                  style:
                                                  TextStyle(fontSize: 14.0))),
                                        ),
                                          TextButton(
                                            onPressed: (){
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => HomeFinal(widget.user)),
                                              );
                                            },
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 32.0,
                                                    right: 32.0,
                                                    top: 12,
                                                    bottom: 12),
                                                child: Text("Back",
                                                    style:
                                                    TextStyle(fontSize: 14.0))),
                                          ),
                                        ]
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ))),
                  ),
                ]),
              )
            ],
          ),
        ));
  }
}
