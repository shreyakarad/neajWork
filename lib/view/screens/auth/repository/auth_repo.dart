import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/view/screens/auth/model/signup_body.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTER_URI, signUpBody.toJson());
  }

  Future<Response> login({String username, String password}) async {
    return await apiClient.postData(
      AppConstants.LOGIN_URI, {"username": username, "password": password}, apiVersion: WooApiVersion.noWooApi,
    );
  }

  Future<Response> getUserId() async {
    return await apiClient.getData( AppConstants.GET_USER_ID, apiVersion: WooApiVersion.noWooApi);
  }

  // Future<Response> updateCmFirebaseToken(String fcmToken, int userId) async {
  //   return await apiClient.postData( AppConstants.UPDATE_TOKEN+'?fcm_key=$fcmToken&id=$userId', {}, apiVersion: WooApiVersion.noWooApi);
  // }



  Future<Response> updateToken(String userId) async {
    String _deviceToken;
    if (GetPlatform.isIOS && !GetPlatform.isWeb) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: false, badge: true, carPlay: false,
        criticalAlert: false, provisional: false, sound: true,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized) {
        _deviceToken = await _saveDeviceToken();
      }
    }else {
      _deviceToken = await _saveDeviceToken();
    }
    if(!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
    }
    return await apiClient.postData(AppConstants.UPDATE_TOKEN+'?fcm_key=$_deviceToken&id=$userId', {}, apiVersion: WooApiVersion.noWooApi);
  }

  Future<Response> deleteFcmToken(String userId) async {
    return await apiClient.postData(AppConstants.UPDATE_TOKEN+'?fcm_key=' '&id=$userId', {}, apiVersion: WooApiVersion.noWooApi);
  }

  Future<String> _saveDeviceToken() async {
    String _deviceToken = '@';
    if(!GetPlatform.isWeb) {
      try {
        _deviceToken = await FirebaseMessaging.instance.getToken();
      }catch(e) {}
    }
    if (_deviceToken != null) {
      print('--------Device Token---------- '+_deviceToken);
    }
    return _deviceToken;
  }




  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  void saveUserId(int userID) async {
    await sharedPreferences.setInt(AppConstants.USER_ID, userID);
  }

  int getSavedUserId () {
    return sharedPreferences.getInt(AppConstants.USER_ID);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  int getUserID() {
    return sharedPreferences.getInt(AppConstants.USER_ID) ?? 0;
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.WISHLIST_SHARED_KEY);
    // sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    sharedPreferences.remove(AppConstants.USER_ID);
    apiClient.token = null;
    apiClient.updateHeader(null);
    return true;
  }

  Future<void> saveUserEmailAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, number);
    } catch (e) {
      throw e;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }


  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

  void setNotificationActive(bool isActive) {
    if(isActive) {
      // updateToken();
    }else {
      if(!GetPlatform.isWeb) {
        FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
      }
    }
    sharedPreferences.setBool(AppConstants.NOTIFICATION, isActive);
  }

  Future<bool> saveBiometricToken(String token) {
    return sharedPreferences.setString(AppConstants.BIOMETRIC_TOKEN, token);
  }

  String getBiometricToken() {
    if(sharedPreferences.containsKey(AppConstants.BIOMETRIC_TOKEN)) {
      return sharedPreferences.getString(AppConstants.BIOMETRIC_TOKEN);
    }else {
      return null;
    }
  }

  void autoLogin(String token) {
    apiClient.updateHeader(token);
    sharedPreferences.setString(AppConstants.TOKEN, token);
    Get.offAllNamed(RouteHelper.getInitialRoute());
  }

  void setBiometric(bool isActive) {
    sharedPreferences.setBool(AppConstants.BIOMETRIC_AUTH, isActive);
  }

  bool isBiometricEnabled() {
    return sharedPreferences.getBool(AppConstants.BIOMETRIC_AUTH);
  }

  Future<Response> forgetPassword(String userName) async {
    return await apiClient.getData(AppConstants.FORGET_PASSWORD_URI+userName, apiVersion: WooApiVersion.noWooApi);
  }

  Future<Response> verifyEmail(String email, String otp) async {
   // return await apiClient.postData(AppConstants.FORGET_PASSWORD_URI+email, {"otp" : otp,} ,apiVersion: WooApiVersion.noWooApi);
    return await apiClient.postData(
      AppConstants.VERIFICATION_URI, {"user": email, "otp": otp}, apiVersion: WooApiVersion.noWooApi
    );
  }

  Future<Response> resetPassword(String email, String otp, String password) async {
    return await apiClient.postData(
      AppConstants.VERIFICATION_URI,
      {"user": email, "otp": otp, "password" : password},
      apiVersion: WooApiVersion.noWooApi
    );
  }

}
