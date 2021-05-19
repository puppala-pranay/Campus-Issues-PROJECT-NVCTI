import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:project_NVCTI/constants/Theme.dart';
import 'package:project_NVCTI/screens/home1.dart';

//widgets
import 'package:project_NVCTI/widgets/navbar.dart';
import 'package:project_NVCTI/widgets/input.dart';
import 'package:project_NVCTI/widgets/drawer.dart';

//auth_function
import 'package:project_NVCTI/Functions/auth_functions.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String role ;
  String name;
  String email;
  String personalNo;
  String password;
  User user;
  bool loading = false;
  bool _isLoaderVisible = false;


  final double height = window.physicalSize.height;

  void localSignUp()async{
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    dynamic list  = await signUP(email, password, name, role, personalNo);
    if(list[0]==null) {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(list[1])
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
      if (_isLoaderVisible) {
        context.loaderOverlay.hide();
      }

      setState(() {
        loading= false;
        _isLoaderVisible = context.loaderOverlay.visible;
      });
    }
    else {
      if (_isLoaderVisible) {
        context.loaderOverlay.hide();
      }
      setState(() {
        user = list[0];
        loading = false;
        _isLoaderVisible = context.loaderOverlay.visible;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    if(isAuthorised()) return new HomeFinal(user);
    return Scaffold(
        appBar: Navbar(
          title: "Register",
          searchBar: false,
        ),
        extendBodyBehindAppBar: false,
        drawer: NowDrawer("Register",null),
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
                child: loading?Text("Loading"):
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
                                            child: Text("Register",
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
                                              value: role,
                                              isExpanded:  true,
                                              hint: Text("Register as .."),
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
                                                  role = newValue;
                                                });
                                              },
                                              items: <String>["Student" , "Management"]
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
                                                  name = text;
                                                })
                                              } ,

                                              placeholder: "Full Name",
                                              prefixIcon:
                                                  Icon(Icons.person, size: 20),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                                onChanged:(text)=>{
                                                  setState((){
                                                    email = text;
                                                  })
                                                } ,
                                                placeholder: "email...",
                                                prefixIcon:
                                                    Icon(Icons.email, size: 20)),
                                          ),
                                          (Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                                right: 8.0,
                                                bottom: 0),
                                            child: Input(

                                                onChanged:(text)=>{
                                                  setState((){
                                                    personalNo = text.toString().toUpperCase();
                                                  })
                                                } ,
                                                placeholder: role!="Management" ? "Admission No ... ": "Management No ...",
                                                prefixIcon:
                                                    Icon(Icons.perm_identity, size: 20)),
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              maxLines: 1,
                                                obscureText: true,
                                                onChanged:(text)=>{
                                                  setState((){
                                                    password = text;
                                                  })
                                                } ,
                                                placeholder: "Password ...",
                                                prefixIcon:
                                                Icon(Icons.lock, size: 20)),
                                          ),

                                        ],
                                      ),
                                      Center(
                                        child: RaisedButton(
                                          textColor: NowUIColors.white,
                                          color: NowUIColors.primary,
                                          onPressed: () {
                                            localSignUp();
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
                                      ),
                                      Center(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => HomeFinal(user)),
                                            );
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30.0,
                                                  right: 30.0,
                                                  bottom: 12,
                                                  top: 5,
                                              ),
                                              child: Text("Back..",
                                                  style:
                                                  TextStyle(fontSize: 14.0 , color: NowUIColors.primary,))),
                                        ),
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
