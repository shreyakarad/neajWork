import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/data/model/payment_model.dart';
import 'package:flutter_woocommerce/helper/payment_helper.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/view/base/custom_loader.dart';
import 'package:flutter_woocommerce/view/screens/address/controller/location_controller.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/model/payment_method_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/model/shipping_method_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/model/shipping_zones_model.dart';
import 'package:flutter_woocommerce/view/screens/coupon/controller/coupon_controller.dart';
import 'package:flutter_woocommerce/view/screens/order/model/order_model.dart';
import 'package:flutter_woocommerce/view/screens/order/model/place_order_body.dart';
import 'package:flutter_woocommerce/view/screens/order/repository/order_repo.dart';
import 'package:flutter_woocommerce/data/api/api_checker.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/profile_model.dart';
import 'package:get/get.dart';

import '../../cart/model/coupon_model.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({@required this.orderRepo});

  List<OrderModel> _historyOrderList = [];
  OrderModel _order;
  int _paymentMethodIndex = 0;
  bool _isLoading = false;
  bool _isPaymentLoading = false;
  bool _showCancelled = false;
  int _addressIndex = -1;
  List<ShippingMethodModel> _shippingMethodList;
  List<ShippingZonesModel> _shippingZonesList;
  int _shippingIndex = -1;
  List<PaymentMethodModel> _paymentMethodList;
  bool _showNotFound = false;
  List<String> _orderStatus = ['all', 'ongoing', 'on-hold', 'completed', 'cancelled', 'failed', 'trash'];
  int _selectedTypeIndex = 0;
  String _orderBillingEmail = '';

  List<OrderModel> get historyOrderModel => _historyOrderList;
  OrderModel get order => _order;
  int get paymentMethodIndex => _paymentMethodIndex;
  bool get isLoading => _isLoading;
  bool get isPaymentLoading => _isPaymentLoading;
  bool get showCancelled => _showCancelled;
  int get addressIndex => _addressIndex;
  List<ShippingMethodModel> get shippingMethodList => _shippingMethodList;
  int get shippingIndex => _shippingIndex;
  List<PaymentMethodModel> get paymentMethodList => _paymentMethodList;
  bool get showNotFound => _showNotFound;
  List<ShippingZonesModel> get shippingZonesList => _shippingZonesList;
  List<String> get orderStatus => _orderStatus;
  int get selectedTypeIndex => _selectedTypeIndex;
  bool loadingOrder = false;
  String get orderBillingEmail => _orderBillingEmail;


  Future<void> getHistoryOrders(int offset,{ bool all = false, bool ongoing = false, String form = '', bool isUpdate = false}) async {
    print(form);
    if(offset == 1){
      _historyOrderList = null;
      _historyOrderList = [];
      loadingOrder = true;
      if(isUpdate){
        update();
      }
    }
    print('Api Calling');
    Response response = await orderRepo.getHistoryOrderList(offset, all, ongoing, _orderStatus[_selectedTypeIndex]);
    if (response.statusCode == 200) {
      if(offset == 1){
        _historyOrderList = [];
      }

      response.body.forEach((order) => _historyOrderList.add(OrderModel.fromJson(order)));
      print('API call done');

      // if(isUpdate){
      //   print('isUpdate-->$isUpdate');
      //   _historyOrderList = null;
      //   _historyOrderList = [];
      //   update();
      // }

      update();

      // response.body.forEach((order) async {
      //   OrderModel _order = OrderModel.fromJson(order);
      //   for (int i =0; i < _order.lineItems.length; i++ ) {
      //     if(_order.lineItems[i].variationId !=0 && _order.lineItems[i].variationId !=null ) {
      //       _order.lineItems[i].variationProducts = await getProductVariations(_order.lineItems[i].productId, _order.lineItems[i].variationId);
      //       _historyOrderList.add(_order);
      //        print(_historyOrderList.length);
      //     }
      //   }
      //   update();
      // });

    } else {
      ApiChecker.checkApi(response);
    }
    if(offset == 1) {
      loadingOrder = false;
      update();
    }
  }


  Future<VariationProducts> getProductVariations(int productId, int variationId) async {
    print('variation Api Call');
    Response response = await orderRepo.getOrderVariations(productId, variationId);
    VariationProducts _variationProducts;
    if (response.statusCode == 200) {
      _variationProducts = VariationProducts.fromJson(response.body);
    } else {
      showCustomSnackBar(response.statusText);
    }
    return _variationProducts;
  }


  Future<OrderModel> getOrderDetails(int orderId, {bool notify = false}) async {
    print('Order Details API Call');
    _showNotFound = false;
    _order = null;
    _showCancelled = false;
    _isLoading = true;
    if(notify){
      update();
    }
      Response response = await orderRepo.getOrderDetails(orderId);
      _isLoading = false;
      if (response.statusCode == 200) {
        _order = OrderModel.fromJson(response.body);
        for (int i =0; i < _order.lineItems.length; i++ ) {
          if(_order.lineItems[i].variationId !=0 && _order.lineItems[i].variationId !=null ) {
            // _order.lineItems[i].variationProducts = await getProductVariations(_order.lineItems[i].productId, _order.lineItems[i].variationId);
          }
        }

        if (AppConstants.vendorType != VendorType.dokan ) {
          _order.stores = [];
          List<int> _storeIdList = [];
          for( int i =0; i < _order.lineItems.length; i++ ){
            for(int j = 0; j< _order.lineItems[i].wcfmMetaData.length; j++){
              if(_order.lineItems[i].wcfmMetaData[j].displayKey == 'Store'){
                Stores _store = Stores(id: int.parse(_order.lineItems[i].wcfmMetaData[j].value) , shopName: _order.lineItems[i].wcfmMetaData[j].displayValue );
                if(!_storeIdList.contains(int.parse(_order.lineItems[i].wcfmMetaData[j].value))) {
                  _storeIdList.add(int.parse(_order.lineItems[i].wcfmMetaData[j].value));
                  _order.stores.add(
                      _store
                  );
                }
              }
            }
          }

          for( int i =0; i < _order.lineItems.length; i++ ){
            bool _isAdmin = true;
            for(int j = 0; j< _order.lineItems[i].wcfmMetaData.length; j++){
              if(_order.lineItems[i].wcfmMetaData[j].displayKey == 'Store') {
                _isAdmin = false;
              }
            }
            if (_order.lineItems[i] == null || _isAdmin) {
              Stores _store = Stores(id: 0, name: 'Admin');
              if (!_storeIdList.contains(0)) {
                _storeIdList.add(0);
                _order.stores.add(
                    _store
                );
              }

            }
          }
        }

        _orderBillingEmail = _order.billing.email;
      } else if(response.statusCode == 404 && response.body['message'] == 'Invalid ID.') {
        _showNotFound = true;
        showCustomSnackBar('invalid_order_id'.tr);
      } else if(response.statusCode == 404) {
        _showNotFound = true;
      } else {
        ApiChecker.checkApi(response);
      }
    update();
    return _order;
  }

  void emptyOrder() {
    _order = null;
  }

  void setPaymentMethod(int index) {
    _paymentMethodIndex = index;
    update();
  }



  Future<void> checkout(bool enableGuestCheckout, bool isLoggedIn, bool isBillingSelected, bool isPaymentEnabled, PaymentModel paymentModel, String note, ProfileAddressModel shippingAddress, ProfileAddressModel billingAddress, List<CartModel> _cartList,  CouponModel coupon, ShippingMethodModel shippingMethod, double orderAmount, bool orderNow) async {
    if( !enableGuestCheckout && !isLoggedIn ) {
      showCustomSnackBar('you_have_to_login_first_to_place_order'.tr);
    }else if(isBillingSelected) {
      showCustomSnackBar('set_billing_address'.tr);
    } else if (!isPaymentEnabled || paymentModel == null) {
      showCustomSnackBar('no_payment_method_is_enabled'.tr);
    } else {
      PlaceOrderBody _placeOrderBody = PlaceOrderBody(
        paymentMethod: paymentModel.title,
        paymentMethodTitle: paymentModel.title,
        setPaid: false, customerId: Get.find<AuthController>().isLoggedIn() ? Get.find<AuthController>().getUserID() : 0,
        customerNote: note, status: 'processing',
        billing: billingAddress,
        shipping: shippingAddress,
      );
      _placeOrderBody.lineItems = [];
      for(CartModel cart in _cartList) {
        _placeOrderBody.lineItems.add(LineItemsBody(
          productId: cart.variation.isNotEmpty ? cart.product.id : cart.id, variationId: cart.variation.isNotEmpty ? cart.id : null, quantity: cart.quantity,
        ));
      }
      _placeOrderBody.couponLines = [];
      if( coupon != null ) {
        _placeOrderBody.couponLines.add(CouponLinesBody(code: coupon.code));
      }
      _placeOrderBody.shippingLines = [];

      if(shippingMethod != null) {
        _placeOrderBody.shippingLines.add(ShippingLinesBody(
          methodId: shippingMethod.methodId,
          methodTitle: shippingMethod.methodTitle,
          total: shippingMethod.methodDescription,
          // shippingTaxStatus: false,
        ));
      }
      await placeOrder(_placeOrderBody, orderAmount, _cartList, coupon, orderNow : orderNow );
      Get.find<CouponController>().removeCouponData(false);
    }
  }

  void initData() {
    _isLoading = false;
    _isPaymentLoading = false;
  }


  Future<bool> isCouponLimitReached( CouponModel coupon, PlaceOrderBody placeOrderBody) async{
    bool _couponLimitPerUser = false;
    if(coupon != null) {
      if(coupon.usageLimitPerUser != null) {
        if (Get.find<AuthController>().isLoggedIn() && coupon.usedBy != null) {
          int _usesCount = 0;
          for ( int i = 0; i < coupon.usedBy.length; i++ ) {
            if (Get.find<AuthController>().getSavedUserId().toString() == coupon.usedBy[i]) {
              _usesCount += 1;
            }
          }
          if(_usesCount == coupon.usageLimitPerUser ){
            _couponLimitPerUser = true;
          }
        }else if(coupon.usedBy != null) {
          int _usesCount = 0;
          for ( int i = 0; i < coupon.usedBy.length; i++ ) {
            if (placeOrderBody.billing.email == coupon.usedBy[i]) {
              _usesCount += 1;
            }
          }
          if(_usesCount == coupon.usageLimitPerUser ){
            _couponLimitPerUser = true;
          }
        }
      }
    }
    return _couponLimitPerUser;
  }

  Future<void> placeOrder(PlaceOrderBody placeOrderBody, double total, List<CartModel> cartList, CouponModel coupon, {bool orderNow = false}) async {
    _isPaymentLoading = true;
    Get.dialog(CustomLoader(), barrierDismissible: false);
    update();

    PaymentResponse _paymentResponse;
    bool _couponLimitPerUser = await isCouponLimitReached(coupon, placeOrderBody);

    if(_couponLimitPerUser == true){
      showCustomSnackBar('coupon_usage_limit_has_been_reached'.tr);
      _isPaymentLoading = false;
      Get.back();
      update();
    }else {
      _paymentResponse = await PaymentHelper.makePayment( placeOrderBody, total, Get.find<ConfigController>().payment[_paymentMethodIndex], cartList );
      _isPaymentLoading = false;
      Get.back();
      update();
    }


    if(_paymentResponse.isSuccess) {
      Get.dialog(CustomLoader(), barrierDismissible: false);
      _isLoading = true;
      update();

      if (Get.find<AuthController>().isLoggedIn()) {
        if(!Get.find<LocationController>().profileShippingSelected){
          await Get.find<ProfileController>().setProfileAddress(Get.find<LocationController>().addressList[Get.find<LocationController>().selectedShippingAddressIndex],true, fromCheckout: true);
        }
        if(!Get.find<LocationController>().profileBillingSelected) {
          await Get.find<ProfileController>().setProfileAddress(Get.find<LocationController>().addressList[Get.find<LocationController>().selectedBillingAddressIndex], false, fromCheckout: true);
        }
        Get.find<LocationController>().removeProfileSavedAddress();
      }

      placeOrderBody.transactionId = _paymentResponse.status;
      Response response = await orderRepo.placeOrder(placeOrderBody);
      Get.back();
      _isLoading = false;
      update();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('order placed ===> ${response.body.toString()}');
        _order = OrderModel.fromJson(response.body);
        if(!orderNow) {
          Get.find<CartController>().clearCartList();
        }
        clearPrevData();
        Get.find<CouponController>().removeCouponData(false);
        Get.find<LocationController>().emptyOrderAddress();
        Get.offNamed(RouteHelper.getOrderSuccessRoute(response.body['id'], true, orderNow));
      } else if ( response.statusCode == 400 && response.body['code'] == 'woocommerce_rest_invalid_coupon') {
        _isLoading = false;
        showCustomSnackBar('coupon_usage_limit_has_been_reached'.tr);
        update();
      } else {
        ApiChecker.checkApi(response);
      }
      Get.find<CartController>().getShippingMethod();
    }else {
      _isLoading = false;
      showCustomSnackBar(_paymentResponse.status);
    }
    update();
  }

  void clearPrevData() {
    _addressIndex = -1;
    _paymentMethodIndex = 0;
  }

  void setAddressIndex(int index) {
    _addressIndex = index;
    update();
  }

  Future<void> cancelOrder(int orderID) async {
    _isLoading = true;
    update();
    Response response = await orderRepo.cancelOrder(orderID);
    _isLoading = false;
    Get.back();
    if (response.statusCode == 200) {
    //   if(_historyOrderList != null) {
    //     List<OrderModel> _tempList = [];
    //     _tempList.addAll(_historyOrderList);
    //     for(int index=0; index<_tempList.length; index++) {
    //       if(_tempList[index].id == orderID) {
    //         _historyOrderList.removeAt(index);
    //     }
    //   }
    // }

    _showCancelled = true;
    showCustomSnackBar('order_cancelled_successfully'.tr, isError: false);
    if(Get.find<AuthController>().isLoggedIn()) {
      getHistoryOrders( 1, all: _selectedTypeIndex == 0 ? true : false, ongoing: _selectedTypeIndex == 1 ? true : false);
      // getHistoryOrders( 1, all: true);
    }
    Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<bool> switchToCOD(int orderID) async {
    _isLoading = true;
    update();
    Response response = await orderRepo.switchToCOD(orderID);
    bool _isSuccess;
    if (response.statusCode == 200) {
      Get.offAllNamed(RouteHelper.getInitialRoute());
      showCustomSnackBar('order_switched_to_cash_on_delivery'.tr, isError: false);
      _isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      _isSuccess = false;
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  Future<void> getShippingMethods(int zoneId) async {
    _shippingIndex = -1;
    update();
    _shippingMethodList = [];
    Response response = await orderRepo.getShippingMethods(zoneId);
    if (response.statusCode == 200 && response.body != null) {
      response.body.forEach((shipping) {
        if(ShippingMethodModel.fromJson(shipping).enabled) {
          _shippingMethodList.add(ShippingMethodModel.fromJson(shipping));
        }
      });
    }
    _shippingIndex = 0;
    update();
  }

  void setShippingIndex(int index) {
    _shippingIndex = index;
    update();
  }

  Future<void> getPaymentMethods() async {
    _paymentMethodIndex = 0;
    Response response = await orderRepo.getPaymentMethods();
    _paymentMethodList = [];
    if (response.statusCode == 200 && response.body != null) {
      response.body.forEach((paymentMethod) {
        if(PaymentMethodModel.fromJson(paymentMethod).enabled) {
          _paymentMethodList.add(PaymentMethodModel.fromJson(paymentMethod));
        }
      });
    }
    update();
  }


  Future<void> getShippingZones() async {
    Response response = await orderRepo.getShippingZones();
    _shippingZonesList = [];
    if (response.statusCode == 200 && response.body != null) {
      response.body.forEach((shipping) => _shippingZonesList.add(ShippingZonesModel.fromJson(shipping)));
    }
    update();
    if(_shippingZonesList.isNotEmpty) {
      Get.find<CartController>().getShippingMethod();
    }
  }

  void emptyShippingMethodList(){
    _shippingMethodList = [];
    update();
  }

  void setSelectedIndex (int index) {
    _selectedTypeIndex = index;
    update();
  }

}