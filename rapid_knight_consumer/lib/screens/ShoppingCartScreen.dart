import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rapid_knight/Helpers/HelperMethods.dart';
import 'package:rapid_knight/Models/Cart.dart';
import 'package:rapid_knight/dataProviders/AppData.dart';
import 'package:rapid_knight/globalVariables.dart';
import 'package:rapid_knight/widgets/collectPayment.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
String? ride_id;
DatabaseReference? rideRef;
void addCartItems(List<Cart> cart, context) {
  double sum = 0;
  cart.forEach((element) {
    sum = sum + double.parse(element.price!.trim()) * element.quantity!;
  });
  Provider.of<AppData>(context).sum = sum;
}

void checkOut(context) async {
  var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;

  rideRef = FirebaseDatabase.instance.reference().child('foodRequest').push();

  HelperMethods.getCurrentUserInfo();
  Position position = await HelperMethods.getCurrentLocation();
  String address = await HelperMethods.getAddressfromLocation(
      position.latitude, position.longitude, context);
  DatabaseReference allUserref =
      FirebaseDatabase.instance.reference().child('tokens/Kartikey');

  // var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;
  // var destination =
  //     Provider.of<AppData>(context, listen: false).destinationAddress;

  Map pickupMap = {
    'latitude': '34.2909480000',
    'longitude': '29.3453553400',
  };
  Map destinationMap = {
    'latitude': '34.2909480000',
    'longitude': '29.3453553400',
  };

  Map rideMap = {
    'created_at': DateTime.now().toString(),
    'pickup_address': address,
    //'destination_address': destination.placeName,
    'location': pickupMap,
    'destination': destinationMap,
    'payment_method': 'card',
    'driver_id': 'waiting',
  };
  rideRef!.set(rideMap);
  ride_id = rideRef!.key;

  allUserref.once().then((DataSnapshot snapshot) {
    print(snapshot.value);
    if (snapshot.value != null) {
      var token = snapshot.value;
      print('token: ' + token);
      HelperMethods.sendNotification(token, context, ride_id!);
    }
  });

  var eleList = [];
  Provider.of<AppData>(context, listen: false).cartItems!.forEach((element) {
    print(element.toString());
    Map ele = {
      'itemName': element.itemName,
      'id': element.id,
      'price': element.price,
      'quantity': element.quantity,
      'imaeUrl': element.imageUrl
    };
    eleList.add(ele);
  });
  rideRef!.child('foodReq').set(eleList);
}

class ShoppingCartScreen extends StatefulWidget {
  static String id = 'shopping cart';
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  StreamSubscription<Event>? rideSubscrption;

  String? driverCarDetails;

  String? driverFullName;

  String? driverPhoneNumber;

  var status;

  String? tripStatusDisplay;

  bool? isRequestingLocationDetails;

  @override
  Widget build(BuildContext context) {
    void updateToPickup(LatLng driverLocation) async {
      if (!isRequestingLocationDetails!) {
        isRequestingLocationDetails = true;

        var positionLatLng =
            LatLng(myCurrentposition!.latitude, myCurrentposition!.longitude);

        var thisDetails = await HelperMethods.getDirectionDetails(
            driverLocation, positionLatLng);

        if (thisDetails == null) {
          return;
        }

        setState(() {
          tripStatusDisplay =
              'Driver is Arriving - ${thisDetails.durationText}';
        });

        isRequestingLocationDetails = false;
      }
    }

    void checkout(context) async {
      var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;

      rideRef =
          FirebaseDatabase.instance.reference().child('rideRequest').push();

      HelperMethods.getCurrentUserInfo();
      Position position = await HelperMethods.getCurrentLocation();
      String address = await HelperMethods.getAddressfromLocation(
          position.latitude, position.longitude, context);
      DatabaseReference storeToken =
          FirebaseDatabase.instance.reference().child('tokens/stores/Kartikey');
      DatabaseReference driverToken = FirebaseDatabase.instance
          .reference()
          .child('tokens/drivers/Kartikey');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;
      // var destination =
      //     Provider.of<AppData>(context, listen: false).destinationAddress;

      Map pickupMap = {
        'latitude': '26.8701',
        'longitude': '80.9972',
      };
      Map destinationMap = {
        'latitude': '28.3222163',
        'longitude': '79.4760902',
      };
      var destAddress = await HelperMethods.getAddressfromLocation(
          28.3222163, 79.4760902, context);
      var name = prefs.getString('name');
      var phone = prefs.getString('phone');

      Map rideMap = {
        'created_at': DateTime.now().toString(),
        'pickup_address': address,
        //'destination_address': destination.placeName,
        'location': pickupMap,
        'destination': destinationMap,
        'destination_address': destAddress,
        'payment_method': 'card',
        'driver_id': 'waiting',
        "rider_name": name,
        "rider_phone": phone,
      };
      rideRef!.set(rideMap);
      ride_id = rideRef!.key;

      storeToken.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        if (snapshot.value != null) {
          var token = snapshot.value;
          print('token: ' + token);
          HelperMethods.sendNotification(token, context, ride_id!);
        }
      });
      driverToken.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        if (snapshot.value != null) {
          var tokenDriver = snapshot.value;
          print('token: ' + tokenDriver);
          HelperMethods.sendNotification(tokenDriver, context, ride_id!);
        }
      });

      var eleList = [];
      Provider.of<AppData>(context, listen: false)
          .cartItems!
          .forEach((element) {
        print(element.toString());
        Map ele = {
          'itemName': element.itemName,
          'id': element.id,
          'price': element.price,
          'quantity': element.quantity,
          'imaeUrl': element.imageUrl
        };
        eleList.add(ele);
      });
      rideRef!.child('foodReq').set(eleList);
      rideSubscrption = rideRef!.onValue.listen((event) async {
        //check for null request
        if (event.snapshot.value == null) {
          return;
        }

        //get car details
        if (event.snapshot.value['car_details'] != null) {
          setState(() {
            driverCarDetails = event.snapshot.value['car_details'].toString();
          });
        }

        //get driver name
        if (event.snapshot.value['driver_name'] != null) {
          setState(() {
            driverFullName = event.snapshot.value['driver_name'].toString();
          });
        }

        //get driver phone number
        if (event.snapshot.value['driver_phone'] != null) {
          setState(() {
            driverPhoneNumber = event.snapshot.value['driver_phone'].toString();
          });
        }

        //get and use driver's location updates
        if (event.snapshot.value['driver_location'] != null) {
          double driverLat = double.parse(
              event.snapshot.value['driver_location']['latitude'].toString());
          double driverLng = double.parse(
              event.snapshot.value['driver_location']['longitude'].toString());

          LatLng driverLocation = LatLng(driverLat, driverLng);

          if (status == 'accepted') {
            updateToPickup(driverLocation);
          } else if (status == 'ontrip') {
          } else if (status == 'arrived') {
            setState(() {
              tripStatusDisplay = 'Driver has arrived';
            });
          }
        }

        if (event.snapshot.value['status'] != null) {
          status = event.snapshot.value['status'].toString();
        }

        if (status == 'accepted') {}

        if (status == 'ended') {
          if (event.snapshot.value['fares'] != null) {
            int fares = int.parse(event.snapshot.value['fares'].toString());

            var response = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => CollectPayment(
                paymentMethod: 'cash',
                fares: fares,
              ),
            );

            if (response == 'close') {
              rideRef!.onDisconnect();
              rideRef = null;
              rideSubscrption!.cancel();
              rideSubscrption = null;
            }
          }
        }
      });
    }

    addCartItems(Provider.of<AppData>(context).cartItems!, context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Your Basket'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 4,
              child: ListView.separated(
                padding: EdgeInsets.all(0),
                itemCount: Provider.of<AppData>(context).cartItems!.length,
                itemBuilder: (context, index) {
                  print(Provider.of<AppData>(context).cartItems!.length);
                  return BasketTile(
                    item: Provider.of<AppData>(context).cartItems![index],
                    index: index,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Total amount : \u{20B9}${Provider.of<AppData>(context).sum.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 25, color: Color(0xFFEC8B2C)),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 35),
              child: ElevatedButton(
                onPressed: () {
                  checkout(context);
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BasketTile extends StatelessWidget {
  final Cart? item;
  final int? index;

  BasketTile({this.item, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 100,
                width: 100,
                child: Image(
                  image: NetworkImage(item!.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item!.itemName!,
                    style: TextStyle(
                      fontSize: 19,
                      color: Color(0xFFE84325),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              if (item!.quantity == 1) {
                                Provider.of<AppData>(context, listen: false)
                                    .decreaseItemQuantity(item!.id!);
                                Provider.of<AppData>(context, listen: false)
                                    .removeItems(item!.id!);
                              } else {
                                Provider.of<AppData>(context, listen: false)
                                    .decreaseItemQuantity(item!.id!);
                              }
                            },
                            child: Container(
                              height: 34,
                              width: 34,
                              color: Colors.orange,
                              child: Icon(
                                FontAwesomeIcons.minus,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(item!.quantity!.toString()),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AppData>(context, listen: false)
                                  .increaseItemQuantity(item!.id!);
                            },
                            child: Container(
                              color: Colors.orange,
                              height: 34,
                              width: 34,
                              child: Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      '\u{20B9}${item!.price!}',
                      style:
                          TextStyle(fontSize: 16, fontFamily: 'Poppins-Bold'),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
