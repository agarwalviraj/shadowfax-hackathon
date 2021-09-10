import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  String? name;
  String? token;

  void updateNameandToken(String newname, String newtoken) {
    name = newname;
    token = newtoken;
  }

  void updateName(String newname) {
    name = newname;
  }

  void updateToken(String newToken) {
    token = newToken;
  }
}
