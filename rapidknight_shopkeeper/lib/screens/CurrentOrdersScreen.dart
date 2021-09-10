import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CurrentOrders extends StatefulWidget {
  static String id = 'current orders';
  const CurrentOrders({Key? key}) : super(key: key);

  @override
  _CurrentOrdersState createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Current Orders',
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance
            .reference()
            .child('rideRequest')
            .child('-MjDclZ4Yqk4d0oFAmWN/foodReq')
            .onValue,
        builder: (context, AsyncSnapshot<Event> asyncSnapshot) {
          if (asyncSnapshot.hasData &&
              !(asyncSnapshot.hasError) &&
              asyncSnapshot.data != null) {
            var items = asyncSnapshot.data!.snapshot.value;
            return Center(
                child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Image(
                        image: NetworkImage(items[index]['imaeUrl']),
                      ),
                      title: Text('${items[index]['itemName']}'),
                      subtitle: Text('Price: \u{20B9}${items[index]['price']}'),
                      trailing: Text('Quantity: ${items[index]['quantity']}'),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
