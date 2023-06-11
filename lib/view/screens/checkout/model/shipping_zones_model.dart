class ShippingZonesModel {
  int id;
  String name;
  List<ShippingMethods> methods;

  ShippingZonesModel({this.id, this.name, this.methods});

  ShippingZonesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['methods'] != null) {
      methods = <ShippingMethods>[];
      json['methods'].forEach((v) {
        methods.add(new ShippingMethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.methods != null) {
      data['methods'] = this.methods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingMethods {
  int id;
  String title;
  String cost;
  bool enabled;
  bool taxable;
  String methodId;
  String methodTitle;
  String methodDescription;
  Requires requires;

  ShippingMethods(
      {this.id,
        this.title,
        this.cost,
        this.enabled,
        this.taxable,
        this.methodId,
        this.methodTitle,
        this.methodDescription,
        this.requires});

  ShippingMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cost = json['cost'];
    enabled = json['enabled'];
    taxable = json['taxable'];
    methodId = json['method_id'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
    requires = json['requires'] != null
        ? new Requires.fromJson(json['requires'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cost'] = this.cost;
    data['enabled'] = this.enabled;
    data['taxable'] = this.taxable;
    data['method_id'] = this.methodId;
    data['method_title'] = this.methodTitle;
    data['method_description'] = this.methodDescription;
    if (this.requires != null) {
      data['requires'] = this.requires.toJson();
    }
    return data;
  }
}

class Requires {
  String label;
  String value;
  Options options;
  String couponsDiscounts;
  String either;

  Requires(
      {this.label,
        this.value,
        this.options,
        this.couponsDiscounts,
        this.either});

  Requires.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    options =
    json['options'] != null ? new Options.fromJson(json['options']) : null;
    couponsDiscounts = json['coupons_discounts'];
    either = json['either'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    if (this.options != null) {
      data['options'] = this.options.toJson();
    }
    data['coupons_discounts'] = this.couponsDiscounts;
    data['either'] = this.either;
    return data;
  }
}

class Options {
  String coupon;
  String minAmount;
  String either;
  String both;

  Options({this.coupon, this.minAmount, this.either, this.both});

  Options.fromJson(Map<String, dynamic> json) {
    coupon = json['coupon'];
    minAmount = json['min_amount'];
    either = json['either'];
    both = json['both'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon'] = this.coupon;
    data['min_amount'] = this.minAmount;
    data['either'] = this.either;
    data['both'] = this.both;
    return data;
  }
}


// class ShippingZonesModel {
//   ShippingZonesModel({
//     this.id,
//     this.name,
//     this.methods,
//   });
//
//   int id;
//   String name;
//   List<Method> methods;
// }
//
//
//
// class Method {
//   Method({
//     this.id,
//     this.title,
//     this.cost,
//     this.enabled,
//     this.taxable,
//     this.methodId,
//     this.methodTitle,
//     this.methodDescription,
//     this.requires,
//   });
//
//   int id;
//   String title;
//   String cost;
//   bool enabled;
//   bool taxable;
//   String methodId;
//   String methodTitle;
//   String methodDescription;
//   Requires requires;
// }
//
// class Requires {
//   Requires({
//     this.label,
//     this.value,
//     this.options,
//     this.couponsDiscounts,
//     this.either,
//   });
//
//   String label;
//   String value;
//   Options options;
//   String couponsDiscounts;
//   String either;
// }
//
// class Options {
//   Options({
//     this.empty,
//     this.coupon,
//     this.minAmount,
//     this.either,
//     this.both,
//   });
//
//   String empty;
//   String coupon;
//   String minAmount;
//   String either;
//   String both;
// }

















// class ShippingZonesModel {
//   int id;
//   String name;
//   int order;
//
//   ShippingZonesModel({this.id, this.name, this.order});
//
//   ShippingZonesModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     order = json['order'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['order'] = this.order;
//     return data;
//   }
// }