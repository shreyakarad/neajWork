import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CouponRepo {
  final ApiClient apiClient;
  CouponRepo({@required this.apiClient});

  Future<Response> getCouponList(int offset) async {
    return await apiClient.getData(AppConstants.COUPON_LIST_URI+offset.toString());
  }

  Future<Response> applyCoupon(String couponCode) async {
    return await apiClient.getData('${AppConstants.APPLY_COUPON_URI}$couponCode');
  }

}