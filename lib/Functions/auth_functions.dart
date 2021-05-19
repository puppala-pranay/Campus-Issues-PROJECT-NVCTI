import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_NVCTI/Functions/database.dart';

FirebaseAuth auth = FirebaseAuth.instance;


class User{
  String name;
  String role;
  String personalNo;

  User(this.name,this.personalNo,this.role);
}

bool isAuthorised(){
  if(auth.currentUser!=null)return true;
  else return false;
}

Future<User> getUser()async{
  if(auth.currentUser==null)return null;
  dynamic list = await DatabaseFunctions().getUser(auth.currentUser.email);
  return User(list[1],list[0],list[2]);
}

Future<List> signUP (email,password , name , role , personalNo )async{
  dynamic list = await DatabaseFunctions().checkIfRegistered(personalNo);
  //dynamic list = await DatabaseFunctions().registerUser(personalNo, name, email, role);
  if(list[0])return [null,list[1]];
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );
    list = await DatabaseFunctions().registerUser(personalNo, name, email, role);
    if(!list[0])return [null,list[1]];
    return  [User(name,personalNo,role)];

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return [null,e.code];
  } catch (e) {
    print(e);
    return [null,e.code];
  }


}

Future<List>signOut()async{
  try {
    await auth.signOut();
    return [true];
  }
  catch (e){
    return [false];
  }
}

Future<List> signIn(personalNo , password)async{
  dynamic list  = await DatabaseFunctions().getEmail(personalNo);
  if(!list[0])return [null,list[1]];
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: list[1],
        password: password,
    );
    return [new User(list[3],personalNo,list[2])];
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
    return [null,e.code];
  }

}

