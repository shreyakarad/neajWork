import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class BlogRepo{
  ApiClient apiClient;
  BlogRepo({@required this.apiClient});


  Future<Response> getShopProductsList(int offset) async {
    return await apiClient.getData(AppConstants.POSTS+'?per_page=10&page=$offset', apiVersion: WooApiVersion.postsApi);
  }
}