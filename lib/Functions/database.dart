
import 'package:cloud_firestore/cloud_firestore.dart';


FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = firestore.collection('users');
CollectionReference complaints = firestore.collection('Complaints');

class Complaint {
  String topic;
  String title;
  String description;
  String status;
  Complaint(this.topic,this.title,this.description,this.status);

}

class DatabaseFunctions{

  Future<List> checkIfRegistered(personalNo)async{
    DocumentSnapshot snap = await users.doc(personalNo).get();
    if(snap.exists)return [true,"User already present"];
    else return[false];
  }

  Future<List> registerUser(personalNo ,name,email,role)async{
    DocumentSnapshot snap = await users.doc(personalNo).get();
    if(snap.exists)return [false,"User already present"];
    try {
      await users.doc(personalNo).set({
        'name': name,
        'email': email,
        'role': role
      });
    }
    catch(e){
      return [false,e.code];
    }
    return [true];
  }

  Future<List> getEmail(personalNo)async{
    DocumentSnapshot snap = await users.doc(personalNo).get();
    if(!snap.exists)return [false,"User not present ,register first"];
    else {
       dynamic data  = snap.data();
       return [true, data["email"] , data["role"],data['name']];
    }
  }

  Future<List>  registerComplaint(topic,title,description,personalNo) async{
    CollectionReference ref = complaints.doc(topic).collection("complaints");
    try{
      await ref.add({
        "by" : personalNo,
        "title" : title,
        "description" : description,
        "status" : "Active",
        "timestamp": DateTime.now(),
      });
      return[true];
    }
    catch(e){
      print(e.code);
      return [false,e.code];
    }
   }

   Future<List> getComplaints(topic,personalNo,active) async{
     CollectionReference ref = complaints.doc(topic).collection("complaints");
     QuerySnapshot ref1;
     if(personalNo!=null){
       ref1 =  await ref.where("by" , isEqualTo: personalNo).orderBy("timestamp",descending: true).limit(30).get();
      }
     else {
       if(active)
        ref1 = await ref.where("status" , isEqualTo: "Active").orderBy("timestamp",descending: true).limit(30).get();
       else
         ref1 = await ref.where("status" , isEqualTo: "Resolved").orderBy("timestamp",descending: true).limit(30).get();
     }
     return ref1.docs;

  }

  Future<void> updateStatus(String topic, id) {
    return complaints
        .doc(topic)
        .collection("complaints")
        .doc(id)
        .update({'status': 'Resolved'})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<List> getUser(String email)async{
    QuerySnapshot snap = await users.where('email' , isEqualTo: email).limit(1).get();
    dynamic doc = snap.docs[0];
    return [doc.id,doc.get('name'),doc.get('role')];
  }



}
