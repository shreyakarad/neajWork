import 'dart:developer';

import 'package:flutter_woocommerce/model/apis/api_response.dart';
import 'package:flutter_woocommerce/model/repo/countrySelectRepo.dart';
import 'package:get/get.dart';

import '../model/api models/res model/getCountryResponseModel.dart';

class CountryViewModel extends GetxController {
  ApiResponse countryResponse = ApiResponse.initial('Initial');
  Future<void> getCountrySelect() async {
    countryResponse = ApiResponse.loading('Loading');
    update();
    try {
      List<GetCountryResponse> response =
          await CountrySelectRepo().getCityRepo();
      countryResponse = ApiResponse.complete(response);

      // log('----res for country-->$response');
    } catch (e) {
      log('----error on country-->$e');
      countryResponse = ApiResponse.error('error');
    }
    update();
  }
}
