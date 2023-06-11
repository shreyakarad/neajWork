import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/profile_model.dart';

class PlaceOrderBody {
  String paymentMethod;
  String paymentMethodTitle;
  bool setPaid;
  int customerId;
  String status;
  String customerNote;
  String transactionId;
  ProfileAddressModel billing;
  ProfileAddressModel shipping;
  List<LineItemsBody> lineItems;
  List<ShippingLinesBody> shippingLines;
  List<CouponLinesBody> couponLines;
  List<FeeLinesBody> feeLines;

  PlaceOrderBody(
      {this.paymentMethod,
        this.paymentMethodTitle,
        this.setPaid,
        this.customerId,
        this.status,
        this.customerNote,
        this.transactionId,
        this.billing,
        this.shipping,
        this.lineItems,
        this.shippingLines,
        this.couponLines,
        this.feeLines});

  PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    setPaid = json['set_paid'];
    customerId = json['customer_id'];
    status = json['status'];
    customerNote = json['customer_note'];
    transactionId = json['transaction_id'];
    billing =
    json['billing'] != null ? new ProfileAddressModel.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null ? new ProfileAddressModel.fromJson(json['shipping']) : null;
    if (json['line_items'] != null) {
      lineItems = <LineItemsBody>[];
      json['line_items'].forEach((v) {
        lineItems.add(new LineItemsBody.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = <ShippingLinesBody>[];
      json['shipping_lines'].forEach((v) {
        shippingLines.add(new ShippingLinesBody.fromJson(v));
      });
    }
    if (json['coupon_lines'] != null) {
      couponLines = <CouponLinesBody>[];
      json['coupon_lines'].forEach((v) {
        couponLines.add(new CouponLinesBody.fromJson(v));
      });
    }
    if (json['fee_lines'] != null) {
      feeLines = <FeeLinesBody>[];
      json['fee_lines'].forEach((v) {
        feeLines.add(new FeeLinesBody.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['set_paid'] = this.setPaid;
    data['customer_id'] = this.customerId;
    data['status'] = this.status;
    data['customer_note'] = this.customerNote;
    data['transaction_id'] = this.transactionId;
    if (this.billing != null) {
      data['billing'] = this.billing.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping.toJson();
    }
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems.map((v) => v.toJson()).toList();
    }
    if (this.shippingLines != null) {
      data['shipping_lines'] =
          this.shippingLines.map((v) => v.toJson()).toList();
    }
    if (this.couponLines != null) {
      data['coupon_lines'] = this.couponLines.map((v) => v.toJson()).toList();
    }
    if (this.feeLines != null) {
      data['fee_lines'] = this.feeLines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItemsBody {
  int productId;
  int variationId;
  int quantity;
  String subtotal;
  String total;

  LineItemsBody(
      {@required this.productId,
        this.variationId,
        @required this.quantity,
        this.subtotal,
        this.total});

  LineItemsBody.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    if(this.variationId != null) {
      data['variation_id'] = this.variationId;
    }
    data['quantity'] = this.quantity;
    if(this.subtotal != null) {
      data['subtotal'] = this.subtotal;
    }
    if(this.total != null) {
      data['total'] = this.total;
    }
    return data;
  }
}

class ShippingLinesBody {
  String methodId;
  String methodTitle;
  String total;
  bool shippingTaxStatus;

  ShippingLinesBody({this.methodId, this.methodTitle, this.total, this.shippingTaxStatus});

  ShippingLinesBody.fromJson(Map<String, dynamic> json) {
    methodId = json['method_id'];
    methodTitle = json['method_title'];
    total = json['total'];
    shippingTaxStatus = json['shipping_tax_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method_id'] = this.methodId;
    data['method_title'] = this.methodTitle;
    data['total'] = this.total;
    data['shipping_tax_status'] = this.shippingTaxStatus;
    return data;
  }
}

class CouponLinesBody {
  String code;

  CouponLinesBody({this.code});

  CouponLinesBody.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}

class FeeLinesBody {
  String name;
  String total;

  FeeLinesBody({this.name, this.total});

  FeeLinesBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total'] = this.total;
    return data;
  }
}