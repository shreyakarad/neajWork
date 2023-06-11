class ConfigModel {
  String businessName;
  String logo;
  String address;
  String phone;
  String email;
  String country;
  String currencySymbol;
  String termsAndConditions;
  String privacyPolicy;
  String aboutUs;
  String currencySymbolDirection;
  double appMinimumVersionAndroid;
  String appUrlAndroid;
  double appMinimumVersionIos;
  String appUrlIos;
  bool maintenanceMode;
  String timeformat;
  int digitAfterDecimalPoint;
  double flatRate;
  double freeShipping;
  double localPickup;
  bool cashOnDelivery;
  bool digitalPayment;

  ConfigModel(
      {this.businessName,
        this.logo,
        this.address,
        this.phone,
        this.email,
        this.country,
        this.currencySymbol,
        this.termsAndConditions,
        this.privacyPolicy,
        this.aboutUs,
        this.currencySymbolDirection,
        this.appMinimumVersionAndroid,
        this.appUrlAndroid,
        this.appMinimumVersionIos,
        this.appUrlIos,
        this.maintenanceMode,
        this.timeformat,
        this.digitAfterDecimalPoint,
        this.flatRate,
        this.freeShipping,
        this.localPickup,
        this.cashOnDelivery,
        this.digitalPayment,
      });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    logo = json['logo'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    country = json['country'];
    currencySymbol = json['currency_symbol'];
    termsAndConditions = json['terms_and_conditions'];
    privacyPolicy = json['privacy_policy'];
    aboutUs = json['about_us'];
    currencySymbolDirection = json['currency_symbol_direction'];
    appMinimumVersionAndroid = json['app_minimum_version_android'].toDouble();
    appUrlAndroid = json['app_url_android'];
    appMinimumVersionIos = json['app_minimum_version_ios'].toDouble();
    appUrlIos = json['app_url_ios'];
    maintenanceMode = json['maintenance_mode'];
    timeformat = json['timeformat'];
    digitAfterDecimalPoint = json['digit_after_decimal_point'];
    flatRate = json['flat_rate'];
    freeShipping = json['free_shipping'];
    localPickup = json['local_pickup'];
    cashOnDelivery = json['cash_on_delivery'];
    digitalPayment = json['digital_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    data['logo'] = this.logo;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['country'] = this.country;
    data['currency_symbol'] = this.currencySymbol;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['privacy_policy'] = this.privacyPolicy;
    data['about_us'] = this.aboutUs;
    data['currency_symbol_direction'] = this.currencySymbolDirection;
    data['app_minimum_version_android'] = this.appMinimumVersionAndroid;
    data['app_url_android'] = this.appUrlAndroid;
    data['app_minimum_version_ios'] = this.appMinimumVersionIos;
    data['app_url_ios'] = this.appUrlIos;
    data['maintenance_mode'] = this.maintenanceMode;
    data['timeformat'] = this.timeformat;
    data['digit_after_decimal_point'] = this.digitAfterDecimalPoint;
    data['flat_rate'] = this.flatRate;
    data['free_shipping'] = this.freeShipping;
    data['local_pickup'] = this.localPickup;
    data['cash_on_delivery'] = this.cashOnDelivery;
    data['digital_payment'] = this.digitalPayment;
    return data;
  }
}




