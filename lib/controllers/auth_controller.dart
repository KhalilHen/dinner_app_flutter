import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; 
import '../homepage.dart';
import '../main.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthController {
 final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  //For now not used
  User? getCurrentUser() {

    return   FirebaseAuth.instance.currentUser;
  }

  Future<void> login(BuildContext context) async {
    if (key.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        if (userCredential.user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Homepage(),
            ),
          );
        } else {
          print('Oops there went something wrong');
        }
      } catch (e) {
        print('Login failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    }
  }




  

//Logout 
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

      Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );


      Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );

  }




}