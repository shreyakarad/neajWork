import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/order/controller/order_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final Function onNoPressed;
  ConfirmationDialog({@required this.icon, this.title, @required this.description, @required this.onYesPressed,
    this.isLogOut = false, this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Image.asset(icon, width: 120, height: 120),
          ),

          title != null ? Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            child: Text(
              title, textAlign: TextAlign.center,
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
            ),
          ) : SizedBox(),

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text(description, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center),
          ),
          // SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          GetBuilder<ProfileController>(builder: (profileController) {
            return  GetBuilder<OrderController>(
              builder: (orderController) {
                return GetBuilder<AuthController> (
                  builder: (authController) {
                    return  (!profileController.isLoading && !authController.isLoading && !orderController.isLoading) ? Row(children: [
                      Expanded(child: TextButton(
                        onPressed: () => isLogOut ? onYesPressed() : onNoPressed != null ? onNoPressed() : Get.back(),
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: Size(Dimensions.WEB_MAX_WIDTH, 40), padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
                        ),
                        child: Text(
                          isLogOut ? 'yes'.tr : 'no'.tr, textAlign: TextAlign.center,
                          style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyLarge.color),
                        ),
                      )),
                      SizedBox(width: Dimensions.PADDING_SIZE_LARGE),

                      Expanded(child: CustomButton(
                        buttonText: isLogOut ? 'no'.tr : 'yes'.tr,
                        onPressed: () => isLogOut ? Get.back() : onYesPressed(),
                        radius: Dimensions.RADIUS_SMALL, height: 40,
                      )),
                    ]) : Center(child: CircularProgressIndicator());
                  }
                );
              }
            );
          }),
        ]),
      )),
    );
  }
}
