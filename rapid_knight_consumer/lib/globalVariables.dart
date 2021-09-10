import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import 'Models/User.dart';

String mapKey = 'AIzaSyCHeaBTio-AeysW6em7vfoiMR6qWBTJOBY';

String serverKey =
    'key=AAAAfqOlzBY:APA91bGfx-qpHW4FzIJ2c8GeT_pWxdOJ6YvEN_jrE8m8sZXm_3f9KMpYadOo4_roh9QjqKfiM9pxwZ68AkIQJ7Tcbu6gVYeVCEXD57kdHZg6Wk9b4LRCA4yFNNuXxrpMhYtvg6ntxpfk';

User? currentFirebaseUser;

Position? myCurrentposition;

String? userType;

UserData? currentUserInfo;
