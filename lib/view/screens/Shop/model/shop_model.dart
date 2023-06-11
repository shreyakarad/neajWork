

import 'package:flutter_woocommerce/util/app_constants.dart';

class ShopModel {
  int id;
  String storeName;
  String firstName;
  String lastName;
  String email;
  String phone;
  bool showEmail;
  String address;
  String location;
  String banner;
  int bannerId;
  String gravatar;
  int gravatarId;
  String shopUrl;
  int productsPerPage;
  bool showMoreProductTab;
  bool tocEnabled;
  String storeToc;
  bool featured;
  double rating;
  bool enabled;
  String registered;
  Payment payment;
  bool trusted;
  StoreOpenClose storeOpenClose;
  String adminCommission;
  String adminAdditionalFee;
  String adminCommissionType;

  ShopModel(
      {this.id,
        this.storeName,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.showEmail,
        this.location,
        this.banner,
        this.bannerId,
        this.gravatar,
        this.gravatarId,
        this.shopUrl,
        this.productsPerPage,
        this.showMoreProductTab,
        this.tocEnabled,
        this.storeToc,
        this.featured,
        this.rating,
        this.enabled,
        this.registered,
        this.payment,
        this.trusted,
        this.storeOpenClose,
        this.adminCommission,
        this.adminAdditionalFee,
        this.adminCommissionType});

  ShopModel.fromJson(Map<String, dynamic> json) {
    bool isDokan = AppConstants.vendorType == VendorType.dokan;
    id = isDokan ? json['id'] : json['vendor_id'];
    storeName = isDokan ? json['store_name'] : json['vendor_shop_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    if(isDokan){
      phone = json['phone'];
    } else {
      phone = json['vendor_phone'];
    }
    showEmail = json['show_email'];
    if(isDokan){
      try{
        Address _address = Address.fromJson(json['address']);
        address = '${_address.street1}, ${_address.street2}, ${_address.city}, ${_address.zip}, ${_address.country}';
      }catch(e){
        address = null;
      }
    }else{
      address =  json['vendor_address'];
    }
    location = json['location'];
    banner = isDokan ? json['banner'] : json['vendor_banner'];
    bannerId = json['banner_id'];
    gravatar = isDokan ? json['gravatar'] : json['vendor_shop_logo'];
    gravatarId = json['gravatar_id'];
    shopUrl = json['shop_url'];
    productsPerPage = json['products_per_page'];
    showMoreProductTab = json['show_more_product_tab'];
    tocEnabled = json['toc_enabled'];
    storeToc = json['store_toc'];
    featured = json['featured'];
    rating = isDokan ? json['rating'] != null ? double.parse(Rating.fromJson(json['rating']).rating) : 0.0 : json['store_rating'] == '' ? 0.0 : json['store_rating'];
    enabled = json['enabled'];
    registered = json['registered'];
    //payment = json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    trusted = json['trusted'];
    storeOpenClose = json['store_open_close'] != null
        ?  StoreOpenClose.fromJson(json['store_open_close'])
        : null;
    adminCommission = json['admin_commission'];
    adminAdditionalFee = json['admin_additional_fee'];
    adminCommissionType = json['admin_commission_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['show_email'] = this.showEmail;
    data['location'] = this.location;
    data['banner'] = this.banner;
    data['banner_id'] = this.bannerId;
    data['gravatar'] = this.gravatar;
    data['gravatar_id'] = this.gravatarId;
    data['shop_url'] = this.shopUrl;
    data['products_per_page'] = this.productsPerPage;
    data['show_more_product_tab'] = this.showMoreProductTab;
    data['toc_enabled'] = this.tocEnabled;
    data['store_toc'] = this.storeToc;
    data['featured'] = this.featured;
    // if (this.rating != null) {
    //   data['rating'] = this.rating.toJson();
    // }
    data['enabled'] = this.enabled;
    data['registered'] = this.registered;
    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    data['trusted'] = this.trusted;
    if (this.storeOpenClose != null) {
      data['store_open_close'] = this.storeOpenClose.toJson();
    }
    data['admin_commission'] = this.adminCommission;
    data['admin_additional_fee'] = this.adminAdditionalFee;
    data['admin_commission_type'] = this.adminCommissionType;
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

class Payment {
  List<String> paypal;
  List<String> bank;

  Payment({this.paypal, this.bank});

  Payment.fromJson(Map<String, dynamic> json) {
    paypal = json['paypal'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paypal'] = this.paypal;
    return data;
  }
}

class StoreOpenClose {
  bool enabled;
  String openNotice;
  String closeNotice;

  StoreOpenClose({this.enabled, this.openNotice, this.closeNotice});

  StoreOpenClose.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    openNotice = json['open_notice'];
    closeNotice = json['close_notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    data['open_notice'] = this.openNotice;
    data['close_notice'] = this.closeNotice;
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

class Address {
  String street1;
  String street2;
  String city;
  String zip;
  String state;
  String country;

  Address(
      {this.street1,
        this.street2,
        this.city,
        this.zip,
        this.state,
        this.country});

  Address.fromJson(Map<String, dynamic> json) {
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


//WCFM Shop model

class WcfmShopModel {
  int vendorId;
  String vendorDisplayName;
  String vendorShopName;
  String formattedDisplayName;
  String storeHideEmail;
  String storeHidePhone;
  String storeHideAddress;
  String storeHideDescription;
  String storeHidePolicy;
  int storeProductsPerPage;
  String vendorEmail;
  String vendorPhone;
  String vendorAddress;
  String disableVendor;
  String isStoreOffline;
  String vendorShopLogo;
  String vendorBannerType;
  String vendorBanner;
  String mobileBanner;
  String vendorListBannerType;
  String vendorListBanner;
  var storeRating;
  String emailVerified;
  List<Null> vendorAdditionalInfo;
  String vendorDescription;
  VendorPolicies vendorPolicies;
  StoreTabHeadings storeTabHeadings;

  WcfmShopModel(
      {this.vendorId,
        this.vendorDisplayName,
        this.vendorShopName,
        this.formattedDisplayName,
        this.storeHideEmail,
        this.storeHidePhone,
        this.storeHideAddress,
        this.storeHideDescription,
        this.storeHidePolicy,
        this.storeProductsPerPage,
        this.vendorEmail,
        this.vendorPhone,
        this.vendorAddress,
        this.disableVendor,
        this.isStoreOffline,
        this.vendorShopLogo,
        this.vendorBannerType,
        this.vendorBanner,
        this.mobileBanner,
        this.vendorListBannerType,
        this.vendorListBanner,
        this.storeRating,
        this.emailVerified,
        this.vendorAdditionalInfo,
        this.vendorDescription,
        this.vendorPolicies,
        this.storeTabHeadings});

  WcfmShopModel.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    vendorDisplayName = json['vendor_display_name'];
    vendorShopName = json['vendor_shop_name'];
    formattedDisplayName = json['formatted_display_name'];
    storeHideEmail = json['store_hide_email'];
    storeHidePhone = json['store_hide_phone'];
    storeHideAddress = json['store_hide_address'];
    storeHideDescription = json['store_hide_description'];
    storeHidePolicy = json['store_hide_policy'];
    storeProductsPerPage = json['store_products_per_page'];
    vendorEmail = json['vendor_email'];
    vendorPhone = json['vendor_phone'];
    vendorAddress = json['vendor_address'];
    disableVendor = json['disable_vendor'];
    isStoreOffline = json['is_store_offline'];
    vendorShopLogo = json['vendor_shop_logo'];
    vendorBannerType = json['vendor_banner_type'];
    vendorBanner = json['vendor_banner'];
    mobileBanner = json['mobile_banner'];
    vendorListBannerType = json['vendor_list_banner_type'];
    vendorListBanner = json['vendor_list_banner'];
    storeRating = json['store_rating'];
    emailVerified = json['email_verified'];
    if (json['vendor_additional_info'] != null) {
      vendorAdditionalInfo = <Null>[];
      json['vendor_additional_info'].forEach((v) {
        //vendorAdditionalInfo!.add(new Null.fromJson(v));
      });
    }
    vendorDescription = json['vendor_description'];
    vendorPolicies = json['vendor_policies'] != null
        ? new VendorPolicies.fromJson(json['vendor_policies'])
        : null;
    storeTabHeadings = json['store_tab_headings'] != null
        ? new StoreTabHeadings.fromJson(json['store_tab_headings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['vendor_display_name'] = this.vendorDisplayName;
    data['vendor_shop_name'] = this.vendorShopName;
    data['formatted_display_name'] = this.formattedDisplayName;
    data['store_hide_email'] = this.storeHideEmail;
    data['store_hide_phone'] = this.storeHidePhone;
    data['store_hide_address'] = this.storeHideAddress;
    data['store_hide_description'] = this.storeHideDescription;
    data['store_hide_policy'] = this.storeHidePolicy;
    data['store_products_per_page'] = this.storeProductsPerPage;
    data['vendor_email'] = this.vendorEmail;
    data['vendor_phone'] = this.vendorPhone;
    data['vendor_address'] = this.vendorAddress;
    data['disable_vendor'] = this.disableVendor;
    data['is_store_offline'] = this.isStoreOffline;
    data['vendor_shop_logo'] = this.vendorShopLogo;
    data['vendor_banner_type'] = this.vendorBannerType;
    data['vendor_banner'] = this.vendorBanner;
    data['mobile_banner'] = this.mobileBanner;
    data['vendor_list_banner_type'] = this.vendorListBannerType;
    data['vendor_list_banner'] = this.vendorListBanner;
    data['store_rating'] = this.storeRating;
    data['email_verified'] = this.emailVerified;
    if (this.vendorAdditionalInfo != null) {
      //data['vendor_additional_info'] = this.vendorAdditionalInfo!.map((v) => v.toJson()).toList();
    }
    data['vendor_description'] = this.vendorDescription;
    if (this.vendorPolicies != null) {
      data['vendor_policies'] = this.vendorPolicies.toJson();
    }
    if (this.storeTabHeadings != null) {
      data['store_tab_headings'] = this.storeTabHeadings.toJson();
    }
    return data;
  }
}

class VendorPolicies {
  String shippingPolicyHeading;
  String shippingPolicy;
  String refundPolicyHeading;
  String refundPolicy;
  String cancellationPolicyHeading;
  String cancellationPolicy;

  VendorPolicies(
      {this.shippingPolicyHeading,
        this.shippingPolicy,
        this.refundPolicyHeading,
        this.refundPolicy,
        this.cancellationPolicyHeading,
        this.cancellationPolicy});

  VendorPolicies.fromJson(Map<String, dynamic> json) {
    shippingPolicyHeading = json['shipping_policy_heading'];
    shippingPolicy = json['shipping_policy'];
    refundPolicyHeading = json['refund_policy_heading'];
    refundPolicy = json['refund_policy'];
    cancellationPolicyHeading = json['cancellation_policy_heading'];
    cancellationPolicy = json['cancellation_policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipping_policy_heading'] = this.shippingPolicyHeading;
    data['shipping_policy'] = this.shippingPolicy;
    data['refund_policy_heading'] = this.refundPolicyHeading;
    data['refund_policy'] = this.refundPolicy;
    data['cancellation_policy_heading'] = this.cancellationPolicyHeading;
    data['cancellation_policy'] = this.cancellationPolicy;
    return data;
  }
}

class StoreTabHeadings {
  String products;
  String about;
  String policies;
  String reviews;

  StoreTabHeadings({this.products, this.about, this.policies, this.reviews});

  StoreTabHeadings.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    about = json['about'];
    policies = json['policies'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products'] = this.products;
    data['about'] = this.about;
    data['policies'] = this.policies;
    data['reviews'] = this.reviews;
    return data;
  }
}
