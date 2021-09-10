import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapidknight_shopkeeper/screens/HomeScreen.dart';
import 'package:rapidknight_shopkeeper/screens/LoginScreen.dart';

class RapidDrawer extends StatelessWidget {
  const RapidDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
            child: Container(
                child: Image(
              image: AssetImage('assets/images/app_logo.jpg'),
            )),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.user,
              color: Color(0xFFE84325),
            ),
            title: Text(
              'Welcome User',
              style: TextStyle(color: Color(0xFFE84325), fontSize: 20),
            ),
          ),
          // ListTile(
          //   leading: Icon(
          //     FontAwesomeIcons.shoppingBasket,
          //     color: Color(0xFFE84325),
          //   ),
          //   title: GestureDetector(
          //     onTap: () {
          //       Navigator.pushNamed(context, ShoppingCartScreen.id);
          //     },
          //     child: Text(
          //       'Your Basket',
          //       style: TextStyle(color: Color(0xFFE84325), fontSize: 20),
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, LoginScreen.id);
            },
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Color(0xFFE84325),
              ),
              title: Text(
                'Sign Out',
                style: TextStyle(color: Color(0xFFE84325), fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
