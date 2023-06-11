import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/discount_tag.dart';
import 'package:flutter_woocommerce/view/base/rating_bar.dart';
import 'package:flutter_woocommerce/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/product_details_screen.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:flutter_woocommerce/view/screens/wish/wish_screen.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class WishProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return GetBuilder<WishListController>(builder: (wishListController) {
      return (wishListController.wishProductList != null && wishListController.wishProductList.length == 0) ? SizedBox() : Column(
        children: [
          TitleWidget(title: 'wished_products'.tr, onTap: () {
              Get.to(() => WishPage());
          }),

          SizedBox(
            height: 150,
            child: wishListController.wishProductList != null ? ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              //padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
              itemCount: wishListController.wishProductList.length > 10 ? 10 : wishListController.wishProductList.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        RouteHelper.getProductDetailsRoute(wishListController.wishProductList[index].id,'',false),
                        arguments: ProductDetailsScreen(product: wishListController.wishProductList[index], url: '',),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        boxShadow: [BoxShadow(
                          color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                          blurRadius: 5, spreadRadius: 1,
                        )],
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                        Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_SMALL)),
                            child: CustomImage(
                              image: wishListController.wishProductList[index].images != [] ? wishListController.wishProductList[index].images[0] : ' ',
                              height: 90, width: 130, fit: BoxFit.cover,
                            ),
                          ),
                          DiscountTag(
                            regularPrice: wishListController.wishProductList[index].regularPrice,
                            salePrice: wishListController.wishProductList[index].salePrice,
                          )]),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(
                                wishListController.wishProductList[index].name,
                                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),

                              Text(
                                wishListController.wishProductList[index].shortDescription,
                                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      PriceConverter.convertPrice(
                                        wishListController.wishProductList[index].price,
                                        taxStatus: wishListController.wishProductList[index].taxStatus,
                                        taxClass: wishListController.wishProductList[index].taxClass,
                                      ),
                                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                    ),
                                  ),
                                  Icon(Icons.star, color: Theme.of(context).primaryColor, size: 12),
                                  Text(
                                    wishListController.wishProductList[index].averageRating.toStringAsFixed(2),
                                    style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),

                            ]),
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
            ) : SaleProductShimmer(productController: wishListController),
          ),
        ],
      );
    });
  }
}

class SaleProductShimmer extends StatelessWidget {
  final WishListController productController;
  SaleProductShimmer({@required this.productController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index){
        return Container (
          height: 150,
          width: 130,
          margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300], blurRadius: 10, spreadRadius: 1)]
          ),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled: productController.wishProductList == null,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Container(
                height: 90, width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_SMALL)),
                    color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 10, width: 100, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: 5),

                    Container(height: 10, width: 130, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: 5),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(height: 10, width: 30, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                      RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                    ]),
                  ]),
                ),
              ),

            ]),
          ),
        );
      },
    );
  }
}
