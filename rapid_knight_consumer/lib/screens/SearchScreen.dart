import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_knight/Helpers/HelperMethods.dart';
import 'package:rapid_knight/Models/Cart.dart';
import 'package:rapid_knight/dataProviders/AppData.dart';
import 'package:rapid_knight/widgets/RapidButton.dart';
import 'package:rapid_knight/widgets/RapidDrawer.dart';
import 'package:rapid_knight/widgets/SearchBox.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
setupList() async {
  List<Cart> mainDataList = await HelperMethods.ReadJsonData();
}

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

class SearchScreen extends StatefulWidget {
  static String id = 'search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: RapidDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Search'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SearchBox(),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Row(
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
                      text: 'Beauty',
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
                      text: 'View All',
                      onPressed: () {
                        Navigator.pushNamed(context, SearchScreen.id);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Best Sellers',
                  style: TextStyle(
                      color: Colors.orange,
                      decorationThickness: 2,
                      decoration: TextDecoration.underline,
                      fontSize: 23,
                      fontFamily: 'Poppins-Normal'),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 16,
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
                            if (items[index].popular!) {
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
                            } else {
                              return SizedBox(
                                height: 0,
                                width: 0,
                              );
                            }
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
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'New',
                  style: TextStyle(
                      color: Colors.orange,
                      decorationThickness: 2,
                      decoration: TextDecoration.underline,
                      fontSize: 23,
                      fontFamily: 'Poppins-Normal'),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
