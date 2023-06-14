import 'package:flutter_woocommerce/view/screens/order/model/order_model.dart';

class ProductModel {
  int id;
  String name;
  String slug;
  String type;
  String description;
  String shortDescription;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  String dateOnSaleFrom;
  String dateOnSaleTo;
  bool onSale;
  String taxStatus;
  String taxClass;
  bool manageStock;
  int stockQuantity;
  int shippingClassId;
  double averageRating;
  int ratingCount;
  List<Categories> categories;
  List<String> tags;
  List<ImageModel> images;
  List<Attributes> attributes;
  List<int> variations;
  List<int> relatedIds;
  List<VariationProducts> variationProducts;
  List<ProductVariation> variation;
  String status;

  ProductModel({
    this.id,
    this.name,
    this.slug,
    this.type,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleTo,
    this.onSale,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.shippingClassId,
    this.averageRating,
    this.ratingCount,
    this.categories,
    this.images,
    this.attributes,
    this.variations,
    this.relatedIds,
    this.variationProducts,
    this.variation,
    this.status,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['name'] != null) {
      name = (json['name']).replaceAll('amp;', '');
    }
    slug = json['slug'];
    type = json['type'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'].isNotEmpty
        ? json['regular_price']
        : json['price'];
    salePrice = json['sale_price'];
    dateOnSaleFrom = json['date_on_sale_from'];
    dateOnSaleTo = json['date_on_sale_to'];
    onSale = json['on_sale'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'] is String ? true : json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    // lowStockAmount = int.parse(json['low_stock_amount'].toString());
    shippingClassId = json['shipping_class_id'];
    if (json['average_rating'] != null) {
      averageRating = 0;
      averageRating = double.tryParse(json['average_rating'].toString());
    }
    ratingCount = json['rating_count'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images.add(new ImageModel.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes.add(Attributes.fromJson(v));
      });
    }
    //variations = json['variations'] != null ? json['variations'].cast<int>() : null;
    relatedIds =
        json['related_ids'] != null ? json['related_ids'].cast<int>() : null;
    if (json['variation_products'] != null) {
      variationProducts = <VariationProducts>[];
      json['variation_products'].forEach((v) {
        variationProducts.add(new VariationProducts.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      variation = <ProductVariation>[];
      json['variations'].forEach((v) {
        if (v.runtimeType != int) {
          variation.add(ProductVariation.fromJson(v));
        }
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['type'] = this.type;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['date_on_sale_from'] = this.dateOnSaleFrom;
    data['date_on_sale_to'] = this.dateOnSaleTo;
    data['on_sale'] = this.onSale;
    data['tax_status'] = this.taxStatus;
    data['tax_class'] = this.taxClass;
    data['manage_stock'] = this.manageStock;
    data['stock_quantity'] = this.stockQuantity;
    //data['low_stock_amount'] = this.lowStockAmount;
    data['shipping_class_id'] = this.shippingClassId;
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    // data['tags'] = this.tags;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    //data['variations'] = this.variations;
    data['related_ids'] = this.relatedIds;
    if (this.variationProducts != null) {
      data['variation_products'] =
          this.variationProducts.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['average_rating'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class ProductDimensions {
  String length;
  String width;
  String height;

  ProductDimensions({this.length, this.width, this.height});

  ProductDimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Categories {
  int id;
  String name;
  String slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class ImageModel {
  int id;
  String src;
  String name;
  String alt;

  ImageModel({this.id, this.src, this.name, this.alt});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? 0 : json['id'];
    src = json['src'] != false ? json['src'] : '';
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

class Attributes {
  // int id;
  String name;
  int position;
  bool visible;
  bool variation;
  List<String> options;

  Attributes(
      {
      //this.id,
      this.name,
      this.position,
      this.visible,
      this.variation,
      this.options});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['name'] != null) {
      String _name = json['name'];
      List<String> _splitName;
      _splitName = _name.split('_');
      name = _splitName.last;
    }
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    if (json['options'] != null && json['options'] != []) {
      options = [];
      // print('==Options==');
      // print(json['options']);
      print(json['options'].length);
      for (int i = 0; i < json['options'].length; i++) {
        options.add(json['options'][i].toString());
      }
    }
    //options = json['options'] != [] ? json['options'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    data['options'] = this.options;
    return data;
  }
}

class Links {
  List<Self> self;
  List<Self> collection;

  Links({this.self, this.collection});

  Links.fromJson(Map<String, dynamic> json) {
    self = <Self>[];
    json['self'].forEach((v) {
      self.add(new Self.fromJson(v));
    });
    collection = <Self>[];
    json['collection'].forEach((v) {
      collection.add(new Self.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Rating {
  String rating;
  int count;

  Rating({this.rating, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['count'] = this.count;
    return data;
  }
}

class ProductVariation {
  int id;
  List<VariationAttributes> attributes;
  VariationImage variationImage;
  num price;
  num regularPrice;
  num salePrice;
  String sku;
  int stockQuantity;
  String variation;
  bool manageStock;

  ProductVariation(
      {this.id,
      this.attributes,
      this.variationImage,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.sku,
      this.stockQuantity,
      this.variation,
      this.manageStock});

  ProductVariation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['attributes'] != null) {
      attributes = <VariationAttributes>[];
      json['attributes'].forEach((v) {
        attributes.add(new VariationAttributes.fromJson(v));
      });
    }
    variationImage = json['variation_image'] != null
        ? new VariationImage.fromJson(json['variation_image'])
        : null;
    price = json['price'];
    regularPrice = json['regular_price'];
    if (json['sale_price'] != '') {
      salePrice = json['sale_price'];
    } else {
      salePrice = null;
    }
    sku = json['sku'];
    if (json['stock_quantity'] != null && json['stock_quantity'] != '') {
      stockQuantity = json['stock_quantity'];
    }
    variation = json['variation'];
    if (json['manage_stock'] != null && json['manage_stock'] != '') {
      if (json['manage_stock'] == 'parent') {
        manageStock = false;
      } else {
        manageStock = json['manage_stock'];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    if (this.variationImage = null) {
      data['variation_image'] = this.variationImage.toJson();
    }
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['sku'] = this.sku;
    data['stock_quantity'] = this.stockQuantity;
    data['variation'] = this.variation;
    data['manage_stock'] = this.manageStock;
    return data;
  }
}

class VariationAttributes {
  int id;
  String name;
  String options;

  VariationAttributes({this.id, this.name, this.options});

  VariationAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['name'] != null) {
      String _name = json['name'];
      List<String> _splitName;
      _splitName = _name.split('_');
      name = _splitName.last;
    }
    options = json['options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['options'] = this.options;
    return data;
  }
}

class VariationImage {
  int id;
  String src;

  VariationImage({this.id, this.src});

  VariationImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['src'] != false) {
      src = json['src'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    return data;
  }
}

class GroupedProduct {
  int id;
  String name;
  String slug;
  String type;
  String status;
  List<int> upsellIds;
  List<int> groupedProducts;
  List<ImageModel> images;
  int menuOrder;
  String priceHtml;
  List<int> relatedIds;
  String stockStatus;
  bool hasOptions;

  GroupedProduct(
      {this.id,
      this.name,
      this.slug,
      this.type,
      this.status,
      this.upsellIds,
      this.images,
      this.menuOrder,
      this.priceHtml,
      this.relatedIds,
      this.stockStatus,
      this.hasOptions,
      this.groupedProducts});

  GroupedProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    type = json['type'];
    status = json['status'];
    upsellIds = json['upsell_ids'].cast<int>();
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images.add(new ImageModel.fromJson(v));
      });
    }
    menuOrder = json['menu_order'];
    priceHtml = json['price_html'];
    relatedIds = json['related_ids'].cast<int>();
    stockStatus = json['stock_status'];
    hasOptions = json['has_options'];
    if (json['grouped_products'] != null) {
      groupedProducts = json['grouped_products'].cast<int>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['type'] = this.type;
    data['status'] = this.status;
    data['upsell_ids'] = this.upsellIds;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['menu_order'] = this.menuOrder;
    data['price_html'] = this.priceHtml;
    data['related_ids'] = this.relatedIds;
    data['stock_status'] = this.stockStatus;
    data['has_options'] = this.hasOptions;
    data['grouped_products'] = this.groupedProducts;
    return data;
  }
}

class Imagep {
  int id;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String src;
  String name;
  String alt;

  Imagep(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.src,
      this.name,
      this.alt});

  Imagep.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

class WishedModel {
  int id;
  List<ProductModel> wishedProductList;

  WishedModel({
    this.id,
    this.wishedProductList,
  });

  WishedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_list'] != null) {
      wishedProductList = <ProductModel>[];
      json['product_list'].forEach((v) {
        wishedProductList.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.wishedProductList != null) {
      data['product_list'] =
          this.wishedProductList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
