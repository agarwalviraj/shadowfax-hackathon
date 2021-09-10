import 'package:flutter/material.dart';

class RapidButton extends StatelessWidget {
  RapidButton({this.text, this.onPressed});

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          primary: Colors.orange,
          padding: EdgeInsets.symmetric(horizontal: 4)),
      child: Text(
        text!,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
