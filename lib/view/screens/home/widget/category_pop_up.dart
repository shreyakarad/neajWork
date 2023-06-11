import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/view/screens/category/controller/category_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class CategoryPopUp extends StatelessWidget {
  final CategoryController categoryController;
  CategoryPopUp({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 500,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
              child:
              TitleWidget(title: 'categories'.tr),
            ),
            Expanded(
              child: SizedBox(
                height: 80,
                child: categoryController.categoryList != null ? GridView.builder(
                  itemCount: categoryController.categoryList.length,
                  padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                  physics: BouncingScrollPhysics(),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.2,
                    crossAxisCount: GetPlatform.isDesktop ? 5 : 4,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                      child: InkWell(
                        onTap: () => Get.toNamed(RouteHelper.getCategoryProductRoute(categoryController.categoryList[index])),
                        child: SizedBox(
                          width: 50,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50, width: 50,
                                  margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                    boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], blurRadius: 5, spreadRadius: 1)],
                                  ),
                                  child: CustomImage(
                                    image: categoryController.categoryList[index].image != null ? categoryController.categoryList[index].image.src : '',
                                    height: 50, width: 50, fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  categoryController.categoryList[index].name,
                                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                                ),
                              ]),
                        ),
                      ),
                    );
                  },
                ) : CategoryShimmer(categoryController: categoryController),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  CategoryShimmer({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: 10,
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
                  height: 57,
                  width: 57,
                  decoration: BoxDecoration(
                    color:Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 350],
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  ),
                ),
                SizedBox(height: 3),
                Container(height: 7, width: 45, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 350]),
              ]),
            ),
          );
        },
      ),
    );
  }
}
