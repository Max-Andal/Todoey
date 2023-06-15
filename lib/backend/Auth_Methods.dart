import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future <String> SignupUser ({required String email, required String password, required String username}) async{
    String result = 'Some Error Occurred';
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty){
        //register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        // add user to database

        await _firestore.collection('users').doc(credential.user!.uid).set({
          'email': email,
          'username': username,
        });
        result = 'success';
      }
    } catch(e){
      result = e.toString();
    }
    return result;
  }

  Future<String> LoginUser ({required String email, required String password}) async {
   String result ='Some Error Occurred';
   try {
     if(email.isNotEmpty || password.isNotEmpty){
       await _auth.signInWithEmailAndPassword(email: email, password: password);
       result = 'success';
     }else{
       result = 'please enter all the fields';
     }
   } catch (e){
     result = e.toString();
   }
   return result;
  }

  

}