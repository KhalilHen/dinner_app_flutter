import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'homepage.dart';
import 'list.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const Login());
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange.shade700,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool showPassword = false;

  Future<void> _login() async {
    if (_key.currentState!.validate()) {
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

  @override
  Widget build(BuildContext context) {
    final primaryBackgroundColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TODO Delete this before pushing
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Homepage(),
                    ),
                  );
                },
                child: Text('Shortcut to homepage'),
              ),
              Title(
                color: Colors.black,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              Form(
                key: _key,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: validateEmail,
                        decoration: const InputDecoration(
                          labelText: 'Enter email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: validatePassword,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          labelText: 'Enter password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black45,
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // For another time
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.grey.shade400),
                        padding: WidgetStateProperty.all(const EdgeInsets.all(16.0)),
                      ),
                      child: const Text(
                        'Create account',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _login,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(const Color(0xFF00FF00)),
                        padding: WidgetStateProperty.all(const EdgeInsets.all(16.0)),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

RegExp pattern = RegExp(r'^[\s\S]{8,}$'); // At least 8 characters
String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) return 'Invalid Email address';
  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) return 'Invalid password';

  RegExp pattern = RegExp(r'^[\s\S]{8,}$'); // At least 8 characters

  return null;
}