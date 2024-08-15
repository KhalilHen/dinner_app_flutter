import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 retrieveCurrentUser() async {

    final user = FirebaseAuth.instance.currentUser;

    if(user != null){
        return user;

    } else {
      print("User is not logged in");

      
    }

  return user;
}

void logOut() async{


}