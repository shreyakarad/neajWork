import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CartRepo({@required this.sharedPreferences, @required this.apiClient});

  Future<Response> getCartList() async {
    return apiClient.getData(AppConstants.CART_LIST_URI, apiVersion: WooApiVersion.noWooApi, headers: _getHeader());
  }

  Future<Response> addToCart(int productID, int quantity, {Map<String, String> variation}) async {
    Map<String, dynamic> _cartBody = {'id': productID.toString(), 'quantity': quantity.toString()};
    if(variation != null) {
      _cartBody.addAll({'variation': variation});
    }
    return apiClient.postData(AppConstants.ADD_CART_URI, _cartBody, apiVersion: WooApiVersion.noWooApi, headers: _getHeader());
  }

  List<CartModelAll> getLocalCartList() {
    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST);
    }
    List<CartModelAll> cartList = [];
    carts.forEach((cart) => cartList.add(CartModelAll.fromJson(jsonDecode(cart))) );
    return cartList;
  }

  void addToLocalCart(List<CartModelAll> cartProductList) {
    List<String> carts = [];
    cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel.toJson())) );
    sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }

  Future<Response> removeFromCart(String cartKey) async {
    return apiClient.deleteData(AppConstants.REMOVE_CART_URI + cartKey, apiVersion: WooApiVersion.noWooApi, headers: _getHeader());
  }

  Future<Response> clearCart() async {
    return apiClient.postData(AppConstants.CLEAR_CART_URI, {}, apiVersion: WooApiVersion.noWooApi, headers: _getHeader());
  }

  Future<Response> updateInCart(String cartKey, int quantity) async {
    return apiClient.postData(
      AppConstants.UPDATE_CART_URI + cartKey, {'quantity': quantity.toString()}, apiVersion: WooApiVersion.noWooApi,
      headers: _getHeader(),
    );
  }

  Future<Response> getCartProduct(String sku) async {
    return apiClient.getData(AppConstants.PRODUCT_DETAILS_SKU_URI + sku);
  }

  Future<Response> getShippingSettings() async {
    return await apiClient.getData(AppConstants.SHIPPING_SETTINGS_URI);
  }

  Map<String, String> _getHeader() {
    return Get.find<AuthController>().isLoggedIn() ? <String, String>{
      'content-type': 'application/json; charset=UTF-8',
      'authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}'
    } : null;
  }

  Future<Response> getTaxRateList() async {
    return await apiClient.getData(AppConstants.TAX_RATE_URI);
  }
}