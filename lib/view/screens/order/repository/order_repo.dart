import 'package:flutter_woocommerce/view/screens/order/model/place_order_body.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  OrderRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getRunningOrderList(int offset) async {
    return await apiClient.getData(
      '${AppConstants.RUNNING_ORDERS_URI}$offset&customer=${sharedPreferences.getInt(AppConstants.USER_ID)}',
    );
  }

  Future<Response> getHistoryOrderList(int offset,bool all, bool ongoing, String statusType) async {
    return await apiClient.getData(
      all ? '${AppConstants.ALL_ORDERS_URI}$offset&customer=${sharedPreferences.getInt(AppConstants.USER_ID)}' : ongoing ?
      '${AppConstants.ONGOING_ORDER_URI}$offset&customer=${sharedPreferences.getInt(AppConstants.USER_ID)}' :
      '${AppConstants.HISTORY_ORDERS_URI}$statusType&parent_id=0&per_page=10&page=$offset&customer=${sharedPreferences.getInt(AppConstants.USER_ID)}',
    );
  }

  // /orders?status=pending,processing&per_page=10&page=

  Future<Response> getOrderDetails(int orderID) async {
    return await apiClient.getData('${AppConstants.ORDER_DETAILS_URI}$orderID');
  }

  Future<Response> cancelOrder(int orderID) async {
    return await apiClient.putData(AppConstants.ORDER_CANCEL_URI + orderID.toString(), {'status': 'cancelled'});
  }

  Future<Response> placeOrder(PlaceOrderBody orderBody) async {
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI, orderBody.toJson());
  }

  Future<Response> switchToCOD(int orderID) async {
    return await apiClient.putData(
      AppConstants.SWITCH_COD_ORDER_URI + orderID.toString(),
      {'status': 'pending', 'payment_method': 'cod', 'payment_method_title': 'Cash on Delivery'},
    );
  }

  Future<Response> getShippingMethods(int zoneId) async {
    return await apiClient.getData(AppConstants.SHIPPING_METHODS_URI+zoneId.toString()+'/methods');
  }

  Future<Response> getPaymentMethods() async {
    return await apiClient.getData(AppConstants.PAYMENT_METHODS_URI);
  }

  Future<Response> getAccountSettings() async {
    return await apiClient.getData(AppConstants.ACCOUNT_SETTINGS_URI);
  }

  Future<Response> getShippingZones() async {
    return await apiClient.getData(AppConstants.SHIPPING_ZONES_URI);
  }

  Future<Response> getOrderVariations(int productID, int variationId) async {
    return await apiClient.getData(AppConstants.PRODUCT_DETAILS_URI + productID.toString() + AppConstants.PRODUCT_VARIATIONS_URI + variationId.toString());
  }


}