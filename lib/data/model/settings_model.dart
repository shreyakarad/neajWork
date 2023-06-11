
class SettingsModel {
  GeneralSettings generalSettings;
  TaxSettings taxSettings;
  ProductSettings productSettings;
  ShippingSettings shippingSettings;
  AccountSettings accountSettings;
  ActivityMessages activityMessages;
  AppSettings appSettings;
  BusinessSettings businessSettings;
  PaymentSettings paymentSettings;

  SettingsModel({this.generalSettings, this.taxSettings, this.productSettings, this.shippingSettings, this.accountSettings, this.activityMessages, this.appSettings, this.businessSettings, this.paymentSettings});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    generalSettings = json['general_settings'] != null ? new GeneralSettings.fromJson(json['general_settings']) : null;
    taxSettings = json['tax_settings'] != null ? new TaxSettings.fromJson(json['tax_settings']) : null;
    productSettings = json['product_settings'] != null ? new ProductSettings.fromJson(json['product_settings']) : null;
    shippingSettings = json['shipping_settings'] != null ? new ShippingSettings.fromJson(json['shipping_settings']) : null;
    accountSettings = json['account_settings'] != null ? new AccountSettings.fromJson(json['account_settings']) : null;
    activityMessages = activityMessages = json['activity_messages'] != null ? new ActivityMessages.fromJson(json['activity_messages']) : null;
    if(json['app_settings'].toString() == '[]'){
      appSettings = null;
      print('jibon_bche_gesa');
    } else {
      appSettings = AppSettings.fromJson(json['app_settings']);
    }
    // appSettings = json['app_settings'] != null ? new AppSettings.fromJson(json['app_settings']) : null;
    businessSettings = json['business_settings'] != null ? new BusinessSettings.fromJson(json['business_settings']) : null;
    paymentSettings = json['payment_settings'] != null ? new PaymentSettings.fromJson(json['payment_settings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generalSettings != null) {
      data['general_settings'] = this.generalSettings.toJson();
    }
    if (this.taxSettings != null) {
      data['tax_settings'] = this.taxSettings.toJson();
    }
    if (this.productSettings != null) {
      data['product_settings'] = this.productSettings.toJson();
    }
    if (this.shippingSettings != null) {
      data['shipping_settings'] = this.shippingSettings.toJson();
    }
    if (this.accountSettings != null) {
      data['account_settings'] = this.accountSettings.toJson();
    }

    return data;
  }
}

class GeneralSettings {
  String storeAddress;
  String storeAddress2;
  String storeCity;
  String storeCountry;
  String storeState;
  String storePostcode;
  WoocommerceCalcTaxes woocommerceCalcTaxes;
  WoocommerceCalcTaxes woocommerceEnableCoupons;
  DefaultCountry defaultCountry;
  WoocommerceCurrency woocommerceCurrency;
  WoocommerceCurrencyPos woocommerceCurrencyPos;
  WoocommercePriceThousandSep woocommercePriceThousandSep;
  WoocommercePriceThousandSep woocommercePriceNumDecimals;

  GeneralSettings({this.storeAddress, this.storeAddress2, this.storeCity, this.storeCountry, this.storeState, this.storePostcode, this.woocommerceCalcTaxes, this.woocommerceEnableCoupons, this.defaultCountry, this.woocommerceCurrency, this.woocommerceCurrencyPos, this.woocommercePriceThousandSep, this.woocommercePriceNumDecimals});

  GeneralSettings.fromJson(Map<String, dynamic> json) {
    storeAddress = json['store_address'];
    storeAddress2 = json['store_address_2'];
    storeCity = json['store_city'];
    storeCountry = json['store_country'];
    storeState = json['store_state'];
    storePostcode = json['store_postcode'];
    woocommerceCalcTaxes = json['woocommerce_calc_taxes'] != null ? new WoocommerceCalcTaxes.fromJson(json['woocommerce_calc_taxes']) : null;
    woocommerceEnableCoupons = json['woocommerce_enable_coupons'] != null ? new WoocommerceCalcTaxes.fromJson(json['woocommerce_enable_coupons']) : null;
    defaultCountry = json['default_country'] != null ? new DefaultCountry.fromJson(json['default_country']) : null;
    woocommerceCurrency = json['woocommerce_currency'] != null ? new WoocommerceCurrency.fromJson(json['woocommerce_currency']) : null;
    woocommerceCurrencyPos = json['woocommerce_currency_pos'] != null ? new WoocommerceCurrencyPos.fromJson(json['woocommerce_currency_pos']) : null;
    woocommercePriceThousandSep = json['woocommerce_price_thousand_sep'] != null ? new WoocommercePriceThousandSep.fromJson(json['woocommerce_price_thousand_sep']) : null;
    woocommercePriceNumDecimals = json['woocommerce_price_num_decimals'] != null ? new WoocommercePriceThousandSep.fromJson(json['woocommerce_price_num_decimals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_address'] = this.storeAddress;
    data['store_address_2'] = this.storeAddress2;
    data['store_city'] = this.storeCity;
    data['store_country'] = this.storeCountry;
    data['store_state'] = this.storeState;
    data['store_postcode'] = this.storePostcode;
    if (this.woocommerceCalcTaxes != null) {
      data['woocommerce_calc_taxes'] = this.woocommerceCalcTaxes.toJson();
    }
    if (this.woocommerceEnableCoupons != null) {
      data['woocommerce_enable_coupons'] = this.woocommerceEnableCoupons.toJson();
    }
    if (this.defaultCountry != null) {
      data['default_country'] = this.defaultCountry.toJson();
    }
    if (this.woocommerceCurrency != null) {
      data['woocommerce_currency'] = this.woocommerceCurrency.toJson();
    }
    if (this.woocommerceCurrencyPos != null) {
      data['woocommerce_currency_pos'] = this.woocommerceCurrencyPos.toJson();
    }
    if (this.woocommercePriceThousandSep != null) {
      data['woocommerce_price_thousand_sep'] = this.woocommercePriceThousandSep.toJson();
    }
    if (this.woocommercePriceNumDecimals != null) {
      data['woocommerce_price_num_decimals'] = this.woocommercePriceNumDecimals.toJson();
    }
    return data;
  }
}

class WoocommerceCalcTaxes {
  String id;
  String label;
  String value;

  WoocommerceCalcTaxes({this.id, this.label, this.value});

  WoocommerceCalcTaxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class DefaultCountry {
  String id;
  String label;
  String value;

  DefaultCountry({this.id, this.label, this.value});

  DefaultCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class WoocommerceCurrency {
  String id;
  String label;
  String defaultC;
  String value;

  WoocommerceCurrency({this.id, this.label, this.defaultC, this.value, });

  WoocommerceCurrency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    defaultC = json['default'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['default'] = this.defaultC;
    data['value'] = this.value;
    return data;
  }
}

class WoocommerceCurrencyPos {
  String id;
  String label;
  String defaultPos;
  String value;
  CurrencyPositionOptions options;

  WoocommerceCurrencyPos({this.id, this.label, this.defaultPos, this.value, this.options});

  WoocommerceCurrencyPos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    defaultPos = json['default'];
    value = json['value'];
    options = json['options'] != null ? new CurrencyPositionOptions.fromJson(json['options']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['default'] = this.defaultPos;
    data['value'] = this.value;
    if (this.options != null) {
      data['options'] = this.options.toJson();
    }
    return data;
  }
}

class CurrencyPositionOptions {
  String left;
  String right;
  String leftSpace;
  String rightSpace;

  CurrencyPositionOptions({this.left, this.right, this.leftSpace, this.rightSpace});

  CurrencyPositionOptions.fromJson(Map<String, dynamic> json) {
    left = json['left'];
    right = json['right'];
    leftSpace = json['left_space'];
    rightSpace = json['right_space'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['left'] = this.left;
    data['right'] = this.right;
    data['left_space'] = this.leftSpace;
    data['right_space'] = this.rightSpace;
    return data;
  }
}

class WoocommercePriceThousandSep {
  String id;
  String label;
  String defaultValue;
  String value;

  WoocommercePriceThousandSep({this.id, this.label, this.defaultValue, this.value});

  WoocommercePriceThousandSep.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    defaultValue = json['default'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['default'] = this.defaultValue;
    data['value'] = this.value;
    return data;
  }
}

class TaxSettings {
  List<String> woocommerceTaxClasses;
  String woocommerceTaxBasedOn;
  String woocommercePricesIncludeTax;
  String woocommerceTaxRoundAtSubtotal;
  String woocommerceTaxDisplayCart;
  String woocommerceTaxTotalDisplay;
  String woocommerceShippingTaxClass;
  String woocommerceTaxDisplayShop;
  List<Null> taxRates;

  TaxSettings({this.woocommerceTaxClasses, this.woocommerceTaxBasedOn, this.woocommercePricesIncludeTax, this.woocommerceTaxRoundAtSubtotal, this.woocommerceTaxDisplayCart, this.woocommerceTaxTotalDisplay, this.woocommerceShippingTaxClass, this.woocommerceTaxDisplayShop, this.taxRates});

  TaxSettings.fromJson(Map<String, dynamic> json) {
    woocommerceTaxClasses = json['woocommerce_tax_classes'].cast<String>();
    woocommerceTaxBasedOn = json['woocommerce_tax_based_on'];
    woocommercePricesIncludeTax = json['woocommerce_prices_include_tax'];
    woocommerceTaxRoundAtSubtotal = json['woocommerce_tax_round_at_subtotal'];
    woocommerceTaxDisplayCart = json['woocommerce_tax_display_cart'];
    woocommerceTaxTotalDisplay = json['woocommerce_tax_total_display'];
    woocommerceShippingTaxClass = json['woocommerce_shipping_tax_class'];
    woocommerceTaxDisplayShop = json['woocommerce_tax_display_shop'];
    if (json['tax_rates'] != null) {
      taxRates = <Null>[];
      // json['tax_rates'].forEach((v) { taxRates.add(new Null); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['woocommerce_tax_classes'] = this.woocommerceTaxClasses;
    data['woocommerce_tax_based_on'] = this.woocommerceTaxBasedOn;
    data['woocommerce_prices_include_tax'] = this.woocommercePricesIncludeTax;
    data['woocommerce_tax_round_at_subtotal'] = this.woocommerceTaxRoundAtSubtotal;
    data['woocommerce_tax_display_cart'] = this.woocommerceTaxDisplayCart;
    data['woocommerce_tax_total_display'] = this.woocommerceTaxTotalDisplay;
    data['woocommerce_shipping_tax_class'] = this.woocommerceShippingTaxClass;
    data['woocommerce_tax_display_shop'] = this.woocommerceTaxDisplayShop;
    if (this.taxRates != null) {
      //data['tax_rates'] = this.taxRates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductSettings {
  String woocommerceEnableReviews;
  String woocommerceEnableReviewRating;
  String woocommerceManageStock;
  String woocommerceHideOutOfStockItems;

  ProductSettings({this.woocommerceEnableReviews, this.woocommerceEnableReviewRating, this.woocommerceManageStock, this.woocommerceHideOutOfStockItems});

  ProductSettings.fromJson(Map<String, dynamic> json) {
    woocommerceEnableReviews = json['Woocommerce_enable_reviews'];
    woocommerceEnableReviewRating = json['Woocommerce_enable_review_rating'];
    woocommerceManageStock = json['Woocommerce_manage_stock'];
    woocommerceHideOutOfStockItems = json['Woocommerce_hide_out_of_stock_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Woocommerce_enable_reviews'] = this.woocommerceEnableReviews;
    data['Woocommerce_enable_review_rating'] = this.woocommerceEnableReviewRating;
    data['Woocommerce_manage_stock'] = this.woocommerceManageStock;
    data['Woocommerce_hide_out_of_stock_items'] = this.woocommerceHideOutOfStockItems;
    return data;
  }
}

class ShippingSettings {
  String woocommerceEnableShippingCalc;
  String woocommerceShippingCostRequiresAddress;
  String woocommerceShipToDestination;

  ShippingSettings({this.woocommerceEnableShippingCalc, this.woocommerceShippingCostRequiresAddress, this.woocommerceShipToDestination});

  ShippingSettings.fromJson(Map<String, dynamic> json) {
    woocommerceEnableShippingCalc = json['woocommerce_enable_shipping_calc'];
    woocommerceShippingCostRequiresAddress = json['woocommerce_shipping_cost_requires_address'];
    woocommerceShipToDestination = json['woocommerce_ship_to_destination'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['woocommerce_enable_shipping_calc'] = this.woocommerceEnableShippingCalc;
    data['woocommerce_shipping_cost_requires_address'] = this.woocommerceShippingCostRequiresAddress;
    data['woocommerce_ship_to_destination'] = this.woocommerceShipToDestination;
    return data;
  }
}

class AccountSettings {
  String woocommerceEnableGuestCheckout;
  String woocommerceEnableCheckoutLoginReminder;
  String woocommerceEnableSignupAndLoginFromCheckout;
  String woocommerceEnableMyaccountRegistration;
  String woocommerceRegistrationGenerateUsername;
  String woocommerceRegistrationGeneratePassword;
  String woocommerceErasureRequestRemovesOrderData;
  String woocommerceAllowBulkRemovePersonalData;
  String woocommerceRegistrationPrivacyPolicyText;
  String woocommerceCheckoutPrivacyPolicyText;

  AccountSettings({this.woocommerceEnableGuestCheckout, this.woocommerceEnableCheckoutLoginReminder, this.woocommerceEnableSignupAndLoginFromCheckout, this.woocommerceEnableMyaccountRegistration, this.woocommerceRegistrationGenerateUsername, this.woocommerceRegistrationGeneratePassword, this.woocommerceErasureRequestRemovesOrderData, this.woocommerceAllowBulkRemovePersonalData, this.woocommerceRegistrationPrivacyPolicyText, this.woocommerceCheckoutPrivacyPolicyText});

  AccountSettings.fromJson(Map<String, dynamic> json) {
    woocommerceEnableGuestCheckout = json['woocommerce_enable_guest_checkout'];
    woocommerceEnableCheckoutLoginReminder = json['woocommerce_enable_checkout_login_reminder'];
    woocommerceEnableSignupAndLoginFromCheckout = json['woocommerce_enable_signup_and_login_from_checkout'];
    woocommerceEnableMyaccountRegistration = json['woocommerce_enable_myaccount_registration'];
    woocommerceRegistrationGenerateUsername = json['woocommerce_registration_generate_username'];
    woocommerceRegistrationGeneratePassword = json['woocommerce_registration_generate_password'];
    woocommerceErasureRequestRemovesOrderData = json['woocommerce_erasure_request_removes_order_data'];
    woocommerceAllowBulkRemovePersonalData = json['woocommerce_allow_bulk_remove_personal_data'];
    woocommerceRegistrationPrivacyPolicyText = json['woocommerce_registration_privacy_policy_text'];
    woocommerceCheckoutPrivacyPolicyText = json['woocommerce_checkout_privacy_policy_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['woocommerce_enable_guest_checkout'] = this.woocommerceEnableGuestCheckout;
    data['woocommerce_enable_checkout_login_reminder'] = this.woocommerceEnableCheckoutLoginReminder;
    data['woocommerce_enable_signup_and_login_from_checkout'] = this.woocommerceEnableSignupAndLoginFromCheckout;
    data['woocommerce_enable_myaccount_registration'] = this.woocommerceEnableMyaccountRegistration;
    data['woocommerce_registration_generate_username'] = this.woocommerceRegistrationGenerateUsername;
    data['woocommerce_registration_generate_password'] = this.woocommerceRegistrationGeneratePassword;
    data['woocommerce_erasure_request_removes_order_data'] = this.woocommerceErasureRequestRemovesOrderData;
    data['woocommerce_allow_bulk_remove_personal_data'] = this.woocommerceAllowBulkRemovePersonalData;
    data['woocommerce_registration_privacy_policy_text'] = this.woocommerceRegistrationPrivacyPolicyText;
    data['woocommerce_checkout_privacy_policy_text'] = this.woocommerceCheckoutPrivacyPolicyText;
    return data;
  }
}

class ActivityMessages {
  Completed completed;
  Completed failed;
  Completed onHold;
  Completed processing;
  Completed refunded;
  Completed cancelled;
  Completed pending;
  String lastUpdated;

  ActivityMessages(
      {this.completed,
        this.failed,
        this.onHold,
        this.processing,
        this.refunded,
        this.cancelled,
        this.pending,
        this.lastUpdated});

  ActivityMessages.fromJson(Map<String, dynamic> json) {
    completed = json['completed'] != null
        ? new Completed.fromJson(json['completed'])
        : null;
    failed =
    json['failed'] != null ? new Completed.fromJson(json['failed']) : null;
    onHold = json['on_hold'] != null
        ? new Completed.fromJson(json['on_hold'])
        : null;
    processing = json['processing'] != null
        ? new Completed.fromJson(json['processing'])
        : null;
    refunded = json['refunded'] != null
        ? new Completed.fromJson(json['refunded'])
        : null;
    cancelled = json['cancelled'] != null
        ? new Completed.fromJson(json['cancelled'])
        : null;
    pending = json['pending'] != null
        ? new Completed.fromJson(json['pending'])
        : null;
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.completed != null) {
      data['completed'] = this.completed.toJson();
    }
    if (this.failed != null) {
      data['failed'] = this.failed.toJson();
    }
    if (this.onHold != null) {
      data['on_hold'] = this.onHold.toJson();
    }
    if (this.processing != null) {
      data['processing'] = this.processing.toJson();
    }
    if (this.refunded != null) {
      data['refunded'] = this.refunded.toJson();
    }
    if (this.cancelled != null) {
      data['cancelled'] = this.cancelled.toJson();
    }
    if (this.pending != null) {
      data['pending'] = this.pending.toJson();
    }
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}

class Completed {
  String title;
  String message;

  Completed({this.title, this.message});

  Completed.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}




class AppSettings {
  AppleStore appleStore;
  AppleStore googleStore;

  AppSettings({this.appleStore, this.googleStore});

  AppSettings.fromJson(Map<String, dynamic> json) {
    appleStore = json['apple-store'] != null
        ? new AppleStore.fromJson(json['apple-store'])
        : null;
    googleStore = json['google-store'] != null
        ? new AppleStore.fromJson(json['google-store'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appleStore != null) {
      data['apple-store'] = this.appleStore.toJson();
    }
    if (this.googleStore != null) {
      data['google-store'] = this.googleStore.toJson();
    }
    return data;
  }
}

class AppleStore {
  String name;
  String link;
  int minimumVersion;
  int status;
  String lastUpdated;

  AppleStore(
      {this.name,
        this.link,
        this.minimumVersion,
        this.status,
        this.lastUpdated});

  AppleStore.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
    minimumVersion = json['minimum_version'];
    status = json['status'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['link'] = this.link;
    data['minimum_version'] = this.minimumVersion;
    data['status'] = this.status;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}


class BusinessSettings {
  String name;
  String phone;
  String email;
  String address;
  int maintenanceMode;
  String lastUpdated;

  BusinessSettings(
      {this.name,
        this.phone,
        this.email,
        this.address,
        this.maintenanceMode,
        this.lastUpdated});

  BusinessSettings.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    maintenanceMode = json['maintenance_mode'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['maintenance_mode'] = this.maintenanceMode;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}


class PaymentSettings {
  int codStatus;
  int digitalPaymentStatus;
  Paypal paypal;
  Stripe stripe;
  RazorPay razorPay;
  Paystack paystack;
  Flutterwave flutterwave;

  PaymentSettings(
      {this.codStatus,
        this.digitalPaymentStatus,
        this.paypal,
        this.stripe,
        this.razorPay,
        this.paystack,
        this.flutterwave});

  PaymentSettings.fromJson(Map<String, dynamic> json) {
    codStatus = json['cod_status'];
    digitalPaymentStatus = json['digital_payment_status'];
    paypal =
    json['paypal'] != null ? new Paypal.fromJson(json['paypal']) : null;
    stripe =
    json['stripe'] != null ? new Stripe.fromJson(json['stripe']) : null;
    razorPay = json['razor_pay'] != null
        ? new RazorPay.fromJson(json['razor_pay'])
        : null;
    paystack = json['paystack'] != null
        ? new Paystack.fromJson(json['paystack'])
        : null;
    flutterwave = json['flutterwave'] != null
        ? new Flutterwave.fromJson(json['flutterwave'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod_status'] = this.codStatus;
    data['digital_payment_status'] = this.digitalPaymentStatus;
    if (this.paypal != null) {
      data['paypal'] = this.paypal.toJson();
    }
    if (this.stripe != null) {
      data['stripe'] = this.stripe.toJson();
    }
    if (this.razorPay != null) {
      data['razor_pay'] = this.razorPay.toJson();
    }
    if (this.paystack != null) {
      data['paystack'] = this.paystack.toJson();
    }
    if (this.flutterwave != null) {
      data['flutterwave'] = this.flutterwave.toJson();
    }
    return data;
  }
}

class Paypal {
  String title;
  int status;
  String clientId;
  String secretKey;

  Paypal({this.title, this.status, this.clientId, this.secretKey});

  Paypal.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    clientId = json['clientId'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['status'] = this.status;
    data['clientId'] = this.clientId;
    data['secretKey'] = this.secretKey;
    return data;
  }
}

class Stripe {
  String title;
  int status;
  String secretKey;
  String publishableKey;

  Stripe({this.title, this.status, this.secretKey, this.publishableKey});

  Stripe.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    secretKey = json['secretKey'];
    publishableKey = json['publishableKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['status'] = this.status;
    data['secretKey'] = this.secretKey;
    data['publishableKey'] = this.publishableKey;
    return data;
  }
}

class RazorPay {
  String title;
  int status;
  String keyId;
  String secretKey;

  RazorPay({this.title, this.status, this.keyId, this.secretKey});

  RazorPay.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    keyId = json['keyId'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['status'] = this.status;
    data['keyId'] = this.keyId;
    data['secretKey'] = this.secretKey;
    return data;
  }
}

class Paystack {
  String title;
  int status;
  String publicKey;
  String secretKey;

  Paystack({this.title, this.status, this.publicKey, this.secretKey});

  Paystack.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    // status = json['status'] != null ? json['status'] : null;
    if(json['status'].toString() == ''){
      status = null;
    } else {
      status = json['status'];
    }
    publicKey = json['publicKey'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['status'] = this.status;
    data['publicKey'] = this.publicKey;
    data['secretKey'] = this.secretKey;
    return data;
  }
}

class Flutterwave {
  String title;
  int status;
  String publicKey;
  String secretKey;
  String encryptionKey;

  Flutterwave(
      {this.title,
        this.status,
        this.publicKey,
        this.secretKey,
        this.encryptionKey});

  Flutterwave.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    publicKey = json['publicKey'];
    secretKey = json['secretKey'];
    encryptionKey = json['encryptionKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['status'] = this.status;
    data['publicKey'] = this.publicKey;
    data['secretKey'] = this.secretKey;
    data['encryptionKey'] = this.encryptionKey;
    return data;
  }
}




// class SettingsModel {
//   String id;
//   String label;
//   String description;
//   String type;
//   String tip;
//   dynamic value;
//   Map<String, dynamic> options;
//
//   SettingsModel({this.id, this.label, this.description, this.type, this.tip, this.value, this.options});
//
//   SettingsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     label = json['label'];
//     description = json['description'];
//     type = json['type'];
//     tip = json['tip'];
//     value = json['value'];
//     options = json['options'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['label'] = this.label;
//     data['description'] = this.description;
//     data['type'] = this.type;
//     data['tip'] = this.tip;
//     data['value'] = this.value;
//     data['options'] = this.options;
//     return data;
//   }
// }
