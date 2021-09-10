import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rapidknight_shopkeeper/screens/CreateStoreScreen.dart';
import 'package:rapidknight_shopkeeper/screens/CurrentOrdersScreen.dart';
import 'package:rapidknight_shopkeeper/screens/HomeScreen.dart';
import 'package:rapidknight_shopkeeper/screens/LoginScreen.dart';
import 'package:rapidknight_shopkeeper/screens/PastOrdersScreen.dart';
import 'package:rapidknight_shopkeeper/screens/RegisterScreen.dart';

import 'dataProviders/AppData.dart';
import 'globalVariable.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin!.show(
      message.notification.hashCode,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel!.id,
          channel!.name,
          channel!.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: message.notification!.android!.smallIcon,
        ),
      ));
}

AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //
  // await flutterLocalNotificationsPlugin!
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel!);
  //
  // /// Update the iOS foreground notification presentation options to allow
  // /// heads up notifications.
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  currentFirebaseUser = FirebaseAuth.instance.currentUser;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin!.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                channel!.description,

                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: android.smallIcon,
              ),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:
            ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins-Medium'),
        initialRoute:
            (currentFirebaseUser == null) ? LoginScreen.id : HomeScreen.id,
        // userType = HelperMethods.checkUserType() == 'customer'
        //     ? HomeScreen.id
        //     : ShopHomeScreen.id,
        routes: {
          RegisterScreen.id: (context) => RegisterScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          CreateStoreScreen.id: (context) => CreateStoreScreen(),
          CurrentOrders.id: (context) => CurrentOrders(),
          PastOrdersScreen.id: (context) => PastOrdersScreen(),
        },
      ),
    );
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
  }
}
