import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {
  static String id = 'pay';
  const PayScreen({Key? key}) : super(key: key);

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Text(
              'Total \u{20B9}10000',
              style: TextStyle(fontSize: 24, fontFamily: 'Poppins-SemiBold'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image(
              image: AssetImage(
                'assets/images/creditcard.png',
              ),
              height: 400,
              width: 350,
            ),
          )
        ],
      ),
    );
  }
}
