import 'package:flutter/material.dart';
import 'package:rapidknight_shopkeeper/widgets/RapidButton.dart';
import 'package:rapidknight_shopkeeper/widgets/RapidDrawer.dart';

class PastOrdersScreen extends StatefulWidget {
  static String id = 'past orders';
  const PastOrdersScreen({Key? key}) : super(key: key);

  @override
  _PastOrdersScreenState createState() => _PastOrdersScreenState();
}

class _PastOrdersScreenState extends State<PastOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: RapidDrawer(),
        appBar: AppBar(
          title: Text("Past Orders"),
          backgroundColor: Colors.orange,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: "Poppins-Medium",
            fontSize: 20.0,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 15.0, 0.0, 0.0),
                  // height: 40.0,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          twoCard(),
                          twoCard(),
                          twoCard(),
                          twoCard(),
                          twoCard(),
                          twoCard(),
                        ],
                      )
                    ],
                  ),
                )
              ])),
        ));
  }
}

class twoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFC5CAE9),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: EdgeInsets.all(13),
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/images/home.png'),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      'Name Surname',
                      style: TextStyle(color: Color(0xFFE84325), fontSize: 14),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '123 street,City',
                      style: TextStyle(color: Color(0xFFE84325), fontSize: 12),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Waiting for Pickup',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 76),
                child: Column(
                  children: [
                    Text(
                      '12/12/2021',
                      style: TextStyle(
                        color: Color(0xFFE84325),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '5:30pm',
                      style: TextStyle(
                        color: Color(0xFFE84325),
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    RapidButton(
                      text: 'View Order',
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
