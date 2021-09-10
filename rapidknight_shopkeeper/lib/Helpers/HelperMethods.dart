import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rapidknight_shopkeeper/dataProviders/AppData.dart';
import 'package:rapidknight_shopkeeper/models/Cart.dart';
import 'package:rapidknight_shopkeeper/models/User.dart';

import '../globalVariable.dart';
import 'RequestHelper.dart';

class HelperMethods {
  static Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<String> getAddressfromLocation(Position position) async {
    String placeAddress = '';

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';

    var response = await RequestHelper.getRequest(url);

    if (response != 'failed') {
      placeAddress = response['results'][0]['formatted_address'];
    }
    return placeAddress;
  }

  static void getCurrentUserInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser!;
    String userid = currentFirebaseUser!.uid;
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('stores/$userid');

    userRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        currentUserInfo = UserData.fromSnapshot(snapshot);
        print('My name is ${currentUserInfo!.fullname}');
      }
    });
  }

  static getName() {
    DatabaseReference nameRef = FirebaseDatabase.instance
        .reference()
        .child('stores/${FirebaseAuth.instance.currentUser!.uid}/fullName');
    nameRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        return snapshot.value;
      }
    });
  }

  static updateNameToken(context) async {
    String? token = await FirebaseMessaging.instance.getToken();

    DatabaseReference nameRef = FirebaseDatabase.instance
        .reference()
        .child('stores/${FirebaseAuth.instance.currentUser!.uid}/fullName');
    nameRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        String name = snapshot.value;
        print(name);
        Provider.of<AppData>(context, listen: false).updateName(name);

        DatabaseReference storeTokenRef =
            FirebaseDatabase.instance.reference().child('tokens/stores/$name');
        storeTokenRef.set(token);
      }
    });

    Provider.of<AppData>(context, listen: false).updateToken(token!);
  }

  static Future<List<Cart>> ReadJsonData() async {
    //read json file
    final jsondata =
        await rootBundle.rootBundle.loadString('jsons/products.json');
    //decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    return list.map((e) => Cart.fromJson(e)).toList();
  }
}
