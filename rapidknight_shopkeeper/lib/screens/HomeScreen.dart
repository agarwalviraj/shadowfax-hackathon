import 'package:flutter/material.dart';
import 'package:rapidknight_shopkeeper/Helpers/HelperMethods.dart';
import 'package:rapidknight_shopkeeper/screens/CurrentOrdersScreen.dart';
import 'package:rapidknight_shopkeeper/screens/PastOrdersScreen.dart';
import 'package:rapidknight_shopkeeper/widgets/RapidDrawer.dart';

setUpname(context) async {
  await HelperMethods.updateNameToken(context);
}

class HomeScreen extends StatefulWidget {
  static String id = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperMethods.getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    setUpname(context);

    final name = HelperMethods.getName();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: RapidDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 18,
                  color: Color(0xFFE84325),
                ),
              ),
              Text(
                'Shopkeeper',
                // currentUserInfo!.fullname == null
                //     ? 'Shopkeeper'
                //     : currentUserInfo!.fullname!,
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CurrentOrders.id);
                    },
                    child: ReusableCard(
                      title: 'Current Orders',
                      img: 'assets/images/cargo.png',
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PastOrdersScreen.id);
                    },
                    child: ReusableCard(
                      title: 'Past Orders',
                      img: 'assets/images/box.png',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  ReusableCard(
                    title: 'Your earnings',
                    img: 'assets/images/growth.png',
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ReusableCard(
                    title: 'Your Store',
                    img: 'assets/images/store.png',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  String? title;
  String? img;
  ReusableCard({this.title, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 170,
      decoration: BoxDecoration(
        color: Color(0xFFEC8B2C),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        padding: EdgeInsets.all(13),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontFamily: 'Poppins-Semibold'),
              ),
              SizedBox(
                height: 7,
              ),
              Image(
                image: AssetImage(img!),
                height: 90,
                width: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
