import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class SaleProductShimmer extends StatelessWidget {
  final ProductController productController;
  SaleProductShimmer({@required this.productController});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        children: [
          Container(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          ),
            height: 150.0 * 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  topLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0, Dimensions.PADDING_SIZE_DEFAULT,0),
                        
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Container(height: 25, width: 200, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                          
                          Container(
                            height: 30, width: 30,
                            decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(50)), color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                          )
                        ]
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: 3,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,0,Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_DEFAULT),
                            child: Container(
                              height: 110,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                              ),
                              child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                Stack(children: [
                                  Padding(
                                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                    child: Container( height: 90, width: 89,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT)
                                      ),
                                    )
                                  ),
                                ]),

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Container(height: 25, width: 200, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                      Container(height: 20, width: 100, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                      Row(
                                        children: [
                                          Image.asset(Images.product_favorite, height: 20, width: 15, color: Theme.of(context).hintColor,),
                                          SizedBox(width : Dimensions.PADDING_SIZE_SMALL),
                                         // Image.asset(Images.product_cart, height: 20, width: 15, color: Theme.of(context).hintColor),
                                        ],
                                      )

                                    ]),
                                  ),
                                ),
                              ]),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}