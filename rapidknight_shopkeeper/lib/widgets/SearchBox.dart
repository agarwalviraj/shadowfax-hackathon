import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: TextField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          filled: true,
          hintText: 'Search here...',
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
        style: TextStyle(
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
