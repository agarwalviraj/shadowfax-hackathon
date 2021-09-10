import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rapidknight_shopkeeper/Helpers/HelperMethods.dart';
import 'package:rapidknight_shopkeeper/widgets/ProgressDialog.dart';

import '../globalVariable.dart';
import 'CreateStoreScreen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class RegisterScreen extends StatefulWidget {
  static String id = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> getLocation() async {
    Position position = await HelperMethods.getCurrentLocation();

    myCurrentposition = position;
    print(myCurrentposition);
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

  registerStore() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              status: 'Registering you... ',
            ));
    final User? user = (await _auth
            .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
            .catchError((ex) {
      Navigator.pop(context);
      PlatformException thisex = ex;
      showSnackbar(thisex.message!);
    }))
        .user;

    print(user);
    if (user != null) {
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.reference().child('stores/${user.uid}');
      Map userMap = {
        'fullName': fullNameController.text,
        'type': 'shopkeeper',
        'email': emailController.text,
        'phone': phoneController.text,
      };

      newUserRef.set(userMap);

      DatabaseReference allUserref =
          FirebaseDatabase.instance.reference().child('allusers/${user.uid}');
      allUserref.set('shopkeeper');

      Navigator.pushNamed(context, CreateStoreScreen.id);

      print('registeration sucessfull');
    } else {}
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        ),
                      ],
                      color: Color(0xFF7607BD)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        Container(
                            height: 2,
                            width: 50,
                            child: Divider(
                              color: Colors.white,
                              thickness: 2,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Create a new Account',
                          style: TextStyle(color: Colors.white, fontSize: 21),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Text('Email',style: TextStyle(color: Colors.white,fontSize: 16),),
                            TextFormField(
                              controller: fullNameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: TextStyle(fontSize: 14),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 10.0),
                              ),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
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
                            TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(fontSize: 14),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 10.0),
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
                            TextFormField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
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
                              onPressed: () async {
                                if (fullNameController.text.length < 3) {
                                  showSnackbar(
                                      'Please provide a valid fullname');
                                  return;
                                }
                                if (phoneController.text.length < 10) {
                                  showSnackbar(
                                      'Please provide a valid phone number');
                                  return;
                                }
                                if (!emailController.text.contains('@')) {
                                  showSnackbar(
                                      'Please provide a valid email address');
                                  return;
                                }
                                if (passwordController.text.length < 6) {
                                  showSnackbar(
                                      'Please provide a valid password greater than 6 characters');
                                  return;
                                }

                                registerStore();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                              ),
                              child: Text(
                                'Create Store',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
