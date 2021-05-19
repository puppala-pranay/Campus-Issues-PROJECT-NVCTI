import 'package:flutter/material.dart';
import 'package:project_NVCTI/Functions/auth_functions.dart';
import 'package:project_NVCTI/screens/home1.dart';
import 'package:project_NVCTI/constants/Theme.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool reverseTextcolor;
  final bool rightOptions;
  final List<String> tags;


  final bool noShadow;
  final Color bgColor;

  Navbar(
      {this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.tags,
      this.transparent = false,
      this.rightOptions = true,
      this.reverseTextcolor = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = NowUIColors.white,
      this.searchBar = false});

  final double _prefferedHeight = 180.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        height: 80,
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? NowUIColors.muted
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: Offset(0, 5))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                                !widget.backButton
                                    ? Icons.menu
                                    : Icons.arrow_back_ios,
                                color: !widget.transparent
                                    ? (widget.bgColor == NowUIColors.white
                                        ? NowUIColors.text
                                        : NowUIColors.white)
                                    : (widget.reverseTextcolor
                                        ? NowUIColors.text
                                        : NowUIColors.white),
                                size: 24.0),
                            onPressed: () {
                              if (!widget.backButton)
                                Scaffold.of(context).openDrawer();
                              else
                                Navigator.pop(context);
                            }),
                        Text(widget.title,
                            style: TextStyle(
                                color: !widget.transparent
                                    ? (widget.bgColor == NowUIColors.white
                                        ? NowUIColors.text
                                        : NowUIColors.white)
                                    : (widget.reverseTextcolor
                                        ? NowUIColors.text
                                        : NowUIColors.white),
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0)),
                      ],
                    ),
                    if (widget.rightOptions)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async{
                              await signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeFinal(null)),
                              );
                            },
                            child: TextButton(
                              onPressed: null,
                              child: Row(children: <Widget>[
                                Text("SignOut",
                                    style: TextStyle(
                                        color: !widget.transparent
                                            ? (widget.bgColor ==
                                                    NowUIColors.white
                                                ? NowUIColors.text
                                                : NowUIColors.white)
                                            : (widget.reverseTextcolor
                                                ? NowUIColors.text
                                                : NowUIColors.white),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0)),
                                Icon(Icons.logout),
                              ]),
                            ),
                          ),
                        ],
                      )
                  ],
                ),

              ],
            ),
          ),
        ));
  }
}
