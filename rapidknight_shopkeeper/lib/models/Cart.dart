class Cart {
  String? id;
  String? shopId;
  String? itemName;
  String? category;
  String? price;
  int? quantity;
  String? imageUrl;
  double? discountPrice;
  bool? popular;
  bool? addedToCart;

  Cart(
      {this.id,
      this.price,
      this.category,
      this.imageUrl,
      this.itemName,
      this.quantity,
      this.discountPrice,
      this.shopId,
      this.popular,
      this.addedToCart});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    itemName = json['title'];
    category = json['category'];
    quantity = 0;
    addedToCart = false;
    shopId = json['shopId'];
    imageUrl = json['url'];
    price = json['price'];
    popular = json['popular'];
  }
}
