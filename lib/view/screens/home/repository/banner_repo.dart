import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class BannerRepo {
  final ApiClient apiClient;
  BannerRepo({@required this.apiClient});

  Future<Response> getBannerList() async {
    return await apiClient.getData(AppConstants.BANNER,
        apiVersion: WooApiVersion.noWooApi);
  }

}