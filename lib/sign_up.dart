import 'package:dinnerapp/homepage.dart';
import 'package:flutter/material.dart ';
import 'package:firebase_auth/firebase_auth.dart';
import 'dialogs/sign_up_dialog.dart';



class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool showPassword = false;

  Future<void> _signUp() async {
    if (_key.currentState!.validate()) {
      try {
    
    


      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          
          email: emailController.text,
          password: passwordController.text,

        );
        if (userCredential.user != null) {
     showDialog(
  context: context,
  builder: (context) {
    return SignUpDialog(email: emailController.text, password: passwordController.text);
  },
);
        }

        
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
            primaryColor: Color(0xFFE0CDB4);

    return Scaffold(
   backgroundColor: Color(0xFFE0CDB4),

      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Container(
            child: Column(
              
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
            
                    _signUp();
             showDialog(
              context: context,
              builder: (context) {
                return SignUpDialog(email: emailController.text, password: passwordController.text);
            
              },
            );
                  },
                
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
