import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/view/screens/product/model/review_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ProductRepo {
  ApiClient apiClient;
  ProductRepo({@required this.apiClient});

  Future<Response> getProductList(int offset) async {
    return await apiClient.getData(AppConstants.PRODUCTS_URI + offset.toString(), apiVersion: WooApiVersion.noWooApi);
  }

  Future<Response> getSaleProductList(int offset) async {
    return await apiClient.getData(AppConstants.SALE_PRODUCTS_URI+offset.toString(), apiVersion: WooApiVersion.noWooApi);
  }

  Future<Response> getPopularProductList(int offset) async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCTS_URI+offset.toString(), apiVersion: WooApiVersion.noWooApi);
  }

  Future<Response> getReviewedProductList() async {
    return await apiClient.getData(AppConstants.REVIEWED_PRODUCTS_URI);
  }

  Future<Response> getProductDetails(int productID) async {
    return await apiClient.getData(AppConstants.PRODUCT_DETAILS_URI + productID.toString(), apiVersion: WooApiVersion.noWooApi);
  }

  Future<Response> getRelatedProducts(String productIDs) async {
    return await apiClient.getData(AppConstants.RELATED_PRODUCT_URI + productIDs+'&per_page=100', apiVersion: WooApiVersion.noWooApi);
  }

  Future<Response> getProductVariations(int productID) async {
    return await apiClient.getData(AppConstants.PRODUCT_DETAILS_URI + productID.toString() + '/variations');
    //return await apiClient.getData(AppConstants.REVIEWED_PRODUCTS_URI);
  }

  Future<Response> getProductReviews(int productID) async {
    return await apiClient.getData(
      AppConstants.PRODUCT_REVIEWS_URI + productID.toString() + '/reviews',
      apiVersion: WooApiVersion.version2,
    );
  }

  Future<Response> getProductSettings() async {
    return await apiClient.getData(AppConstants.PRODUCT_SETTINGS_URI);
  }

  Future<Response> postReviewSubmit(SubmitReviewModel review) async {
    return await apiClient.postData(AppConstants.PRODUCT_REVIEW_URI, review);
  }

  Future<Response> updateProductReview(SubmitReviewModel review, int reviewId) async {
    return await apiClient.putData(AppConstants.PRODUCT_REVIEW_URI+'/'+reviewId.toString(), review);
  }

  Future<Response> getSlugProductDetails(String slug) async {
    return await apiClient.getData(AppConstants.SLUG_PRODUCT_DETAILS + slug);
  }

  Future<Response> getGroupedProductList(int offset) async {
    return await apiClient.getData(AppConstants.GROUPED_PRODUCT_URI+offset.toString());
  }

}