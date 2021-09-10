import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_knight/Helpers/HelperMethods.dart';
import 'package:rapid_knight/Models/Cart.dart';
import 'package:rapid_knight/dataProviders/AppData.dart';
import 'package:rapid_knight/widgets/RapidButton.dart';
import 'package:rapid_knight/widgets/RapidDrawer.dart';
import 'package:rapid_knight/widgets/SearchBox.dart';

import 'SearchScreen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

void showSnackbar(String title) {
  final snackBar = SnackBar(
    content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ),
  );
  scaffoldKey.currentState!.showSnackBar(snackBar);
}

class HomeScreen extends StatefulWidget {
  static String id = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperMethods.updateNameToken(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('HomePage'),
      ),
      drawer: RapidDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/home_img.png'),
                  fit: BoxFit.cover,
                )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SearchBox(),
                        Row(
                          children: [
                            RapidButton(
                              text: 'Fruits & Beverages',
                              onPressed: () {
                                Navigator.pushNamed(context, SearchScreen.id);
                              },
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            RapidButton(
                              text: 'Sauces',
                              onPressed: () {
                                Navigator.pushNamed(context, SearchScreen.id);
                              },
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            RapidButton(
                              text: 'Staples',
                              onPressed: () {
                                Navigator.pushNamed(context, SearchScreen.id);
                              },
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            RapidButton(
                              text: 'Beverages',
                              onPressed: () {
                                Navigator.pushNamed(context, SearchScreen.id);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Top Deals',
                style: TextStyle(
                    color: Colors.orange,
                    decorationThickness: 3,
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                    fontFamily: 'Poppins-Bold'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 220,
                child: FutureBuilder(
                  future: HelperMethods.ReadJsonData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as List<Cart>;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.all(6),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: TopDealsItem(
                                  title: items[index].itemName,
                                  image: items[index].imageUrl,
                                  cartItem: items[index],
                                  index: index,
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Image(
                image: AssetImage('assets/images/offers.png'),
                height: 235,
                width: 278,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TopDealsItem extends StatelessWidget {
  TopDealsItem({this.title, this.image, this.cartItem, this.index});
  final Cart? cartItem;
  final int? index;
  late final String? image;
  late final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black26,
          //     blurRadius: 5.0,
          //     spreadRadius: 0.5,
          //     offset: Offset(0.7, 0.7),
          //   ),
          //],
          ),
      child: Column(
        children: [
          Image(
            image: NetworkImage(
              image!,
            ),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          Text(
            title!,
            style: TextStyle(color: Color(0xFFE84325)),
            overflow: TextOverflow.ellipsis,
          ),
          RapidButton(
            text: 'Add To Basket',
            onPressed: () {
              if (!(cartItem!.addedToCart!)) {
                Provider.of<AppData>(context, listen: false)
                    .increaseItemQuantity(cartItem!.id!);
                Provider.of<AppData>(context, listen: false)
                    .addItems(cartItem!);
                print(Provider.of<AppData>(context, listen: false)
                    .cartItems![0]
                    .itemName);
                cartItem!.addedToCart = true;
              } else {
                showSnackbar('Already present in cart!');
              }
            },
          )
        ],
      ),
    );
  }
}
