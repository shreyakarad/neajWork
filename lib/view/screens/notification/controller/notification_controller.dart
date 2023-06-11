import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_checker.dart';
import 'package:flutter_woocommerce/view/screens/notification/model/notification_model.dart';
import 'package:flutter_woocommerce/view/screens/notification/repository/notification_repo.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({@required this.notificationRepo});

  List<NotificationModel> _notificationList = [];
  bool _hasNotification = false;
  bool _isLoading = false;
  List<NotificationModel> get notificationList => _notificationList;
  bool get hasNotification => _hasNotification;
  bool get isLoading => _isLoading;

  Future<void> getNotificationList(int offset ,bool reload, String type) async {
    print('Notification_api_call');

    if(offset == 1) {
      _notificationList = [];
      _isLoading = true;
      update();
    }
    Response response = await notificationRepo.getNotificationList(offset.toString(), type);
    if (response.statusCode == 200) {
      print('Response 200');
      response.body.forEach((notification) {
        NotificationModel _notification  = NotificationModel.fromJson(notification);
        _notificationList.add(_notification);
      });
     update();
    } else {
      ApiChecker.checkApi(response);
    }

    print('Notification_api_call');

    if(offset == 1) {
      _isLoading = false;
      update();
    }
  }

  void saveSeenNotificationCount(int count) {
    notificationRepo.saveSeenNotificationCount(count);
  }

  int getSeenNotificationCount() {
    return notificationRepo.getSeenNotificationCount();
  }

  void clearNotification() {
    _notificationList = null;
  }
}
