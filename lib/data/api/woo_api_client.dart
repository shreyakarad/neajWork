import 'dart:convert';
import 'dart:io';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:flutter_woocommerce/data/model/error_response.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;

class WooApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  String token;
  Map<String, String> _mainHeaders;

  WooApiClient({@required this.appBaseUrl, @required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN);
    if(Foundation.kDebugMode) {
      print('Token: $token');
    }
    updateHeader(token);
  }

  void updateHeader(String token) {
    _mainHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    };
    if(token != null) {
      _mainHeaders.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
    }
  }

  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> _products;
    try {
      if(Foundation.kDebugMode) {
        print('====> Products Call: ${getUri(AppConstants.PRODUCTS_URI, false)}\nHeader: $_mainHeaders');
      }
      Http.Response _response = await Http.get(
        getUri(AppConstants.PRODUCTS_URI, false),
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response _res = handleResponse(_response, getUri(AppConstants.PRODUCTS_URI, false).toString());
      _products = [];
      _res.body.forEach((product) => _products.add(ProductModel.fromJson(product)));
      return _products;
    } catch (e) {
      return null;
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    }catch(e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request.headers, method: response.request.method, url: response.request.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if(Foundation.kDebugMode) {
      print('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    }
    return _response;
  }

  Uri getUri(String uri, bool withoutWP) {
    return Uri.parse(appBaseUrl + (withoutWP ? '' : '/wp-json/wc/v3') + uri + '?consumer_key=' + AppConstants.CONSUMER_KEY + '&consumer_secret=' + AppConstants.CUSTOMER_SECRET);
  }

}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
