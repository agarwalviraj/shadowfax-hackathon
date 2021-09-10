import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rapid_knight/Helpers/RequestHelper.dart';
import 'package:rapid_knight/Models/Address.dart';
import 'package:rapid_knight/Models/Cart.dart';
import 'package:rapid_knight/Models/User.dart';
import 'package:rapid_knight/Models/directionDetails.dart';
import 'package:rapid_knight/dataProviders/AppData.dart';
import 'package:rapid_knight/globalVariables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperMethods {
  DatabaseReference? foodRef;

  static Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<DirectionDetails?> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$mapKey';
    var response = await RequestHelper.getRequest(url);
    if (response == 'failed') {
      return null;
    }
    DirectionDetails directionDetails = DirectionDetails();
    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];

    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];

    return directionDetails;
  }

  static Future<String> getAddressfromLocation(
      double latitude, double longitude, context) async {
    String placeAddress = '';

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$mapKey';

    var response = await RequestHelper.getRequest(url);

    if (response != 'failed') {
      if (response['results'] != null && response['results'].length != 0) {
        placeAddress = response['results'][0]['formatted_address'];
      }
    }
    Address pickupAddress = Address();
    pickupAddress.latitude = latitude;
    pickupAddress.longitude = longitude;
    pickupAddress.placeName = placeAddress;
    Provider.of<AppData>(context, listen: false)
        .updatePickupAddress(pickupAddress);
    return placeAddress;
  }

  static String? checkUserType() {
    if (currentFirebaseUser != null) {
      DatabaseReference allUserref = FirebaseDatabase.instance
          .reference()
          .child('allusers/${currentFirebaseUser!.uid}');
      allUserref.once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          print(snapshot.value);
          allUserref.once().then((DataSnapshot snapshot) => {
                if (snapshot.value != null)
                  {userType = snapshot.value.toString()}
              });
        }
      });
    }
    return userType;
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

  static sendNotification(String token, context, String ride_id) async {
    var destination =
        await getAddressfromLocation(34.2909480000, 29.3453553400, context);

    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': serverKey,
    };

    Map notificationMap = {
      'title': 'NEW TRIP REQUEST',
      'body': 'Destination, $destination'
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'waiting',
      'request_id': currentFirebaseUser!.uid,
      'ride_id': ride_id,
    };

    Map bodyMap = {
      'notification': notificationMap,
      'data': dataMap,
      'priority': 'high',
      'to': token,
    };

    var response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headerMap,
      body: jsonEncode(bodyMap),
    );

    print(response.body);
  }

  static updateNameToken(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = await FirebaseMessaging.instance.getToken();

    DatabaseReference userInfo = FirebaseDatabase.instance
        .reference()
        .child('stores/${FirebaseAuth.instance.currentUser!.uid}');
    userInfo.child('fullName').once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        String name = snapshot.value;
        print(name);
        await prefs.setString('name', name);
        // Provider.of<AppData>(context, listen: false).updateName(name);

        DatabaseReference storeTokenRef =
            FirebaseDatabase.instance.reference().child('tokens/stores/$name');
        storeTokenRef.set(token);
      }
    });
    userInfo.child('phone').once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        String phone = snapshot.value;
        print(phone);
        await prefs.setString('phone', phone);
        // Provider.of<AppData>(context, listen: false).updateName(name);

        DatabaseReference storeTokenRef =
            FirebaseDatabase.instance.reference().child('tokens/stores/$phone');
        storeTokenRef.set(token);
      }
    });

    // Provider.of<AppData>(context, listen: false).updateToken(token!);
  }

  static void getCurrentUserInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser!;
    String userid = currentFirebaseUser!.uid;
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/$userid');

    userRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        currentUserInfo = UserData.fromSnapshot(snapshot);
        print('My name is ${currentUserInfo!.fullname}');
      }
    });
  }
}
