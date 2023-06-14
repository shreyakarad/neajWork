import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/category/model/category_model.dart';
import 'package:flutter_woocommerce/view/screens/home/controller/banner_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(builder: (bannerController) {
      return bannerController.bannerList == null
          ? Shimmer(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                  color: Colors
                      .grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                ),
              ),
            )
          : (bannerController.bannerList != null &&
                  bannerController.bannerList.isNotEmpty)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 220,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Container(
                          color: Get.isDarkMode
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context).primaryColor,
                          child: GetBuilder<AuthController>(
                            builder: (splashController) {
                              return InkWell(
                                child: CustomImage(
                                  image:
                                      '${bannerController.bannerList[index].image}',
                                  fit: BoxFit.cover,
                                ),
                                onTap: () {
                                  if (bannerController
                                              .bannerList[index].resourceType ==
                                          'product' &&
                                      bannerController
                                              .bannerList[index].product !=
                                          null) {
                                    Get.toNamed(
                                        RouteHelper.getProductDetailsRoute(
                                            bannerController
                                                .bannerList[index].product,
                                            null,
                                            false));
                                  } else if (bannerController
                                              .bannerList[index].resourceType ==
                                          'category' &&
                                      bannerController
                                              .bannerList[index].category !=
                                          null) {
                                    Get.toNamed(
                                        RouteHelper.getCategoryProductRoute(
                                            CategoryModel(
                                                id: bannerController
                                                    .bannerList[index]
                                                    .category)));
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: bannerController.bannerList.length,
                    autoplay: true,
                    itemWidth: MediaQuery.of(context).size.width,
                    itemHeight: MediaQuery.of(context).size.width * 0.4,
                    axisDirection: AxisDirection.right,
                    layout: SwiperLayout.STACK,
                    viewportFraction: 1,
                  ))
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                    child: GetBuilder<AuthController>(
                      builder: (splashController) {
                        return CustomImage(
                          image: '',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                );
    });
  }
}
