import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/Shop/controller/shop_controller.dart';
import 'package:flutter_woocommerce/view/screens/Shop/model/shop_model.dart';
import 'package:flutter_woocommerce/view/screens/Shop/shop_screen.dart';
import 'package:get/get.dart';


class ShopCardWidget extends StatelessWidget {
  final ShopModel shopModel;
  const ShopCardWidget({Key key, this.shopModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
      child: InkWell(
        onTap: () {
          Get.to(ShopScreen(shop: shopModel));
        },
        child: SizedBox(
          width: 120,
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL)),
                    child: shopModel.id ==1 ?
                    Image.asset(
                      Images.logo,
                      height : 160,
                      width: 120,
                      fit: BoxFit.cover,
                    ) :
                    CustomImage(
                      image: shopModel.gravatar,
                      height: 160, width: 120, fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(bottom: -1, left: 20, right: 20, child: Image.asset(Images.extra, color: Theme.of(context).canvasColor)),

                ]),

                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        shopModel.storeName ?? '',
                        style: robotoBold.copyWith(color: Theme.of(context).primaryColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                  ),
                ),

              ]),
              Positioned(
                bottom: 35,left: 40,right: 40,
                child: Container(
                  width: 70,height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Theme.of(context).primaryColor.withOpacity(.1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Image.asset(Images.shop, color: Theme.of(context).primaryColor),
                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class AllShopCardWidget extends StatelessWidget {
  final bool allProduct;
  //final int index;
  final ShopModel shopModel;
  const AllShopCardWidget({Key key, this.allProduct = false, this.shopModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      builder: (product) {
        return InkWell(
          onTap: () {
            Get.to(ShopScreen(shop: shopModel));
          },
          child: GetBuilder<ShopController>(
            builder: (productController) {
              return SizedBox(
                width: allProduct? Get.width/2 : 135,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 220,
                      width: Get.width/2,
                        child: Stack(clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                              child: shopModel.id ==1 ? Image.asset(
                                Images.logo,
                                height : 205,
                                width: Get.width / 2,
                                fit: BoxFit.fill,
                              ) :
                              CustomImage(
                                image: shopModel.gravatar,
                                height: 205,
                                width: Get.width/2, fit: BoxFit.cover,
                              ),
                            ),

                            Positioned(
                              top: 185,
                              left: 50,
                              right: 50,
                              child: Image.asset(Images.extra,color: Theme.of(context).canvasColor),
                            ),
                            Positioned(
                              top: 190,
                              left: 30,
                              right: 30,
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(color: Theme.of(context).primaryColorLight.withOpacity(.35), shape: BoxShape.circle),
                                child: Center(child: Image.asset(Images.shop, height: 25, width: 25)),
                              ),
                            ),

                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE ),

                        Text(
                          shopModel.storeName ?? '',
                          style: robotoBold.copyWith(color: Theme.of(context).primaryColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                        // Text(PriceConverter.convertPrice( productModel.price, taxStatus: productModel.taxStatus, taxClass: productModel.taxClass ),
                        //   style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)),

                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      ],
                    ),
                  );
                }
            ),
          );
        }
    );
  }
}
