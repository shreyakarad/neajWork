import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProductShimmer extends StatelessWidget {
  final bool isEnabled;
  final bool isRestaurant;
  final bool hasDivider;
  ProductShimmer({this.isEnabled, this.hasDivider, this.isRestaurant = false});

  @override
  Widget build(BuildContext context) {
    bool allProduct = true;
    return Padding(
      padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: SizedBox(
        width: allProduct? Get.width/2 : 135,
        child: Shimmer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: allProduct? 220 : 180,
                width: allProduct? Get.width/2 : 135,
                child: Stack(clipBehavior: Clip.none,
                  children: [

                    ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                        child: Container(
                          color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 350],
                          height: allProduct ? 205 : 160,
                          width: allProduct ? Get.width/2 : 150,
                        )
                    ),


                    Positioned(
                      top: allProduct? 185 : 135,
                      left: allProduct? 50 : 30,
                      right: allProduct? 50 : 30,
                      child: Image.asset(Images.extra,color: Theme.of(context).canvasColor),
                    ),

                    Positioned(
                      top: allProduct? 190 : 140,
                      left: 30,
                      right: 30,
                      child: Container(
                        height: allProduct ? 45 : 40,
                        width: allProduct ? 45 : 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300], shape: BoxShape.circle),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: allProduct? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_EXTRA_SMALL),


              Container(height: 12, width: 120, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 350]),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Container(height: 15, width: 80, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 350]),

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
    ) ;
  }
}
