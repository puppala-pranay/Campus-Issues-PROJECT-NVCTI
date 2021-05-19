

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:project_NVCTI/Functions/auth_functions.dart';
import 'package:project_NVCTI/Functions/database.dart';
import 'package:project_NVCTI/constants/Theme.dart';
import 'package:project_NVCTI/screens/home1.dart';
import 'package:project_NVCTI/widgets/navbar.dart';
import 'package:project_NVCTI/widgets/drawer.dart';

class CheckComplaints extends StatefulWidget {
  final User user;
  final bool active;
  CheckComplaints(this.user, this.active);

  @override
  _CheckComplaints createState() => _CheckComplaints();
}

class _CheckComplaints extends State<CheckComplaints> {
  String topic;
  bool gotData = false;
  bool _isLoaderVisible= false;
  dynamic listItems ;


  Future getListItems()async{
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    listItems = await DatabaseFunctions().getComplaints(topic, null,widget.active);
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
      gotData = true;
    });
  }

  Widget getListView() {
    if(listItems.length==0)return Text("No Complaints found !");
    Widget listview = ListView.builder(
      shrinkWrap: true,
        itemCount: listItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listItems[index].get("title")),
            trailing: Text("Status : ${listItems[index].get("status")}"),
            onTap: (){
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Details'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(2),child: Column(children: [Text("Title : ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orangeAccent),), Text("${listItems[index].get("title")}") ])),
                        Padding(padding: EdgeInsets.all(2),child: Column(children: [Text("Description : ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orangeAccent),), Text("${listItems[index].get("description")}") ])),
                        Padding(padding: EdgeInsets.all(2),child: Column(children: [Text("Status : ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orangeAccent),), Text("${listItems[index].get("status")}") ])),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Back'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                (listItems[index].get('status') == "Active") ? (TextButton(onPressed: ()async{
                      await DatabaseFunctions().updateStatus(topic,listItems[index].id);

                      setState(() {
                        gotData = false;
                      });
                      getListItems();
                      Navigator.of(context).pop();

                    },
                        child: Text("Resolved")) ) : null,
                  ],
                );
              }, );
            },
          );
        });
    return listview;
  }

  @override
  Widget build(BuildContext context) {
    const complaintTopicsArray = ["Hostel" , "Academics" , "Security" , "Administration", "Co-Curriculum" ];
    // TODO: implement build
    return Scaffold(
        appBar: Navbar(
          title: "Complaints",
          reverseTextcolor: true,
        ),
        extendBodyBehindAppBar: false,
        drawer: NowDrawer( !widget.active ? "Check Resolved Complaints" : "Check Active Complaints" , widget.user),
        body: LoaderOverlay(
          useDefaultLoading: true,
          overlayColor: Colors.orangeAccent,
          overlayOpacity: 0.4,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return
                Padding(
                  padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
                  child: Container(
                    color: NowUIColors.bgColorScreen,
                    height: constraints.maxHeight * (0.75),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 20),
                          child: Card(
                            child: Text(widget.user.personalNo,
                                style:
                                TextStyle(color: Colors.orangeAccent, fontSize: 25)),
                          ),
                        ),
                        DropdownButton<String>(
                          value: topic,
                          isExpanded: true,
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
                              gotData = false;
                              topic = newValue;
                              getListItems();
                            });

                          },
                          items: complaintTopicsArray.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Back",
                                      style:
                                      TextStyle(color: Colors.orangeAccent , fontSize: 20.0)),
                                  Icon(Icons.arrow_back , color: Colors.orangeAccent,),
                                ],
                              )),
                        ),
                        topic!=null ? (gotData? getListView(): Text("LOADING...") ): Text("Please select domain", style: TextStyle(color: Colors.blue, fontSize: 20),),

                      ],
                    ),
                  ),
                );
            },
          ),
        ));
  }
}
