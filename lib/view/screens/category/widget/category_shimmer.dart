

import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/screens/category/controller/category_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  CategoryShimmer({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        itemCount: 14,
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
            child: Shimmer(
              duration: Duration(seconds: 2),
              enabled: categoryController.categoryList == null,
              child: Column(children: [
                Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  ),
                ),
                SizedBox(height: 5),
                Container(height: 10, width: 50, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
              ]),
            ),
          );
        },
      ),
    );
  }
}