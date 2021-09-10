import 'package:flutter/material.dart';

class ShopHomeScreen extends StatefulWidget {
  static String id = 'shop home';
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  _ShopHomeScreenState createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
