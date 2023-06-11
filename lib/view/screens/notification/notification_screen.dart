import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/notification/widgets/notification_type_widget.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen();

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'notification'.tr),
      body: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(children: [
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
        NotificationType(image: Images.offer, title: 'offer'.tr, unSeenCount: 2, onTap:() => Get.toNamed(RouteHelper.notificationViewRoute('offer'))),
        NotificationType(image: Images.feed, title: 'feed'.tr, unSeenCount: 2, onTap: () => Get.toNamed(RouteHelper.notificationViewRoute('feed'))),
        NotificationType(image: Images.activity, title: 'activity'.tr, unSeenCount: 2, onTap: () => Get.toNamed(RouteHelper.notificationViewRoute('activity'))),
        ])))
    );
  }
}
