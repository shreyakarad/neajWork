import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:get/get.dart';

class GuestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(1, 40),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, RouteHelper.getInitialRoute());
      },
      child: RichText(text: TextSpan(children: [
        TextSpan(text: '${'continue_as'.tr} ', style: robotoRegular.copyWith(color: Theme.of(context).disabledColor)),
        TextSpan(text: 'guest'.tr, style: robotoMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge.color)),
      ])),
    );
  }
}