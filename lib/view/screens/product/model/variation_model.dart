class VariationModel {
  int id;
  int parentId;
  String price;
  String regularPrice;
  String salePrice;
  String dateOnSaleFrom;
  String dateOnSaleTo;
  bool onSale;
  bool manageStock;
  int stockQuantity;
  List<AttributesModel> attributes;
  String variation;
  int image;

  VariationModel(
      {this.id,
        this.parentId,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.dateOnSaleFrom,
        this.dateOnSaleTo,
        this.onSale,
        this.manageStock,
        this.stockQuantity,
        this.attributes,
        this.variation,
        this.image,
      });

  VariationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    dateOnSaleFrom = json['date_on_sale_from'];
    dateOnSaleTo = json['date_on_sale_to'];
    onSale = json['on_sale'];
    manageStock = json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    if (json['attributes'] = null) {
      attributes = <AttributesModel>[];
      json['attributes'].forEach((v) {
        attributes.add(new AttributesModel.fromJson(v));
      });
    }
    variation = json['variation'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['date_on_sale_from'] = this.dateOnSaleFrom;
    data['date_on_sale_to'] = this.dateOnSaleTo;
    data['on_sale'] = this.onSale;
    data['manage_stock'] = this.manageStock;
    data['stock_quantity'] = this.stockQuantity;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['variation'] = this.variation;
    data['image'] = this.image;
    return data;
  }
}

class AttributesModel {
  int id;
  String name;
  String option;

  AttributesModel({this.id, this.name, this.option});

  AttributesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['option'] = this.option;
    return data;
  }
}
