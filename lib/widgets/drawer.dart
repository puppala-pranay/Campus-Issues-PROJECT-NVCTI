import 'package:flutter/material.dart';
import 'package:project_NVCTI/Functions/auth_functions.dart';
import 'package:project_NVCTI/screens/home1.dart';
import 'package:project_NVCTI/screens/register.dart';
import 'package:project_NVCTI/screens/registercomplain.dart';
import 'package:project_NVCTI/screens/signIn.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:project_NVCTI/screens/yourcomplaints.dart";
import 'package:project_NVCTI/screens/checkcomplaints.dart';

import 'package:project_NVCTI/constants/Theme.dart';

import 'package:project_NVCTI/widgets/drawer-tile.dart';

class NowDrawer extends StatelessWidget {
  final String currentPage;
  final User user;

  NowDrawer(this.currentPage, this.user);

  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    dynamic temp, temp2;
    if (user != null && user.role == "Student") {
      temp = YourComplaints(user);
      temp2 = RegisterComplain(user);
    } else if (user != null) {
      temp = CheckComplaints(user, true);
      temp2 = CheckComplaints(user, false);
    }

    String title, title2;
    if (user != null && user.role == "Student") {
      title = "Your Complaints";
      title2 = "Register Complaints";
    } else if (user != null)  {
      title = "Check Active Complaints";
      title2 = "Check Resolved Complaints";
    }

    return Drawer(
        child: Container(
      color: NowUIColors.primary,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 5,left: 5),child: Image.asset("assets/imgs/logo1.png")),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: IconButton(
                          icon: Icon(Icons.menu,
                              color: NowUIColors.white.withOpacity(0.82),
                              size: 24.0),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 36, left: 8, right: 16),
            children: [
              DrawerTile(
                  icon: FontAwesomeIcons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeFinal(user)),
                      );
                  },
                  iconColor: NowUIColors.primary,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.login,
                  onTap: () {
                    if (currentPage != "SignIn")
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                  },
                  iconColor: NowUIColors.error,
                  title: "SignIn",
                  isSelected: currentPage == "SignIn" ? true : false),
              DrawerTile(
                  icon: Icons.app_registration,
                  onTap: () {
                    if (currentPage != "Register")
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                  },
                  iconColor: NowUIColors.primary,
                  title: "Register",
                  isSelected: currentPage == "Register" ? true : false),
              user != null
                  ? DrawerTile(
                      icon: FontAwesomeIcons.user,
                      onTap: () {
                        if (currentPage != title)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => temp),
                          );
                      },
                      iconColor: NowUIColors.warning,
                      title: title,
                      isSelected: currentPage == title ? true : false)
                  : Wrap(),
              user != null
                  ? DrawerTile(
                      icon: FontAwesomeIcons.user,
                      onTap: () {
                        if (currentPage != title2)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => temp2),
                          );
                      },
                      iconColor: NowUIColors.warning,
                      title: title2,
                      isSelected: currentPage == title2 ? true : false)
                  : Wrap(),
             user!=null ? DrawerTile(
                  icon: Icons.logout ,
                  onTap: () async{
                    if (currentPage != "SignOut")
                      await signOut();
                      Navigator.pushReplacement(
                        context,
                       MaterialPageRoute(builder: (context) => HomeFinal(null)),
                    );
                  },
                  iconColor: NowUIColors.success,
                  title: "SignOut",
                  isSelected: currentPage == "SignOut" ? true : false):Wrap(),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                      height: 4,
                      thickness: 0,
                      color: NowUIColors.white.withOpacity(0.8)),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("DOCUMENTATION",
                        style: TextStyle(
                          color: NowUIColors.white.withOpacity(0.8),
                          fontSize: 13,
                        )),
                  ),
                  DrawerTile(
                      icon: FontAwesomeIcons.satellite,
                      onTap: _launchURL,
                      iconColor: NowUIColors.muted,
                      title: "Getting Started",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
