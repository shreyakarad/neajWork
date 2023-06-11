import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      height: 100, width: 100,
      decoration: BoxDecoration(color: Get.isDarkMode ? Theme.of(context).colorScheme.background : Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    ));
  }
}
