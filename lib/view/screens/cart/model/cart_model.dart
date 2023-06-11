import 'package:flutter_woocommerce/view/screens/cart/model/coupon_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/model/tax_model.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';

class CartModel {
  String key;
  int id;
  int quantity;
  QuantityLimits quantityLimits;
  String name;
  String shortDescription;
  String description;
  String sku;
  List<ImageModel> images;
  List<Variation> variation;
  String variationText;
  Prices prices;
  Totals totals;
  CouponModel coupon;
  ProductModel product;
  TaxModel tax;
  String variationImage;

  CartModel(
      {this.key,
        this.id,
        this.quantity,
        this.quantityLimits,
        this.name,
        this.shortDescription,
        this.description,
        this.sku,
        this.images,
        this.variation,
        this.variationText,
        this.prices,
        this.totals,
        this.coupon,
        this.product,
        this.tax,
        this.variationImage,
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    quantity = json['quantity'];
    quantityLimits = json['quantity_limits'] != null ? new QuantityLimits.fromJson(json['quantity_limits']) : null;
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    variationText = json['variation_text'];
    sku = json['sku'];
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images.add(new ImageModel.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      variation = <Variation>[];
      json['variation'].forEach((v) {
        variation.add(new Variation.fromJson(v));
      });
    }
    prices = json['prices'] != null ? new Prices.fromJson(json['prices']) : null;
    totals = json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
    coupon = json['coupon'] != null ? new CouponModel.fromJson(json['coupon']) : null;
    product = json['product'] != null ? new ProductModel.fromJson(json['product']) : null;
    tax = json['tax'] != null ? new TaxModel.fromJson(json['tax']) : null;
    variationImage = json['variation_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    if (this.quantityLimits != null) {
      data['quantity_limits'] = this.quantityLimits.toJson();
    }
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['variation_text'] = this.variationText;
    data['sku'] = this.sku;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.variation != null) {
      data['variation'] = this.variation.map((v) => v.toJson()).toList();
    }
    if (this.prices != null) {
      data['prices'] = this.prices.toJson();
    }
    if (this.totals != null) {
      data['totals'] = this.totals.toJson();
    }
    if (this.coupon != null) {
      data['coupon'] = this.coupon.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.tax != null) {
      data['tax'] = this.tax.toJson();
    }
    data['variation_image'] = this.variationImage;
    return data;
  }
}

class QuantityLimits {
  int minimum;
  int maximum;

  QuantityLimits({this.minimum, this.maximum});

  QuantityLimits.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    return data;
  }
}

class Variation {
  String attribute;
  String value;
  String valueSku;

  Variation({this.attribute, this.value, this.valueSku});

  Variation.fromJson(Map<String, dynamic> json) {
    attribute = json['attribute'];
    value = json['value'];
    valueSku = json['value_sku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute'] = this.attribute;
    data['value'] = this.value;
    data['value_sku'] = this.valueSku;
    return data;
  }
}

class Prices {
  String price;
  String regularPrice;
  String salePrice;
  String priceRange;
  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyPrefix;
  String currencySuffix;
  RawPrices rawPrices;

  Prices(
      {this.price,
        this.regularPrice,
        this.salePrice,
        this.priceRange,
        this.currencyCode,
        this.currencySymbol,
        this.currencyMinorUnit,
        this.currencyPrefix,
        this.currencySuffix,
        this.rawPrices});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    priceRange = json['price_range'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
    rawPrices = json['raw_prices'] != null ?
         new RawPrices.fromJson(json['raw_prices'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['price_range'] = this.priceRange;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    if (this.rawPrices != null) {
      data['raw_prices'] = this.rawPrices.toJson();
    }
    return data;
  }
}

class RawPrices {
  int precision;
  String price;
  String regularPrice;
  String salePrice;

  RawPrices({this.precision, this.price, this.regularPrice, this.salePrice});

  RawPrices.fromJson(Map<String, dynamic> json) {
    precision = json['precision'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['precision'] = this.precision;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    return data;
  }
}

class Totals {
  String lineSubtotal;
  String lineSubtotalTax;
  String lineTotal;
  String lineTotalTax;
  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyPrefix;
  String currencySuffix;

  Totals(
      {this.lineSubtotal,
        this.lineSubtotalTax,
        this.lineTotal,
        this.lineTotalTax,
        this.currencyCode,
        this.currencySymbol,
        this.currencyMinorUnit,
        this.currencyPrefix,
        this.currencySuffix});

  Totals.fromJson(Map<String, dynamic> json) {
    lineSubtotal = json['line_subtotal'];
    lineSubtotalTax = json['line_subtotal_tax'];
    lineTotal = json['line_total'];
    lineTotalTax = json['line_total_tax'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line_subtotal'] = this.lineSubtotal;
    data['line_subtotal_tax'] = this.lineSubtotalTax;
    data['line_total'] = this.lineTotal;
    data['line_total_tax'] = this.lineTotalTax;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    return data;
  }
}


class CartModelAll {
  int id;
  List<CartModel> cartList;

  CartModelAll({
    this.id,
    this.cartList,
  });

  CartModelAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cart_list'] != null) {
      cartList = <CartModel>[];
      json['cart_list'].forEach((v) {
        cartList.add(CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cartList != null) {
      data['cart_list'] = this.cartList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

