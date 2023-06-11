import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';


class HtmlRepository{
  final ApiClient apiClient;
  HtmlRepository({@required this.apiClient});

  Future<Response> getPagesContent() async {
    return await apiClient.getData('${AppConstants.HTML_PAGES}', apiVersion: WooApiVersion.noWooApi);
  }

}