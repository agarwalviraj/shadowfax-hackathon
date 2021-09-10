import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rapidknight_shopkeeper/Helpers/HelperMethods.dart';
import 'package:rapidknight_shopkeeper/models/Address.dart';
import 'package:rapidknight_shopkeeper/screens/HomeScreen.dart';

import '../globalVariable.dart';

class CreateStoreScreen extends StatefulWidget {
  static String id = 'create store';
  const CreateStoreScreen({Key? key}) : super(key: key);

  @override
  _CreateStoreScreenState createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final shopNameController = TextEditingController();
  final shopDescriptionController = TextEditingController();
  String myaddress = '';
  final locationController = TextEditingController();
  Address myAddressLocation = Address();

  Future<void> createStore() async {
    if (_auth.currentUser != null) {
      DatabaseReference newStoreRef = FirebaseDatabase.instance
          .reference()
          .child('stores/${_auth.currentUser!.uid}/storeDetails');
      Map newlocationMap = ({
        'longitude': myAddressLocation.longitude,
        'latitude': myAddressLocation.latitude,
        'address': myAddressLocation.placeFormattedAddress,
      });
      newStoreRef.set({
        'Shop Name': shopNameController.text,
        'shop description': shopDescriptionController.text,
        'shop location': newlocationMap,
      });
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.id, (route) => false);
    }
  }

  Future<void> getLocation() async {
    Position position =
        await HelperMethods.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
    myCurrentposition = position;
    String address = await HelperMethods.getAddressfromLocation(position);
    myAddressLocation.latitude = position.latitude;
    myAddressLocation.longitude = position.longitude;
    myAddressLocation.placeFormattedAddress = address;
    setState(() {
      myaddress = address;
    });
    print('${myCurrentposition!.longitude},${myCurrentposition!.latitude}');
    print(address.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    child: SvgPicture.asset(
                      'assets/svgs/shop.svg',
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 20,
                            color: Color(0xFFE84325)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        child: Text(
                          'Register your shop here',
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Shop Name',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: shopNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x35EC8B2C),
                      hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Text(
                  //   'Location',
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // TextFormField(
                  //   controller: shopNameController,
                  //   keyboardType: TextInputType.emailAddress,
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Color(0x35EC8B2C),
                  //     hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                  //   ),
                  //   style: TextStyle(fontSize: 14, color: Colors.white),
                  // ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  Text(
                    'Shop Description',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: shopDescriptionController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x35EC8B2C),
                      hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // if (fullNameController.text.length < 3) {
                      //   showSnackbar(
                      //       'Please provide a valid fullname');
                      //   return;
                      // }
                      // if (phoneController.text.length < 10) {
                      //   showSnackbar(
                      //       'Please provide a valid phone number');
                      //   return;
                      // }
                      // if (!emailController.text.contains('@')) {
                      //   showSnackbar(
                      //       'Please provide a valid email address');
                      //   return;
                      // }
                      // if (passwordController.text.length < 6) {
                      //   showSnackbar(
                      //       'Please provide a valid password greater than 6 characters');
                      //   return;
                      // }

                      //registerStore();
                      createStore();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: Text(
                      'Create Store',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
