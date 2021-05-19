import "package:flutter/material.dart";
import 'package:project_NVCTI/Functions/auth_functions.dart';
import 'package:project_NVCTI/constants/Theme.dart';
import 'package:project_NVCTI/screens/checkcomplaints.dart';
import 'package:project_NVCTI/screens/registercomplain.dart';
import 'package:project_NVCTI/screens/signIn.dart';
import 'package:project_NVCTI/screens/yourcomplaints.dart';
import 'package:project_NVCTI/widgets/card-horizontal.dart';
import 'package:project_NVCTI/widgets/drawer.dart';
import 'package:project_NVCTI/widgets/navbar.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomeFinal extends StatefulWidget{
  final User user;
  HomeFinal(this.user);
  @override
  _HomeFinal createState() => _HomeFinal();
}

class _HomeFinal extends State<HomeFinal>{
  bool checkedSignedIn = false;
  User user1;
  bool _isLoaderVisible = false;

  Future<void> setUser()async{
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    User temp = await getUser();
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      user1 = temp;
      checkedSignedIn= true;
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }


  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){

      // Add Your Code here.
      if(widget.user!=null){
        setState(() {
          user1 = widget.user;
          checkedSignedIn = true;
        });
      }
      else {
        setUser();
      }

    });


  }




  @override
  Widget build(BuildContext context) {
    //if(!checkedSignedIn)return Text("Loading");
    if(checkedSignedIn && user1==null)
      return new SignIn();
    else return Scaffold(
        appBar: Navbar(
          title: "Home",
          searchBar: false,
        ),
        backgroundColor: NowUIColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: NowDrawer("Home",user1),
        body: LoaderOverlay(
          useDefaultLoading: true,
          overlayColor: Colors.orangeAccent,
          overlayOpacity: 0.4,
          child: !checkedSignedIn ? Text("Loading") :Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: user1.role == "Student" ? ([
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CardHorizontal(
                        cta: "Click Here",
                        title: "Register a Complaint",
                        img: "assets/imgs/Register-complaint.png",
                        tap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterComplain(user1)),
                          );
                        }),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CardHorizontal(
                        cta: "Click Here",
                        title: "Check previous complaints",
                        img: "assets/imgs/PreviousComplaints.png",
                        tap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => YourComplaints(user1)),
                          );
                        }),
                  ),
                ]) : [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CardHorizontal(
                        cta: "Click Here",
                        title: "Check active complaints",
                        img: "assets/imgs/ActiveComplaints.png",
                        tap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => CheckComplaints(user1,true)),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CardHorizontal(
                        cta: "Click Here",
                        title: "Check resolved complaints",
                        img: "assets/imgs/ResolvedComplaints.png",
                        tap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => CheckComplaints(user1,false)),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}