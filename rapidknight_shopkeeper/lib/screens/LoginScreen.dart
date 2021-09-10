import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rapidknight_shopkeeper/widgets/ProgressDialog.dart';

import '../globalVariable.dart';
import 'HomeScreen.dart';
import 'RegisterScreen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              status: 'Logging you in... ',
            ));
    try {
      final user = (await _auth
              .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
              .catchError((ex) {
        Navigator.pop(context);
        FirebaseAuthException thisex = ex;
        showSnackbar(thisex.message!);
      }))
          .user;

      if (user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.reference().child('stores/${user.uid}');
        currentFirebaseUser = user;

        userRef.once().then((DataSnapshot snapshot) => {
              if (snapshot.value != null)
                {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.id, (route) => false)
                }
              else
                {showSnackbar('snapshot value is null')}
            });
      }
      showSnackbar('${user!.email} signed in');
    } catch (e) {
      showSnackbar(e.toString());
      print(e.toString());
    }
  }

  void showSnackbar(String title) {
    final snackBar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('assets/images/login_img.png'),
                alignment: Alignment.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ], color: Color(0xFF7607BD)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sign In to your Account',
                          style: TextStyle(color: Colors.white, fontSize: 21),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Text('Email',style: TextStyle(color: Colors.white,fontSize: 16),),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email address',
                                labelStyle: TextStyle(fontSize: 14),
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(fontSize: 14),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 10.0),
                              ),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!emailController.text.contains('@')) {
                                  showSnackbar('Please enter a valid email');
                                  return;
                                }
                                if (passwordController.text.length < 6) {
                                  showSnackbar('Please enter a valid password');
                                  return;
                                }
                                login();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                              ),
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RegisterScreen.id);
                                },
                                child: Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
