class WishModel {
  int itemId;
  int productId;
  int variationId;
  String dateAdded;
  String price;
  bool inStock;

  WishModel(
      {int itemId,
        int productId,
        int variationId,
        String dateAdded,
        String price,
        bool inStock});

  WishModel.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    dateAdded = json['date_added'];
    price = json['price'];
    inStock = json['in_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['product_id'] = this.productId;
    data['variation_id'] = this.variationId;
    data['date_added'] = this.dateAdded;
    data['price'] = this.price;
    data['in_stock'] = this.inStock;
    return data;
  }
}