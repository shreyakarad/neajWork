import 'package:flutter_woocommerce/data/model/language_model.dart';
import 'package:flutter_woocommerce/data/model/payment_model.dart';
import 'package:flutter_woocommerce/util/images.dart';

class AppConstants {
  static VendorType vendorType = VendorType.singleVendor;
  static bool isCountryFixed = false;
  static const String APP_NAME = 'WooMond';
  static const double APP_VERSION = 2.0;
  static const String APP_PACKAGE_NAME = 'com.sixamtech.flutter_woocommerce';
  static const String PAGINATION_LIMIT = '10';
  static const String DOKAN_ADMIN_STORE_NAME = 'WooMond Mall';

  // static const String BASE_URL = 'https://wp.6amtech.com/woomond1';
  static const String BASE_URL = 'https://newness.net/';
  static const String CONSUMER_KEY =
      'ck_5c9b60936c9b52a04d99cb2fbe2667ae5a1ba2fb';
  static const String CUSTOMER_SECRET =
      'cs_09bd4a2dfe2ac2f34b9895a61a3a92ecd054440a';

  /// Translations
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];

  /// Payment Info
  static List<PaymentModel> payments = [
    PaymentModel(
      paymentType: PaymentType.cod,
      icon: Images.cod,
      title: 'cod',
      description: 'cash_on_delivery',
    ),
    PaymentModel(
      paymentType: PaymentType.paypal,
      icon: Images.paypal,
      title: 'PayPal',
      description: 'pay_via_paypal',
      clientId:
          'AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0',
      secretKey:
          'EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9',
    ),
    PaymentModel(
      paymentType: PaymentType.stripe,
      icon: Images.stripe,
      title: 'Stripe',
      description: 'pay_via_stripe',
      publishableKey:
          'pk_test_51LGHh8AALx6sFd4yttVqYod5nAPwxyFuighk3eoMmlVUGT0YEmS8xMoctyb1wYy7hJ8pLMKVv5AWqMzkUeTsU4cd008mApbq7O',
      secretKey:
          'sk_test_51LGHh8AALx6sFd4ymMirjnQWcbzcNThlgzv6K1pNV5HrP4RTsZOouXM56XCRZNH6VtiE3qSRsO2n8A0jFCV1kWIw00o6TtZ8tx',
    ),
    PaymentModel(
      paymentType: PaymentType.razorpay,
      icon: Images.razorpay,
      title: 'Razorpay',
      description: 'pay_via_razorpay',
      keyId: 'rzp_test_Vio27YvAonerHa',
      secretKey: '92BIuLdPAkDYx7Bbc9IzqSES',
    ),
    PaymentModel(
      paymentType: PaymentType.paystack,
      icon: Images.paystack,
      title: 'Paystack',
      description: 'pay_via_paystack',
      publicKey: 'pk_test_9a51c1e76338a611666c2439924b5c21976d7548',
      secretKey: 'sk_test_6eec6c4373b17e031388e60c43153426f15b560e',
    ),
    // PaymentModel(
    //   paymentType: PaymentType.paytm,
    //   icon: Images.paytm,
    //   title: 'Paytm',
    //   description: 'pay_via_paytm',
    //   merchantKey: '',
    //   merchantMid: '',
    //   merchantWebsite: '',
    // ),
    PaymentModel(
      paymentType: PaymentType.flutterwave,
      icon: Images.flutterwave,
      title: 'Flutterwave',
      description: 'pay_via_flutterwave',
      publicKey: 'FLWPUBK_TEST-18d25b460acd89fa5fcea9365ce950cd-X',
      secretKey: 'FLWSECK_TEST-7fb5d54ee5ea1a829337c4f12b1314df-X',
      encryptionKey: 'FLWSECK_TEST94781c9668a9',
    ),
  ];

  /// End Url
  static const String PRODUCTS_URI =
      '/wp-json/woomond/v1/products?type=variable,simple&per_page=$PAGINATION_LIMIT&page=';
  static const String SALE_PRODUCTS_URI =
      '/wp-json/woomond/v1/products?on_sale&?type=variable,simple&per_page=$PAGINATION_LIMIT&page=';
  static const String POPULAR_PRODUCTS_URI =
      '/wp-json/woomond/v1/products?order_by=popularity&per_page=$PAGINATION_LIMIT&page=';
  static const String REVIEWED_PRODUCTS_URI =
      '/products?status=publish&orderby=rating&per_page=$PAGINATION_LIMIT&page=1';
  static const String PRODUCT_DETAILS_URI = '/wp-json/woomond/v1/product/';
  static const String PRODUCT_DETAILS_SKU_URI = '/products?sku=';
  static const String PRODUCT_VARIATIONS_URI = '/variations/';
  static const String PRODUCT_REVIEWS_URI = '/products/';
  static const String RELATED_PRODUCT_URI = '//wp-json/woomond/v1/products?id=';
  static const String CATEGORIES_URI = '/products/categories';
  static const String CUSTOMER_URI = '/customers';
  static const String CART_LIST_URI = '/wp-json/wc/store/cart/items';
  static const String CART_COUNT_URI = '/wp-json/cocart/v2/cart/items/count';
  static const String REMOVE_CART_URI = '/wp-json/cocart/v2/cart/item/';
  static const String UPDATE_CART_URI = '/wp-json/cocart/v2/cart/item/';
  static const String CLEAR_CART_URI = '/wp-json/cocart/v2/cart/clear';
  static const String ADD_CART_URI = '/wp-json/cocart/v2/cart/add-item';
  static const String LOGIN_URI = '/wp-json/jwt-auth/v1/token';
  static const String REGISTER_URI = '/customers';
  static const String CATEGORY_URI =
      '/products/categories?parent=0&per_page=24&page=';
  static const String SUB_CATEGORY_URI = '/products/categories?parent=';
  static const String CATEGORY_PRODUCT_URI =
      '/products?status=publish&category=';
  static const String COUPON_LIST_URI = '/coupons?per_page=50&page=';
  static const String APPLY_COUPON_URI = '/coupons?code=';
  static const String PROFILE_URI = '/customers/';
  static const String UPDATE_PROFILE_URI = '/customers/';
  static const String DELETE_PROFILE_URI = '/customers/';
  static const String RUNNING_ORDERS_URI =
      '/orders?status=pending,processing,on-hold&per_page=10&page=';
  static const String HISTORY_ORDERS_URI = '/orders?status=';
  static const String ALL_ORDERS_URI =
      '/orders?parent=0&status=pending,processing,on-hold,completed,cancelled,refunded,failed,trash&per_page=10&page=';
  static const String ONGOING_ORDER_URI =
      '/orders?parent=0&status=pending,processing&per_page=10&page=';
  static const String ORDER_DETAILS_URI = '/orders/';
  static const String ORDER_CANCEL_URI = '/orders/';
  static const String PLACE_ORDER_URI = '/orders';
  static const String SWITCH_COD_ORDER_URI = '/orders';
  static const String SHIPPING_METHODS_URI = '/shipping/zones/';
  static const String TAX_CLASS_URI = '/taxes';
  static const String PAYMENT_METHODS_URI = '/payment_gateways';
  static const String GENERAL_SETTINGS_URI = '/wp-json/woomond/v1/wc_settings';
  static const String TAX_SETTINGS_URI = '/settings/tax';
  static const String PRODUCT_SETTINGS_URI = '/settings/products';
  static const String SHIPPING_SETTINGS_URI = '/settings/shipping';
  static const String PRODUCTS_SETTINGS_URI = '/settings/products';
  static const String ACCOUNT_SETTINGS_URI = '/settings/account';
  static const String WISH_TOKEN_URI = '/wishlist/get_by_user/';
  static const String ADD_WISH_URI = '/add_product';
  static const String WISHLIST_URI = '/get_products';
  static const String REMOVE_WISH_URI = '/remove_product/';
  static const String TAX_RATE_URI = '/taxes';
  static const String SHIPPING_ZONES_URI = '/shipping/zones';
  static const String SEARCH_PRODUCT_URI = '/products?status=publish&search=';
  static const String PRODUCT_REVIEW_URI = '/products/reviews';
  static const String POSTS = '/posts';
  static const String SLUG_PRODUCT_DETAILS = '/products/?slug=';
  static const String NOTIFICATION_URI =
      '/wp-json/woomond/v1/push_notification_list?per_page=$PAGINATION_LIMIT&page=';
  static const String GET_USER_ID = '/wp-json/wp/v2/users/me';
  static const String BANNER = '/wp-json/woomond/v1/banner';
  static const String UPDATE_TOKEN = '/wp-json/woomond/v1/push_notification';
  static const String HTML_PAGES = '/wp-json/woomond/v1/pages';
  static const String FORGET_PASSWORD_URI =
      '/wp-json/woomond/v1/reset_password?user=';
  static const String VERIFICATION_URI = '/wp-json/woomond/v1/reset_password';
  static const String UPDATE_AVATAR_URI = '/wp-json/woomond/v1/update_avatar';
  static const String GROUPED_PRODUCT_URI =
      '/products?type=grouped&per_page=15&page=';

  //&order=asc
  ///Dokan
  static const String STORES_LIST_URI = '/stores';
  static const String STORE_PRODUCT_SEARCH_LIST_URI = '/products?search=';

  ///WCFM
  static const String WCFM_SHOP_LIST = '/store-vendors';
  static const String PRODUCT_SEARCH = '/products/?search=';

  /// Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String USER_ID = 'user_id';
  static const String BILLING_ADDRESS = 'billing_address';
  static const String SHIPPING_ADDRESS = 'shipping_address';
  static const String NOTIFICATION = 'notification';
  static const String SEARCH_HISTORY = 'search_history';
  static const String INTRO = 'intro';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String BIOMETRIC_TOKEN = 'biometric_token';
  static const String BIOMETRIC_AUTH = 'biometric_auth';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String ADDRESS_LIST = 'address_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_EMAIL = 'user_email';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'all_customer';
  static const String WISHLIST_SHARED_KEY = 'wishlist_shared_key';
  static const String WISH_LIST = 'wishlist';

  /// Order Status
  static const String PENDING = 'pending';
  static const String PROCESSING = 'processing';
  static const String ON_HOLD = 'on-hold';
  static const String COMPLETED = 'completed';
  static const String CANCELLED = 'cancelled';
  static const String REFUNDED = 'refunded';
  static const String FAILED = 'failed';
  static const String TRASH = 'trash';
}

enum VendorType {
  singleVendor,
  dokan,
  wcfm,
}
