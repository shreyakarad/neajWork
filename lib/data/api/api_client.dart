import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_woocommerce/data/model/error_model.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;

enum WooApiVersion {
  version1,
  version2,
  version3,
  noWooApi,
  vendorApi,
  postsApi,
}

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  String token;
  Map<String, String> _mainHeaders;

  ApiClient({@required this.appBaseUrl, @required this.sharedPreferences}) {
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

  Future<Response> getData(
      String uri, {Map<String, dynamic> query, Map<String, String> headers, WooApiVersion apiVersion = WooApiVersion.version3}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      print("===Url===>${getUri(uri, apiVersion)}");
      Http.Response _response = await Http.get(
        getUri(uri, apiVersion),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      print('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String> headers, WooApiVersion apiVersion = WooApiVersion.version3}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      print('$uri');
      print(getUri(uri, apiVersion));

      Http.Response _response = await Http.post(
        getUri(uri, apiVersion),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String> headers, WooApiVersion apiVersion = WooApiVersion.version3}
    ) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body with ${multipartBody.length} picture');
      }
      Http.MultipartRequest _request = Http.MultipartRequest('POST', getUri(uri, apiVersion));
      _request.headers.addAll(headers ?? _mainHeaders);
      for(MultipartBody multipart in multipartBody) {
        if(multipart.file != null) {
          Uint8List _list = await multipart.file.readAsBytes();
          _request.files.add(Http.MultipartFile(
            multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      _request.fields.addAll(body);
      Http.Response _response = await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, String> headers, WooApiVersion apiVersion = WooApiVersion.version3}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.put(
        getUri(uri, apiVersion),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String> headers, WooApiVersion apiVersion = WooApiVersion.version3}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      print(uri);
      Http.Response _response = await Http.delete(
        getUri(uri, apiVersion),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
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
      if(_response.body.toString().startsWith('{code:')) {
        ErrorModel _errorResponse = ErrorModel.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.message);
      }else if(_response.body.toString().startsWith('{message') || _response.body.toString().startsWith('{success')) {
        try {
          _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
        }catch(e) {}
      }
    }else if(_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if(Foundation.kDebugMode) {
      print('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    }
    return _response;
  }

  Uri getUri(String uri, WooApiVersion apiVersion) {
    return Uri.parse(appBaseUrl + (apiVersion == WooApiVersion.vendorApi ? AppConstants.vendorType == VendorType.dokan ? '/wp-json/dokan/v1' : '/wp-json/wcfmmp/v1' : apiVersion == WooApiVersion.noWooApi ? '' : apiVersion == WooApiVersion.postsApi ? '/wp-json/wp/v2' :'/wp-json/wc/v${apiVersion == WooApiVersion.version1
        ? '1' : apiVersion == WooApiVersion.version2 ? '2' : '3'}') + uri + (apiVersion == WooApiVersion.noWooApi ? '' :'${uri.contains('?') ? '&' : '?'}consumer_key=')
        + (apiVersion == WooApiVersion.noWooApi ? '' : AppConstants.CONSUMER_KEY + '&consumer_secret=' + AppConstants.CUSTOMER_SECRET));
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
