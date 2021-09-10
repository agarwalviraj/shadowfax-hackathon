import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import 'models/User.dart';

String mapKey = 'AIzaSyCHeaBTio-AeysW6em7vfoiMR6qWBTJOBY';

User? currentFirebaseUser;

Position? myCurrentposition;

String? userType;

String? name;

UserData? currentUserInfo;
