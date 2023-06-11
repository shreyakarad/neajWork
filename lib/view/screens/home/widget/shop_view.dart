import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/view/base/title_widget.dart';
import 'package:flutter_woocommerce/view/screens/Shop/controller/shop_controller.dart';
import 'package:flutter_woocommerce/view/screens/Shop/widgets/shop_card_widget.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShopView extends StatelessWidget {
  ShopView();
  @override

  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(builder: (shopController) {

      ScrollController _scrollController = ScrollController();
      return (shopController.shopList != null && shopController.shopList.length == 0) ? SizedBox() :
      Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 2, Dimensions.PADDING_SIZE_DEFAULT, 10),
            child: TitleWidget(
              title: 'shops'.tr,
              onTap: () => Get.toNamed(RouteHelper.getAllShop()),
            ),
          ),

          SizedBox(
            height: 220,
            child:shopController.shopList != null ?
            ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
              itemCount: shopController.shopList.length > 10 ? 10 : shopController.shopList.length,
              itemBuilder: (context, index){
                return ShopCardWidget(shopModel: shopController.shopList[index]);
              },
            ) : PopularShopShimmer(),
          ),
        ],
      );
    });
  }
}

class PopularShopShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index){
        return Padding(
          padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: SizedBox(
            width: 135,
            child: Shimmer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: 135,
                    child: Stack(clipBehavior: Clip.none,
                      children: [

                        ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                            child: Container(
                              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 350],
                              height: 160,
                              width: 150,
                            )
                        ),

                        Positioned(
                          top: 135,
                          left: 30,
                          right: 30,
                          child: Image.asset(Images.extra,color: Theme.of(context).canvasColor),
                        ),

                        Positioned(
                          top: 140,
                          left: 30,
                          right: 30,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300], shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Container(height: 12, width: 120, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 350]),

                  // Text(
                  //   productModel.name,
                  //   style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                  //   maxLines: 1, overflow: TextOverflow.ellipsis,
                  // ),
                  // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  // Text(
                  //   PriceConverter.convertPrice(
                  //     productModel.price, taxStatus: productModel.taxStatus,
                  //     taxClass: productModel.taxClass,
                  //   ),
                  //   style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                  // ),
                  //SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

