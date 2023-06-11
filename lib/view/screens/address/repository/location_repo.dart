import 'dart:convert';

import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({this.apiClient, this.sharedPreferences});



  Future<bool> saveUserAddress(String address, List<int> zoneIDs) async {
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
    );
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }


  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS);
  }

  List<AddressModel> getAddressList() {
    List<String> address = [];
    if(sharedPreferences.containsKey(AppConstants.ADDRESS_LIST)) {
      address = sharedPreferences.getStringList(AppConstants.ADDRESS_LIST);
    }
    List<AddressModel> addressList = [];
    address.forEach((address) => addressList.add(AddressModel.fromJson(jsonDecode(address))));
    return addressList;
  }

  Future<void> addAddress(List<AddressModel> allAddressList) async {
    List<String> address = [];
    allAddressList.forEach((addressModel) => address.add(jsonEncode(addressModel)));
    sharedPreferences.setStringList(AppConstants.ADDRESS_LIST, address);
  }

}
