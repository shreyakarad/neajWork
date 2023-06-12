import 'dart:convert';
import 'dart:developer';

import 'package:flutter_woocommerce/model/services/api_service.dart';
import 'package:flutter_woocommerce/model/services/base_service.dart';

import '../../util/utility.dart';
import '../api models/res model/getCountryResponseModel.dart';
import '../services/enum_utils.dart';

class CountrySelectRepo extends BaseService {
  Future<List<GetCountryResponse>> getCityRepo() async {
    var response = await ApiService().getResponse(
        apiType: APIType.aGet,
        url: country +
            '?consumer_key=${Utility.consumer_key}&consumer_secret=${Utility.consumer_secret}',
        withToken: false);

    log('CountrySelectRepo------------$response');

    if (response == null) {
      return null;
    }

    final getCountrySelection = (response as List<dynamic>)
        .map((e) => GetCountryResponse.fromJson(e))
        .toList();

    // List<GetCountryResponse> getCountrySelection =
    //     List<GetCountryResponse>.from(
    //         json.decode(response).map((x) => GetCountryResponse.fromJson(x)));
    return getCountrySelection;
  }
}
