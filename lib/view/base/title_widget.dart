import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  TitleWidget({@required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),
      (onTap != null && !ResponsiveHelper.isDesktop(context)) ? InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
          child: Text(
            'see_all'.tr,
            style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
          ),
        ),
      ) : SizedBox(),
    ]);
  }
}
