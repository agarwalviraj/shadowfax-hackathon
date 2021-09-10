import 'package:flutter/cupertino.dart';
import 'package:rapid_knight/Models/Address.dart';
import 'package:rapid_knight/Models/Cart.dart';

class AppData extends ChangeNotifier {
  List<Cart>? cartItems = [];
  double sum = 0;
  Address? pickupAddress;

  void updateCartItems(List<Cart> newCartItems) {
    cartItems = newCartItems;
    notifyListeners();
  }

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  void addItems(Cart newItem) {
    newItem.quantity = newItem.quantity! + 1;
    cartItems!.add(newItem);
    notifyListeners();
  }

  void removeItems(String id) {
    cartItems!.removeWhere((element) => element.id == id);
    cartItems!.forEach((element) {
      if (element.id! == id) {
        element.addedToCart = false;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  // void updateItemQuantity(int index, int newQuantity) {
  //   cartItems![index].quantity = newQuantity;
  //   notifyListeners();
  // }
  void increaseItemQuantity(String id) {
    cartItems!.forEach((element) {
      if (element.id! == id) {
        element.quantity = element.quantity! + 1;
        notifyListeners();
      }
    });
  }

  void decreaseItemQuantity(String id) {
    cartItems!.forEach((element) {
      if (element.id! == id) {
        element.quantity = element.quantity! - 1;
        notifyListeners();
      }
    });
  }
}
