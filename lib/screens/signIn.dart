import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_NVCTI/constants/Theme.dart';
import 'package:project_NVCTI/screens/home1.dart';
import 'package:project_NVCTI/screens/register.dart';
import 'package:loader_overlay/loader_overlay.dart';

//widgets
import 'package:project_NVCTI/widgets/navbar.dart';
import 'package:project_NVCTI/widgets/input.dart';

import 'package:project_NVCTI/widgets/drawer.dart';
//Function
import "package:project_NVCTI/Functions/auth_functions.dart";

class SignIn extends StatefulWidget {
  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  String personalNo;
  String password;
  User user;
  bool loading = false;
  bool _isLoaderVisible = false;


  final double height = window.physicalSize.height;

  void localSignIn()async{
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    dynamic list  = await signIn(personalNo, password);
    if(list[0]==null) {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text('SignIn Failed'),
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
    if(isAuthorised())return new HomeFinal(user);
    return Scaffold(
        appBar: Navbar(
          title: "SignIn",
          searchBar: false,
        ),
        extendBodyBehindAppBar: false,
        drawer: NowDrawer("SignIn",user),
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
                child:
                  loading?Text("Loading"):
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
                        child: SingleChildScrollView(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.50,
                            color: NowUIColors.bgColorScreen,

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),

                                child: Center(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 24.0, bottom: 8),
                                        child: Center(
                                            child: Text("Sign In",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600))),
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [

                                          (Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0,
                                                left: 8.0,
                                                right: 8.0,
                                                bottom: 8),
                                            child: Input(

                                                onChanged:(text)=>{
                                                  setState((){
                                                    personalNo = text.toString().toUpperCase();
                                                  })
                                                } ,
                                                placeholder: "Admission/Management No",
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
                                            localSignIn();
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
                                              child: Text("Sign In",
                                                  style:
                                                  TextStyle(fontSize: 14.0))),
                                        ),
                                      ),
                                      Center(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => Register()),
                                            );
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20.0,
                                                  bottom: 10),
                                              child: Text("Don't Have account? Register ...",
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
