import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError = true, bool isCart = false}) {
  if(message != null && message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        right: ResponsiveHelper.isDesktop(Get.context) ? Get.context.width*0.7 : Dimensions.PADDING_SIZE_SMALL,
        top: Dimensions.PADDING_SIZE_SMALL, bottom: Dimensions.PADDING_SIZE_SMALL, left: Dimensions.PADDING_SIZE_SMALL,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: (isError && !isCart) ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      content: Text(message, style: robotoMedium.copyWith(color: Colors.white), overflow: TextOverflow.ellipsis,),
      action: isCart ? SnackBarAction(
        label: 'view_cart'.tr, onPressed: () => Get.toNamed(RouteHelper.getCartRoute()), textColor: Colors.white,
      ) : null,
    ));
  }
}


void showCustomSnackBarHTML(Widget message, {bool isError = true, bool isCart = false}) {
  if(message != null && message != null) {
    ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        right: ResponsiveHelper.isDesktop(Get.context) ? Get.context.width*0.7 : Dimensions.PADDING_SIZE_SMALL,
        top: Dimensions.PADDING_SIZE_SMALL, bottom: Dimensions.PADDING_SIZE_SMALL, left: Dimensions.PADDING_SIZE_SMALL,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: (isError && !isCart) ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      content: SizedBox(height: 100,child: message),
      action: isCart ? SnackBarAction(
        label: 'view_cart'.tr, onPressed: () => Get.toNamed(RouteHelper.getCartRoute()), textColor: Colors.white,
      ) : null,
    ));
  }
}