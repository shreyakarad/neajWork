import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:get/get.dart';

class ConditionCheckBox extends StatelessWidget {
  final AuthController authController;
  ConditionCheckBox({@required this.authController});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 20,
        height: 20,
        child: Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          activeColor: Get.isDarkMode
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).primaryColor,
          value: authController.acceptTerms,
          onChanged: (bool isChecked) => authController.toggleTerms(),
        ),
      ),
      SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      InkWell(
          onTap: () {
            authController.toggleTerms();
          },
          child: Text('i_agree_with'.tr,
              style: robotoRegular.copyWith(
                  color: Theme.of(context).primaryColor.withOpacity(.75)))),
      InkWell(
        onTap: () {
          Get.toNamed(RouteHelper.getHtmlRoute('terms-and-condition'));
        },
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Text('terms_conditions'.tr,
              style:
                  robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
        ),
      ),
    ]);
  }
}
