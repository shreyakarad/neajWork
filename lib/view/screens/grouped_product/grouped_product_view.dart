import 'package:flutter_woocommerce/view/base/title_widget.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'grouped_screen.dart';

class GroupedProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return GetBuilder<ProductController>(builder: (productController) {
      return (productController.groupedProduct != null &&
              productController.groupedProduct.length == 0)
          ? SizedBox()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,
                      7, Dimensions.PADDING_SIZE_DEFAULT, 0),
                  child: TitleWidget(
                    title: 'grouped_product'.tr,
                    onTap: () {
                      Get.to(() => GroupedScreen());
                    },
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 170,
                        child: productController.groupedProduct != null
                            ? ListView.builder(
                                controller: _scrollController,
                                itemCount:
                                    productController.groupedProduct.length > 15
                                        ? 15
                                        : productController
                                            .groupedProduct.length,
                                padding: EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_SMALL),
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: InkWell(
                                      onTap: () => Get.toNamed(
                                          RouteHelper.getGroupedProductRoute(
                                              productController
                                                  .groupedProduct[index])),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_LARGE),
                                        child: SizedBox(
                                          width: 130,
                                          child: Stack(children: [
                                            Container(
                                              color:
                                                  Theme.of(context).cardColor,
                                              height: 163,
                                              width: 135,
                                              margin: EdgeInsets.all(1),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .RADIUS_DEFAULT),
                                                child: CustomImage(
                                                  image: productController
                                                      .getImageUrl(
                                                          productController
                                                              .groupedProduct[
                                                                  index]
                                                              .images),
                                                  height: 57,
                                                  width: 57,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            Positioned(
                                                bottom: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  height: 30,
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.70),
                                                    borderRadius: BorderRadius.only(
                                                        bottomLeft: Radius
                                                            .circular(Dimensions
                                                                .RADIUS_DEFAULT),
                                                        bottomRight: Radius
                                                            .circular(Dimensions
                                                                .RADIUS_DEFAULT)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                        productController
                                                            .groupedProduct[
                                                                index]
                                                            .name,
                                                        style: poppinsRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeDefault,
                                                            color: Theme.of(
                                                                    context)
                                                                .cardColor,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)),
                                                  ),
                                                )),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : GroupedProductShimmer(
                                productController: productController),
                      ),
                    ),
                  ],
                ),
              ],
            );
    });
  }
}

class GroupedProductShimmer extends StatelessWidget {
  final ProductController productController;
  GroupedProductShimmer({@required this.productController});

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
              enabled: productController.groupedProduct == null,
              child: Column(children: [
                Container(
                  height: 57,
                  width: 57,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  ),
                ),
                SizedBox(height: 3),
                Container(height: 7, width: 45, color: Colors.grey[300]),
              ]),
            ),
          );
        },
      ),
    );
  }
}
