import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getSearchData(String query , int offset) async {
    return await apiClient.getData(AppConstants.SEARCH_PRODUCT_URI+query+'&per_page=10&page=$offset');
  }

  Future<bool> saveSearchHistory(List<String> searchHistories) async {
    return await sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, searchHistories);
  }


  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.SEARCH_HISTORY) ?? [];
  }

  Future<bool> clearSearchHistory() async {
    return sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, []);
  }

}