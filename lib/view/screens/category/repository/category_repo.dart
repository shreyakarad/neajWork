import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({@required this.apiClient});

  Future<Response> getCategoryList(int offset) async {
    return await apiClient
        .getData(AppConstants.CATEGORY_URI + offset.toString());
  }

  Future<Response> getSubCategoryList(String parentID) async {
    return await apiClient.getData('${AppConstants.SUB_CATEGORY_URI}$parentID');
  }

  Future<Response> getCategoryProductList(String categoryID, int offset) async {
    print("CATEGORY ID====$categoryID");
    return await apiClient.getData(
        '${AppConstants.CATEGORY_PRODUCT_URI}$categoryID&per_page=${AppConstants.PAGINATION_LIMIT}&page=$offset');
  }

  Future<Response> getSearchData(
      String query, String categoryID, int offset) async {
    return await apiClient.getData(
      '${AppConstants.CATEGORY_PRODUCT_URI}$categoryID&search=$query&page=$offset&per_page=${AppConstants.PAGINATION_LIMIT}',
    );
  }
}
