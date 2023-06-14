import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/util/color_utils.dart';
import 'package:flutter_woocommerce/view/screens/category/category_screen.dart';
import 'package:flutter_woocommerce/view/screens/category/controller/category_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/home/home_category_screen.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/category_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategoryProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    print("Callll HomeCategoryProductsView");
    return GetBuilder<CategoryController>(builder: (categoryController) {
      return (categoryController.categoryList != null &&
              categoryController.categoryList.length == 0)
          ? SizedBox()
          : Column(
              children: [
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Row(
                  children: [
                    Expanded(
                      child: categoryController.categoryList != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    //HomeCategoryScreen(categoryId: 550)
                                  ]
                                  // List.generate(
                                  //     // categoryController.categoryList.length > 3
                                  //     //     ? 4
                                  //     //     :
                                  //     categoryController.categoryList.length,
                                  //     (index) {
                                  //   return HomeCategoryScreen(
                                  //       categoryId: categoryController
                                  //           .categoryList[index].id);
                                  // }),
                                  ),
                            )
                          : CategoryShimmer(
                              categoryController: categoryController),
                    ),
                  ],
                ),
              ],
            );
    });
  }
}
