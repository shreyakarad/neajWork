import 'dart:convert';

import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/address_model.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/profile_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ProfileRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.PROFILE_URI + sharedPreferences.getInt(AppConstants.USER_ID).toString());
  }

  Future<Response> updateProfile(ProfileModel profile) async {
    return await apiClient.putData(AppConstants.UPDATE_PROFILE_URI + sharedPreferences.getInt(AppConstants.USER_ID).toString(), profile.toJson());
  }

  Future<Response> updateAvatar(XFile avatar) async {
    return await apiClient.postMultipartData(
      AppConstants.UPDATE_AVATAR_URI, {'_method': 'put'}, [MultipartBody('image', avatar)],
      apiVersion: WooApiVersion.noWooApi
    );
  }

  Future<Response> deleteUser() async {
    return await apiClient.deleteData(
      AppConstants.DELETE_PROFILE_URI + sharedPreferences.getInt(AppConstants.USER_ID).toString() + '?force=true',
    );
  }

  void setBillingAddress(AddressModel billingAddress) {
    if(billingAddress == null && sharedPreferences.containsKey(AppConstants.BILLING_ADDRESS)) {
      sharedPreferences.remove(AppConstants.BILLING_ADDRESS);
    }else {
      sharedPreferences.setString(AppConstants.BILLING_ADDRESS, jsonEncode(billingAddress.toJson()));
    }
  }

  void setShippingAddress(AddressModel shippingAddress) {
    if(shippingAddress == null && sharedPreferences.containsKey(AppConstants.SHIPPING_ADDRESS)) {
      sharedPreferences.remove(AppConstants.SHIPPING_ADDRESS);
    }else {
      sharedPreferences.setString(AppConstants.SHIPPING_ADDRESS, jsonEncode(shippingAddress.toJson()));
    }
  }

  AddressModel getBillingAddress() {
    if(sharedPreferences.containsKey(AppConstants.BILLING_ADDRESS)) {
      return AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.BILLING_ADDRESS)));
    }else {
      return null;
    }
  }

  AddressModel getShippingAddress() {
    if(sharedPreferences.containsKey(AppConstants.SHIPPING_ADDRESS)) {
      return AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.SHIPPING_ADDRESS)));
    }else {
      return null;
    }
  }

  Future<Response> updateAddress(ProfileAddressModel address, bool isShipping) async {
    return await apiClient.putData(
      AppConstants.UPDATE_PROFILE_URI + sharedPreferences.getInt(AppConstants.USER_ID).toString(),
      {isShipping ? 'shipping' : 'billing' : address},
    );
  }

}