import 'dart:convert';

import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/data/model/language_model.dart';
import 'package:flutter_woocommerce/data/repository/config_repo.dart';
import 'package:flutter_woocommerce/view/screens/Shop/controller/shop_controller.dart';
import 'package:flutter_woocommerce/view/screens/Shop/repository/shop_repo.dart';
import 'package:flutter_woocommerce/view/screens/address/controller/location_controller.dart';
import 'package:flutter_woocommerce/view/screens/address/repository/location_repo.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/blog/controller/blog_controller_dart.dart';
import 'package:flutter_woocommerce/view/screens/blog/repository/blog_repo.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/category/controller/category_controller.dart';
import 'package:flutter_woocommerce/controller/language_controller.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/view/screens/coupon/controller/coupon_controller.dart';
import 'package:flutter_woocommerce/view/screens/coupon/repository/coupon_repo.dart';
import 'package:flutter_woocommerce/view/screens/home/controller/banner_controller.dart';
import 'package:flutter_woocommerce/view/screens/home/repository/banner_repo.dart';
import 'package:flutter_woocommerce/view/screens/html/controller/webview_controller.dart';
import 'package:flutter_woocommerce/view/screens/html/repository/html_repo.dart';
import 'package:flutter_woocommerce/view/screens/notification/controller/notification_controller.dart';
import 'package:flutter_woocommerce/view/screens/notification/repository/notification_repo.dart';
import 'package:flutter_woocommerce/view/screens/order/controller/order_controller.dart';
import 'package:flutter_woocommerce/view/screens/order/repository/order_repo.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/repository/profile_repo.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/view/screens/auth/repository/auth_repo.dart';
import 'package:flutter_woocommerce/view/screens/cart/repository/cart_repo.dart';
import 'package:flutter_woocommerce/view/screens/category/repository/category_repo.dart';
import 'package:flutter_woocommerce/data/repository/language_repo.dart';
import 'package:flutter_woocommerce/view/screens/product/repository/product_repo.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/view/screens/rough/reopositry/rough_repo.dart';
import 'package:flutter_woocommerce/view/screens/search/controller/search_controller.dart';
import 'package:flutter_woocommerce/view/screens/search/repository/search_repo.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:flutter_woocommerce/view/screens/wish/repository/wish_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../view/screens/rough/controller/rough_controller.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => ConfigRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => CouponRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => WishRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => RoughRepo(apiClient: Get.find()));
  Get.lazyPut(() => ShopRepo(apiClient: Get.find()));
  Get.lazyPut(() => SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => BlogRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => BannerRepo(apiClient: Get.find()));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HtmlRepository(apiClient: Get.find()),  fenix: true);

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ConfigController(configRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => CouponController(couponRepo: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => WishListController(wishRepo: Get.find(), sharedPreferences: Get.find(),));
  Get.lazyPut(() => RoughController(sharedPreferences: Get.find(),roughRepo: Get.find()));
  Get.lazyPut(() => ShopController(shopRepo: Get.find()));
  Get.lazyPut(() => SearchController(searchRepo: Get.find()));
  Get.lazyPut(() => BlogController(blogRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => BannerController(bannerRepo: Get.find()));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => HtmlViewController(htmlRepository: Get.find()), fenix: true );


  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return _languages;
}
