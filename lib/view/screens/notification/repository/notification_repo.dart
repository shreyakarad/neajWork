import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/data/api/api_client.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  NotificationRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getNotificationList(String offset,String type) async {
    return await apiClient.getData(AppConstants.NOTIFICATION_URI+offset+'&type='+type, apiVersion: WooApiVersion.noWooApi);
  }

  void saveSeenNotificationCount(int count) {
    sharedPreferences.setInt(AppConstants.NOTIFICATION_COUNT, count);
  }

  int getSeenNotificationCount() {
    return sharedPreferences.getInt(AppConstants.NOTIFICATION_COUNT);
  }

}
