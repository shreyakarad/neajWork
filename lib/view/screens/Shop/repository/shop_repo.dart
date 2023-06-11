import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ShopRepo {
  ApiClient apiClient;
  ShopRepo({@required this.apiClient});

  Future<Response> getShopList(int offset) async {
    return await apiClient.getData(AppConstants.vendorType == VendorType.dokan ? AppConstants.STORES_LIST_URI + '?page=$offset&per_page=10' : AppConstants.WCFM_SHOP_LIST + '?page=$offset&per_page=10', apiVersion: WooApiVersion.vendorApi);
  }

  Future<Response> getShopProductsList(int shopID, int offset) async {
    return await apiClient.getData((AppConstants.vendorType == VendorType.dokan ? AppConstants.STORES_LIST_URI : AppConstants.WCFM_SHOP_LIST) + '/$shopID/'+'products?per_page=10&page=$offset', apiVersion: WooApiVersion.vendorApi);
  }

  Future<Response> getSearchShopProductsList(String searchText,int shopID,int offset) async {
    return await apiClient.getData(AppConstants.STORES_LIST_URI  + '/' + shopID.toString() + AppConstants.STORE_PRODUCT_SEARCH_LIST_URI + searchText + "&page=$offset&per_page=10",apiVersion: WooApiVersion.vendorApi);
  }

  Future<Response> getSearchWcfmShopProductsList(String searchText,int shopID,int offset) async {
    return await apiClient.getData(AppConstants.WCFM_SHOP_LIST  + '/' + shopID.toString() + AppConstants.PRODUCT_SEARCH + searchText + "&page=$offset&per_page=10",apiVersion: WooApiVersion.vendorApi);
  }

}