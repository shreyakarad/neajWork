import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/profile_model.dart';

class OrderModel {
  int id;
  int parentId;
  String status;
  String currency;
  bool pricesIncludeTax;
  String dateCreated;
  String dateModified;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  int customerId;
  String orderKey;
  ProfileAddressModel billing;
  ProfileAddressModel shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  String createdVia;
  String customerNote;
  String dateCompleted;
  String datePaid;
  String cartHash;
  String number;
  List<LineItems> lineItems;
  List<ShippingLines> shippingLines;
  List<FeeLines> feeLines;
  List<CouponLines> couponLines;
  List<Stores> stores;
  String paymentUrl;
  bool isEditable;
  bool needsPayment;
  bool needsProcessing;
  String currencySymbol;

  OrderModel(
      {this.id,
        this.parentId,
        this.status,
        this.currency,
        this.pricesIncludeTax,
        this.dateCreated,
        this.dateModified,
        this.discountTotal,
        this.discountTax,
        this.shippingTotal,
        this.shippingTax,
        this.cartTax,
        this.total,
        this.totalTax,
        this.customerId,
        this.orderKey,
        this.billing,
        this.shipping,
        this.paymentMethod,
        this.paymentMethodTitle,
        this.transactionId,
        this.createdVia,
        this.customerNote,
        this.dateCompleted,
        this.datePaid,
        this.cartHash,
        this.number,
        this.lineItems,
        this.shippingLines,
        this.feeLines,
        this.couponLines,
        this.paymentUrl,
        this.isEditable,
        this.needsPayment,
        this.needsProcessing,
        this.currencySymbol,
        this.stores,
      });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    status = json['status'];
    currency = json['currency'];
    pricesIncludeTax = json['prices_include_tax'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    cartTax = json['cart_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    customerId = json['customer_id'];
    orderKey = json['order_key'];
    billing = json['billing'] != null ? ProfileAddressModel.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null ? ProfileAddressModel.fromJson(json['shipping']) : null;
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    transactionId = json['transaction_id'];
    createdVia = json['created_via'];
    customerNote = json['customer_note'];
    dateCompleted = json['date_completed'];
    datePaid = json['date_paid'];
    cartHash = json['cart_hash'];
    number = json['number'];
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems.add(new LineItems.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = <ShippingLines>[];
      json['shipping_lines'].forEach((v) {
        shippingLines.add(new ShippingLines.fromJson(v));
      });
    }
    if (json['fee_lines'] != null) {
      feeLines = <FeeLines>[];
      json['fee_lines'].forEach((v) {
        feeLines.add(new FeeLines.fromJson(v));
      });
    }
    if (json['coupon_lines'] != null) {
      couponLines = <CouponLines>[];
      json['coupon_lines'].forEach((v) {
        couponLines.add(new CouponLines.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores.add(new Stores.fromJson(v));
      });
    }
    paymentUrl = json['payment_url'];
    isEditable = json['is_editable'];
    needsPayment = json['needs_payment'];
    needsProcessing = json['needs_processing'];
    currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['status'] = this.status;
    data['currency'] = this.currency;
    data['prices_include_tax'] = this.pricesIncludeTax;
    data['date_created'] = this.dateCreated;
    data['date_modified'] = this.dateModified;
    data['discount_total'] = this.discountTotal;
    data['discount_tax'] = this.discountTax;
    data['shipping_total'] = this.shippingTotal;
    data['shipping_tax'] = this.shippingTax;
    data['cart_tax'] = this.cartTax;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    data['customer_id'] = this.customerId;
    data['order_key'] = this.orderKey;
    if (this.billing != null) {
      data['billing'] = this.billing.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping.toJson();
    }
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['transaction_id'] = this.transactionId;
    data['created_via'] = this.createdVia;
    data['customer_note'] = this.customerNote;
    data['date_completed'] = this.dateCompleted;
    data['date_paid'] = this.datePaid;
    data['cart_hash'] = this.cartHash;
    data['number'] = this.number;
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems.map((v) => v.toJson()).toList();
    }
    if (this.shippingLines != null) {
      data['shipping_lines'] =
          this.shippingLines.map((v) => v.toJson()).toList();
    }
    if (this.feeLines != null) {
      data['fee_lines'] = this.feeLines.map((v) => v.toJson()).toList();
    }
    if (this.couponLines != null) {
      data['coupon_lines'] = this.couponLines.map((v) => v.toJson()).toList();
    }
    if (this.stores != null) {
      data['stores'] = this.stores.map((v) => v.toJson()).toList();
    }
    data['payment_url'] = this.paymentUrl;
    data['is_editable'] = this.isEditable;
    data['needs_payment'] = this.needsPayment;
    data['needs_processing'] = this.needsProcessing;
    data['currency_symbol'] = this.currencySymbol;
    return data;
  }
}

class LineItems {
  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String taxClass;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  String sku;
  double price;
  ImageModel image;
  String parentName;
  ProductModel productData;
  VariationProducts variationProducts;
  List<WcfmMetaData> wcfmMetaData;
  LineItems(
      {this.id,
        this.name,
        this.productId,
        this.variationId,
        this.quantity,
        this.taxClass,
        this.subtotal,
        this.subtotalTax,
        this.total,
        this.totalTax,
        this.sku,
        this.price,
        this.image,
        this.parentName,
        this.productData,
        this.variationProducts,
        this.wcfmMetaData,
      });

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    taxClass = json['tax_class'];
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    sku = json['sku'];
    price = json['price'].toDouble();
    image = json['image'] != null ? new ImageModel.fromJson(json['image']) : null;
    parentName = json['parent_name'];
    productData = json['product_data'] != null ? new ProductModel.fromJson(json['product_data']) : null;
    if(productData != null && productData.variationProducts != null) {
      for(VariationProducts variation in productData.variationProducts) {
        if(variation.id == variationId) {
          variationProducts = variation;
        }
      }
    }
    if(AppConstants.vendorType != VendorType.dokan ) {
      if (json['meta_data'] != null) {
        wcfmMetaData = <WcfmMetaData>[];
        json['meta_data'].forEach((v) {
          wcfmMetaData.add(new WcfmMetaData.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['variation_id'] = this.variationId;
    data['quantity'] = this.quantity;
    data['tax_class'] = this.taxClass;
    data['subtotal'] = this.subtotal;
    data['subtotal_tax'] = this.subtotalTax;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    data['sku'] = this.sku;
    data['price'] = this.price;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    data['parent_name'] = this.parentName;
    if (this.productData != null) {
      data['product_data'] = this.productData.toJson();
    }
    data['variation_products'] = this.variationProducts;
    return data;
  }
}

class ShippingLines {
  int id;
  String methodTitle;
  String methodId;
  String instanceId;
  String total;
  String totalTax;

  ShippingLines(
      {this.id,
        this.methodTitle,
        this.methodId,
        this.instanceId,
        this.total,
        this.totalTax});

  ShippingLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodTitle = json['method_title'];
    methodId = json['method_id'];
    instanceId = json['instance_id'];
    total = json['total'];
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['method_title'] = this.methodTitle;
    data['method_id'] = this.methodId;
    data['instance_id'] = this.instanceId;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    return data;
  }
}

class FeeLines {
  int id;
  String name;
  String taxClass;
  String taxStatus;
  String amount;
  String total;
  String totalTax;

  FeeLines(
      {this.id,
        this.name,
        this.taxClass,
        this.taxStatus,
        this.amount,
        this.total,
        this.totalTax});

  FeeLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    taxClass = json['tax_class'];
    taxStatus = json['tax_status'];
    amount = json['amount'];
    total = json['total'];
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tax_class'] = this.taxClass;
    data['tax_status'] = this.taxStatus;
    data['amount'] = this.amount;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    return data;
  }
}

class CouponLines {
  int id;
  String code;
  String discount;
  String discountTax;
  String discountType;
  List<MetaData> metaData;

  CouponLines({this.id, this.code, this.discount, this.discountTax, this.discountType, this.metaData});

  CouponLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    discount = json['discount'];
    discountTax = json['discount_tax'];
    discountTax = json['discount_tax'];
    if(json['meta_data'].isNotEmpty) {
      discountType = json['meta_data'][0]['value']['discount_type'];
    }
    if (json['meta_data'].isNotEmpty) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) {
        metaData.add(new MetaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['discount_tax'] = this.discountTax;
    data['discount_type'] = this.discountType;
    return data;
  }
}

class VariationProducts {
  int id;
  int productId;
  String price;
  String regularPrice;
  String salePrice;
  String featureImage;
  List<AttributesArr> attributesArr;

  VariationProducts(
      {this.id,
        this.productId,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.featureImage,
        this.attributesArr});

  VariationProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    featureImage = json['feature_image'];
    if (json['attributes'] != null) {
      attributesArr = <AttributesArr>[];
      json['attributes'].forEach((v) {
        attributesArr.add(new AttributesArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['feature_image'] = this.featureImage;
    if (this.attributesArr != null) {
      data['attributes'] =
          this.attributesArr.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributesArr {
  String name;
  String slug;
  String attributeName;
  int id;
  String option;

  AttributesArr({this.name, this.slug, this.attributeName, this.id, this.option});

  AttributesArr.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    attributeName = json['attribute_name'];
    id = json['id'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['attribute_name'] = this.attributeName;
    data['id'] = this.id;
    data['option'] = this.option;
    return data;
  }
}


class Stores {
  int id;
  String name;
  String shopName;
  String url;
  StoreAddress address;

  Stores({this.id, this.name, this.shopName, this.url, this.address});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shopName = json['shop_name'];
    url = json['url'];
    address =
    json['address'].runtimeType != List ? StoreAddress.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shop_name'] = this.shopName;
    data['url'] = this.url;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class StoreAddress {
  String street1;
  String street2;
  String city;
  String zip;
  String state;
  String country;

  StoreAddress(
      {this.street1,
        this.street2,
        this.city,
        this.zip,
        this.state,
        this.country});

  StoreAddress.fromJson(Map<String, dynamic> json) {
    street1 = json['street_1'];
    street2 = json['street_2'];
    city = json['city'];
    zip = json['zip'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street_1'] = this.street1;
    data['street_2'] = this.street2;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}


// class CouponMetaData {
//   List<MetaData> metaData;
//
//   CouponMetaData({this.metaData});
//
//   CouponMetaData.fromJson(Map<String, dynamic> json) {
//     if (json['meta_data'] != null) {
//       metaData = <MetaData>[];
//       json['meta_data'].forEach((v) { metaData.add(new MetaData.fromJson(v)); });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.metaData != null) {
//       data['meta_data'] = this.metaData.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class MetaData {
  int id;
  String key;
  Value value;
  String displayKey;

  MetaData({this.id, this.key, this.value, this.displayKey});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
    displayKey = json['display_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    if (this.value != null) {
      data['value'] = this.value.toJson();
    }
    data['display_key'] = this.displayKey;
    return data;
  }
}

class Value {
  int id;
  String code;
  String amount;
  String status;
  String discountType;
  String description;
  int usageCount;
  bool individualUse;
  List<Null> productIds;
  List<Null> excludedProductIds;
  int usageLimit;
  int usageLimitPerUser;
  Null limitUsageToXItems;
  bool freeShipping;
  List<Null> productCategories;
  List<Null> excludedProductCategories;
  bool excludeSaleItems;
  String minimumAmount;
  String maximumAmount;
  List<Null> emailRestrictions;
  bool virtual;
  List<Null> metaData;
  DateCreated dateCreated;
  DateCreated dateModified;
  DateCreated dateExpires;

  Value({this.id, this.code, this.amount, this.status, this.discountType, this.description, this.usageCount, this.individualUse, this.productIds, this.excludedProductIds, this.usageLimit, this.usageLimitPerUser, this.limitUsageToXItems, this.freeShipping, this.productCategories, this.excludedProductCategories, this.excludeSaleItems, this.minimumAmount, this.maximumAmount, this.emailRestrictions, this.virtual, this.metaData, this.dateExpires, this.dateCreated, this.dateModified});

  Value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    status = json['status'];
    discountType = json['discount_type'];
    description = json['description'];
    usageCount = json['usage_count'];
    individualUse = json['individual_use'];
    usageLimit = json['usage_limit'];
    usageLimitPerUser = json['usage_limit_per_user'];
    limitUsageToXItems = json['limit_usage_to_x_items'];
    freeShipping = json['free_shipping'];
    excludeSaleItems = json['exclude_sale_items'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
    virtual = json['virtual'];
    dateCreated = json['date_created'] != null
        ? new DateCreated.fromJson(json['date_created'])
        : null;
    dateModified = json['date_modified'] != null
        ? new DateCreated.fromJson(json['date_modified'])
        : null;
    dateExpires = json['date_expires'] != null
        ? new DateCreated.fromJson(json['date_expires'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['discount_type'] = this.discountType;
    data['description'] = this.description;
    data['usage_count'] = this.usageCount;
    data['individual_use'] = this.individualUse;
    data['usage_limit'] = this.usageLimit;
    data['usage_limit_per_user'] = this.usageLimitPerUser;
    data['limit_usage_to_x_items'] = this.limitUsageToXItems;
    data['free_shipping'] = this.freeShipping;
    data['exclude_sale_items'] = this.excludeSaleItems;
    data['minimum_amount'] = this.minimumAmount;
    data['maximum_amount'] = this.maximumAmount;
    data['virtual'] = this.virtual;
    if (this.dateCreated != null) {
      data['date_created'] = this.dateCreated.toJson();
    }
    if (this.dateModified != null) {
      data['date_modified'] = this.dateModified.toJson();
    }
    if (this.dateExpires != null) {
      data['date_expires'] = this.dateExpires.toJson();
    }
    return data;
  }
}

class DateCreated {
  String date;
  int timezoneType;
  String timezone;

  DateCreated({this.date, this.timezoneType, this.timezone});

  DateCreated.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}

class WcfmMetaData {
  int id;
  String key;
  String value;
  String displayKey;
  String displayValue;

  WcfmMetaData({this.id, this.key, this.value, this.displayKey, this.displayValue});

  WcfmMetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    displayKey = json['display_key'];
    displayValue = json['display_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    data['display_key'] = this.displayKey;
    data['display_value'] = this.displayValue;
    return data;
  }
}


