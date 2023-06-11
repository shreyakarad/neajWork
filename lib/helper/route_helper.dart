import 'dart:convert';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_woocommerce/view/screens/Shop/all_shop_screen.dart';
import 'package:flutter_woocommerce/view/screens/Shop/shop_product_search_screen.dart';
import 'package:flutter_woocommerce/view/screens/Shop/shop_screen.dart';
import 'package:flutter_woocommerce/view/screens/address/add_address_screen.dart';
import 'package:flutter_woocommerce/view/screens/address/saved_address_screen.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/coupon_model.dart';
import 'package:flutter_woocommerce/view/screens/category/model/category_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/checkout_screen.dart';
import 'package:flutter_woocommerce/view/screens/checkout/model/shipping_method_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/order_successful_screen.dart';
import 'package:flutter_woocommerce/view/screens/coupon/coupon_screen.dart';
import 'package:flutter_woocommerce/view/screens/forget/forget_pass_screen.dart';
import 'package:flutter_woocommerce/view/screens/forget/new_pass_screen.dart';
import 'package:flutter_woocommerce/view/screens/forget/verification_screen.dart';
import 'package:flutter_woocommerce/view/screens/html/html_viewer_screen.dart';
import 'package:flutter_woocommerce/view/screens/language/choose_language_screen.dart';
import 'package:flutter_woocommerce/view/screens/more/settings_screen.dart';
import 'package:flutter_woocommerce/view/screens/notification/notification_screen.dart';
import 'package:flutter_woocommerce/view/screens/notification/notification_view_screen.dart';
import 'package:flutter_woocommerce/view/screens/order/model/order_model.dart';
import 'package:flutter_woocommerce/view/screens/order/order_details_screen.dart';
import 'package:flutter_woocommerce/view/screens/order/order_tracking_screen.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/helper/product_type.dart';
import 'package:flutter_woocommerce/view/screens/auth/sign_in_screen.dart';
import 'package:flutter_woocommerce/view/screens/auth/sign_up_screen.dart';
import 'package:flutter_woocommerce/view/screens/cart/cart_screen.dart';
import 'package:flutter_woocommerce/view/screens/category/category_product_screen.dart';
import 'package:flutter_woocommerce/view/screens/category/category_screen.dart';
import 'package:flutter_woocommerce/view/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_woocommerce/view/screens/home/home_screen.dart';
import 'package:flutter_woocommerce/view/screens/product/all_product_screen.dart';
import 'package:flutter_woocommerce/view/screens/product/image_viewer_screen.dart';
import 'package:flutter_woocommerce/view/screens/product/product_details_screen.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/address_model.dart';
import 'package:flutter_woocommerce/view/screens/profile/profile_screen.dart';
import 'package:flutter_woocommerce/view/screens/profile/update_profile_screen.dart';
import 'package:flutter_woocommerce/view/screens/root/update_screen.dart';
import 'package:flutter_woocommerce/view/screens/search/search_screen.dart';
import 'package:flutter_woocommerce/view/screens/splash/splash_screen.dart';
import 'package:flutter_woocommerce/view/screens/write_review_screen.dart';
import 'package:get/get.dart';
import '../view/screens/Shop/model/shop_model.dart';
import '../view/screens/grouped_product/grouped_product_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String categories = '/categories';
  static const String categoryProduct = '/category-product';
  static const String popularProduct = '/popular-product';
  static const String reviewedProduct = '/best-reviewed-product';
  static const String onSaleProduct = '/on-sale-product';
  static const String cart = '/cart';
  static const String productDetails = '/product-details';
  static const String productImages = '/product-images';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String privacyPolicy = '/privacy-policy';
  static const String aboutUs = '/about-us';
  static const String coupon = '/coupon';
  static const String update = '/update';
  static const String orderDetails = '/order-details';
  static const String profile = '/profile';
  static const String notification = '/notification';
  static const String map = '/map';
  static const String address = '/address';
  static const String orderSuccess = '/order-successful';
  static const String checkout = '/checkout';
  static const String orderTracking = '/track-order';
  static const String allShopScreen = '/all-shop';
  static const String shop = '/shop';
  static const String search = '/search';
  static const String searchShopItem = '/search-Shop-item';
  static const String language = '/language';
  static const String pickMap = '/pick-map';
  static const String accessLocation = '/access-location';
  static const String rough = '/rough';
  static const String notificationView = '/notification_view';
  static const String writeReview = '/write_review';
  static const String savedAddress = '/saved_address';
  static const String addAddress = '/add_address';
  static const String updateProfile = '/update_profile';
  static const String settings = '/settings';
  static const String html = '/html';
  static const String forgotPassword = '/forgot-password';
  static const String verification = '/verification';
  static const String resetPassword = '/reset-password';
  static const String groupedProductScreen = '/grouped_product_screen';


  static String getInitialRoute() => '$initial';
  static String getSplashRoute(PendingDynamicLinkData pendingDynamicLinkData, String notyType) {
    String _pendingDynamicLinkData =' ';
    if(pendingDynamicLinkData != null) {_pendingDynamicLinkData = pendingDynamicLinkData.link.toString();}
    return '$splash?splash=$_pendingDynamicLinkData&type=$notyType';
  }
  static String getHomeRoute(String name) => '$home?name=$name';
  static String getSignInRoute({String from = ''}) => '$signIn?from=$from';
  static String getSignUpRoute() => '$signUp';
  static String getCategoryRoute() => '$categories';
  static String getCategoryProductRoute(CategoryModel category) {
    String _data = base64Encode(utf8.encode(jsonEncode(category.toJson())));
    return '$categoryProduct?data=$_data';
  }
  static String getPopularProductRoute(bool isPopular) => '$popularProduct';
  static String getReviewedProductRoute(bool isPopular) => '$reviewedProduct';
  static String getSaleProductRoute(bool isPopular) => '$onSaleProduct';
  static String getCartRoute({CartModel cartModel, bool fromOrder = false}) {
    String _cartModel;
    if(cartModel != null) {
      print('-------${cartModel.toString()}');
      _cartModel = base64Encode(utf8.encode(jsonEncode(cartModel.toJson())));
    }
    print(fromOrder);
    return '$cart?cartModel=$_cartModel&fromOrder=${fromOrder.toString()}';
  }
  static String getProductImagesRoute(ProductModel product) {
    String _data = base64Url.encode(utf8.encode(jsonEncode(product.toJson())));
    return '$productImages?item=$_data';
  }
  static String getProductDetailsRoute (int productID,String url,bool formSplash) {
    return '$productDetails?id=$productID&url=$url&formSplash=${formSplash.toString()}';
  }
  static String getHtmlRoute(String page) => '$html?page=$page';

  static String getCouponRoute(bool formCart) => '$coupon?formCart=${formCart.toString()}';
  static String getUpdateRoute(bool isUpdate) => '$update?update=${isUpdate.toString()}';
  static String getOrderDetailsRoute(int orderID, { bool guestMode = false}) {
    return '$orderDetails?id=$orderID&guest=$guestMode';
  }
  static String getProfileRoute() => '$profile';
  static String getNotificationRoute() => '$notification';
  static String getMapRoute(AddressModel addressModel, String page) {
    List<int> _encoded = utf8.encode(jsonEncode(addressModel.toJson()));
    String _data = base64Encode(_encoded);
    return '$map?address=$_data&page=$page';
  }
  static String getAddressRoute() => '$address';
  static String getOrderSuccessRoute(int orderID, bool success, bool orderNow) {
    return '$orderSuccess?id=$orderID&success=${success ? 'true' : 'false'}&order_now=${orderNow ? 'true' : 'false'}';
  }
  static String getCheckoutRoute(String page, CouponModel coupon, ShippingMethodModel shipping, {bool reOrder}) {
    String _coupon;
    if(coupon != null) {
      print('-------${shipping.toJson()}');
      _coupon = base64Encode(utf8.encode(jsonEncode(coupon.toJson())));
    }
    String _shipping;
    if(shipping != null) {
      _shipping = base64Encode(utf8.encode(jsonEncode(shipping.toJson())));
    }
    return '$checkout?page=$page&coupon=${coupon != null ? _coupon : 'null'}&shipping=${shipping != null ? _shipping : 'null'}&reOrder=$reOrder';
  }
  static String getOrderTrackingRoute(OrderModel order) {
    String _data = base64Encode(utf8.encode(jsonEncode(order.toJson())));
    return '$orderTracking?order=$_data';
  }
  static String getAllShop() => '$allShopScreen';
  static String getShopRoute(ShopModel shopData){
    String _shop;
    if(shop != null) {_shop = base64Encode(utf8.encode(jsonEncode(shopData.toJson())));}
    return '$shop?shop=$_shop';
  }

  static String getSearchRoute() => '$search';
  static String getSearchShopProductRoute(int shopID) => '$searchShopItem?id=$shopID';//


  static String getLanguageRoute(String page) => '$language?page=$page';
  static String getPickMapRoute(String page, bool canRoute) => '$pickMap?page=$page&route=${canRoute.toString()}';
  static String getAccessLocationRoute(String page) => '$accessLocation?page=$page';
  static String getRoughRoute() => '$rough';
  static String notificationViewRoute(String from, {bool fromNotification = false}) => '$notificationView?from=$from&fromNotification=$fromNotification';
  static String getWriteReviewRoute(int productId) {
    // String _item;
    // if(item != null) {
    //   _item = base64Encode(utf8.encode(jsonEncode(item.toJson())));
    // }
    return '$writeReview?product_id=$productId';
  }
  static String getSavedAddressRoute() => '$savedAddress';
  static String getAddAddressRoute(AddressModel address, int index) {
    String _address;
    if(address != null) {_address = base64Encode(utf8.encode(jsonEncode(address.toJson())));}
    return '$addAddress?address=$_address&index=$index';
  }
  static String getEditProfileRoute() => '$updateProfile';
  static String getSettingsRoute() => '$settings';
  static String getForgotPassRoute() { return '$forgotPassword?page='; }
  static String getVerificationRoute(String number, String token, String page, String pass) {
    return '$verification?page=$page&number=$number&token=$token&pass=$pass';
  }
  static String getResetPasswordRoute(String phone, String token, String page) => '$resetPassword?phone=$phone&token=$token&page=$page';

  static String getGroupedProductRoute(GroupedProduct group) {
    String _data = base64Encode(utf8.encode(jsonEncode(group.toJson())));
    return '$groupedProductScreen?data=$_data';
  }

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => DashboardScreen(pageIndex: 0)),
    GetPage(name: splash, page: () {
      print('======Dynamic Link=====>${Get.parameters['splash']}');
      return SplashScreen(pendingDynamicLink: Get.parameters['splash'] != ' ' ? Get.parameters['splash']  : null, notyType: Get.parameters['type'] != ' ' ? Get.parameters['type']  : null,);
    }),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: signIn, page: () {
      return  SignInScreen(from: Get.parameters['from'] != ' ' ? Get.parameters['from']  : null);
    }),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: categories, page: () => CategoryScreen()),
    GetPage(name: categoryProduct, page: () {
      List<int> _decode = base64Decode(Get.parameters['data'].replaceAll(' ', '+'));
      CategoryModel _data = CategoryModel.fromJson(jsonDecode(utf8.decode(_decode)));
      return CategoryProductScreen(category: _data);
    }),
    GetPage(name: popularProduct, page: () => AllProductScreen(productType: ProductType.POPULAR_PRODUCT)),
    GetPage(name: reviewedProduct, page: () => AllProductScreen(productType: ProductType.REVIEWED_PRODUCT)),
    GetPage(name: onSaleProduct, page: () => AllProductScreen(productType: ProductType.SALE_PRODUCT)),
    GetPage(name: cart, page: () {
      //cartModel
      CartModel _cartModel;
      if(Get.parameters['cartModel'] != 'null') {
        _cartModel = CartModel.fromJson(jsonDecode(utf8.decode(base64Decode(Get.parameters['cartModel'].replaceAll(' ', '+')))));
      }

      print(Get.parameters['fromOrder'] == 'true');

      return CartScreen(fromNav: false, cartModel: _cartModel, fromOrder : Get.parameters['fromOrder'] == 'true' );
    }),
    GetPage(name: productImages, page: () => ImageViewerScreen(
      product: ProductModel.fromJson(jsonDecode(utf8.decode(base64Url.decode(Get.parameters['item'].replaceAll(' ', '+'))))),
    )),
    GetPage(name: productDetails, page: () =>  ProductDetailsScreen( product: ProductModel(id: int.parse(Get.parameters['id'])), url: Get.parameters['url'], formSplash: Get.parameters['formSplash'] =='true')),
    GetPage(name: privacyPolicy, page: () => HtmlViewerScreen(htmlType: HtmlType.PRIVACY_POLICY)),
    GetPage(name: aboutUs, page: () => HtmlViewerScreen(htmlType: HtmlType.ABOUT_US)),
    GetPage(name: termsAndConditions, page: () => HtmlViewerScreen(htmlType: HtmlType.TERMS_AND_CONDITION)),
    GetPage(name: coupon, page: () => CouponScreen( formCart: Get.parameters['formCart'] == 'true' )),
    GetPage(name: update, page: () => UpdateScreen( isUpdate: Get.parameters['update'] == 'true' )),
    GetPage(name: orderDetails, page: () {
      return Get.arguments != null ? Get.arguments : OrderDetailsScreen(orderModel: OrderModel(id: int.parse(Get.parameters['id'] ?? '0' )),  guestOrder: Get.parameters['guest'] != null ? Get.parameters['guest'] == 'true' : false);
    }),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: notification, page: () => NotificationScreen()),
    // GetPage(name: map, page: () {
    //   List<int> _decode = base64Decode(Get.parameters['address'].replaceAll(' ', '+'));
    //   AddressModel _data = AddressModel.fromJson(jsonDecode(utf8.decode(_decode)));
    //   return MapScreen(fromStore: Get.parameters['page'] == 'store', address: _data);
    // }),
    //GetPage(name: address, page: () => AddressScreen()),
    GetPage(name: orderSuccess, page: () => OrderSuccessfulScreen(
      orderID: Get.parameters['id'], success: Get.parameters['success'] == 'true', orderNow: Get.parameters['order_now'] == 'true'
    )),
    GetPage(name: checkout, page: () {
      CouponModel _coupon;
      if(Get.parameters['coupon'] != 'null') {
        _coupon = CouponModel.fromJson(jsonDecode(utf8.decode(base64Decode(Get.parameters['coupon'].replaceAll(' ', '+')))));
      }
      ShippingMethodModel _shipping;
      if(Get.parameters['shipping'] != 'null') {
        _shipping = ShippingMethodModel.fromJson(
          jsonDecode(utf8.decode(base64Decode(Get.parameters['shipping'].replaceAll(' ', '+')))),
          fromRoute: true,
        );
      }
      return CheckoutScreen(coupon: _coupon, shippingMethod: _shipping, orderAmount: null,);
    }),
    GetPage(name: orderTracking, page: () => OrderTrackingScreen(
      orderId: int.parse(Get.parameters['id'].toString()),
      order:  OrderModel.fromJson(jsonDecode(utf8.decode(base64Url.decode(Get.parameters['order'])))) ,
    )),
    GetPage(name: allShopScreen, page: () => AllShopScreen()),
    GetPage(name: shop,page:() => ShopScreen(shop: ShopModel.fromJson(jsonDecode(utf8.decode(base64Url.decode(Get.parameters['shop'])))))),

    GetPage(name: search, page: () => SearchScreen()),
    GetPage(name: searchShopItem, page: () => ShopProductSearchScreen(storeID: Get.parameters['id'])),
    GetPage(name: language, page: () => ChooseLanguageScreen(fromMenu: Get.parameters['page'] == 'menu')),
    GetPage(name: notificationView, page: () {
      print( Get.parameters['from'] );
      print('route---------');
      return NotificationViewScreen(form: Get.parameters['from'], fromNotification: Get.parameters['fromNotification'] == 'true');
    }),
    GetPage(name: writeReview, page: () {
      return WriteReviewScreen(
        // lineItems: Get.parameters['item'] != 'null' ? ProductModel.fromJson(jsonDecode(utf8.decode(base64Url.decode( Get.parameters['item'] )))) : null,
        productId: int.parse(Get.parameters['product_id']),
      );
    }),
    GetPage(name: savedAddress, page: () => SavedAddressScreen()),
    GetPage(name: addAddress, page: () {
      return AddAddressScreen(
        address : Get.parameters['address'] != 'null' ? AddressModel.fromJson(jsonDecode(utf8.decode(base64Url.decode( Get.parameters['address'] )))) : null,
        index: Get.parameters['index'] != 'null' ?  int.parse(Get.parameters['index'])  : null,
      );
    }),
    GetPage(name: updateProfile, page: () => UpdateProfileScreen()),
    GetPage(name: settings, page: () => SettingsScreen()),

    GetPage(
        name: html,
        page: () => HtmlViewerScreen(
            htmlType:
            Get.parameters['page'] == 'terms-and-condition' ? HtmlType.TERMS_AND_CONDITION :
            Get.parameters['page'] == 'privacy-policy' ? HtmlType.PRIVACY_POLICY :
            Get.parameters['page'] == 'cancellation_policy' ? HtmlType.CANCELLATION_POLICY :
            Get.parameters['page'] == 'refund_policy' ? HtmlType.REFUND_POLICY :
            HtmlType.ABOUT_US
    )),

    GetPage(name: forgotPassword, page: () {
      return ForgetPassScreen();
    }),

    GetPage(name: verification, page: () {
      List<int> _decode = base64Decode(Get.parameters['pass'].replaceAll(' ', '+'));
      String _data = utf8.decode(_decode);
      return VerificationScreen(
        number: Get.parameters['number'], fromSignUp: Get.parameters['page'] == signUp, token: Get.parameters['token'],
        password: _data,
      );
    }),

    GetPage(name: resetPassword, page: () => NewPassScreen(
      resetToken: Get.parameters['token'], number: Get.parameters['phone'], fromPasswordChange: Get.parameters['page'] == 'password-change',
    )),

    GetPage(name: groupedProductScreen, page: () {
      List<int> _decode = base64Decode(Get.parameters['data'].replaceAll(' ', '+'));
      GroupedProduct _data = GroupedProduct.fromJson(jsonDecode(utf8.decode(_decode)));
      return GroupedProductScreen(groupedProduct: _data);
    }),

  ];
}

