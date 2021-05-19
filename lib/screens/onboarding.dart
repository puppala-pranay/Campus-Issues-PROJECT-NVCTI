import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:project_NVCTI/constants/Theme.dart';
import 'package:project_NVCTI/screens/home1.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/imgs/onboarding-free.png"),
                    fit: BoxFit.cover))),
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: MediaQuery.of(context).size.height * 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [

                    Image.asset("assets/imgs/logo1.png", scale: 1),
                    SizedBox(height: 20),
                    /*Container(
                        child: Center(
                            child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text("Campus Issues",
                                    style: TextStyle(
                                        color: NowUIColors.white,
                                        fontWeight: FontWeight.w600)))),
                        Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text("Raise your issues in seconds",
                                  style: TextStyle(
                                      color: NowUIColors.white,
                                      fontWeight: FontWeight.w300)),
                            ))
                      ],
                    ))),*/
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Designed and Coded By",
                            style: TextStyle(
                                color: NowUIColors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3)),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Puppala Pranay",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.3)),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      textColor: NowUIColors.white,
                      color: NowUIColors.info,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeFinal(null)),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 16, bottom: 16),
                          child: Text("GET STARTED",
                              style: TextStyle(fontSize: 18.0))),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
