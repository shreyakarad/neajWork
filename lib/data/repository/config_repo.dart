import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ConfigRepo({@required this.sharedPreferences, @required this.apiClient});

  Future<Response> getConfigData() async {
    try {
      String jsonStringValues =  await rootBundle.loadString('assets/config/config.json');
      Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
      return Response(statusCode: 200, body: _mappedJson);
    }catch(e) {
      return Response(statusCode: 204, statusText: e.toString());
    }
  }

  Future<Response> getGeneralSettings() async {
    return apiClient.getData(AppConstants.GENERAL_SETTINGS_URI, apiVersion: WooApiVersion.noWooApi);
  }

  Future<bool> initSharedData() {
    if(!sharedPreferences.containsKey(AppConstants.THEME)) {
      sharedPreferences.setBool(AppConstants.THEME, false);
    }
    if(!sharedPreferences.containsKey(AppConstants.COUNTRY_CODE)) {
      sharedPreferences.setString(AppConstants.COUNTRY_CODE, AppConstants.languages[0].countryCode);
    }
    if(!sharedPreferences.containsKey(AppConstants.LANGUAGE_CODE)) {
      sharedPreferences.setString(AppConstants.LANGUAGE_CODE, AppConstants.languages[0].languageCode);
    }
    if(!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.SEARCH_HISTORY)) {
      sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.NOTIFICATION)) {
      sharedPreferences.setBool(AppConstants.NOTIFICATION, true);
    }
    if(!sharedPreferences.containsKey(AppConstants.INTRO)) {
      sharedPreferences.setBool(AppConstants.INTRO, true);
    }
    if(!sharedPreferences.containsKey(AppConstants.NOTIFICATION_COUNT)) {
      sharedPreferences.setInt(AppConstants.NOTIFICATION_COUNT, 0);
    }
    if(!sharedPreferences.containsKey(AppConstants.BIOMETRIC_AUTH)) {
      sharedPreferences.setBool(AppConstants.BIOMETRIC_AUTH, true);
    }
    return Future.value(true);
  }

  void disableIntro() {
    sharedPreferences.setBool(AppConstants.INTRO, false);
  }

  bool showIntro() {
    return sharedPreferences.getBool(AppConstants.INTRO);
  }

  Future<Response> getTaxSettings() async {
    return await apiClient.getData(AppConstants.TAX_SETTINGS_URI);
  }

  Future<Response> getTaxClass() async {
    return await apiClient.getData(AppConstants.TAX_CLASS_URI);
  }

}
