import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class RoughRepo {
  ApiClient apiClient;
  RoughRepo({@required this.apiClient});

  Future<Response> getTaxRateList() async {
    return await apiClient.getData(AppConstants.TAX_RATE_URI);
  }

  Future<Response> getShopList() async {
    return await apiClient.getData(AppConstants.STORES_LIST_URI,apiVersion: WooApiVersion.vendorApi);
  }

}