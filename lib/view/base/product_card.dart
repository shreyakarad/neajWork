
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/view/base/discount_tag.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final bool allProduct;
  final ProductModel productModel;
  final int index;
  final List<ProductModel> productList;
  const ProductCard({Key key, this.productModel, this.allProduct = false, @required this.index, @required this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (product) {
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            Get.toNamed(
              RouteHelper.getProductDetailsRoute(productModel.id,'',false),
             // arguments: ProductDetailsScreen(product: productModel, url: '',),
            );
          },
          child: GetBuilder<ProductController>(
            builder: (productController) {
              return SizedBox(
                width: allProduct? Get.width/2 : 135,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: allProduct? 220 : 180,
                      width: allProduct? Get.width/2 : 135,
                      child: Stack(clipBehavior: Clip.none,
                        children: [

                          ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                            child: CustomImage(
                              image: productController.getImageUrl(productModel.images),
                              height: allProduct? 205 : 160,
                              width: allProduct? Get.width/2 : 150, fit: BoxFit.cover,
                            ),
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
                              decoration: BoxDecoration(color: Theme.of(context).primaryColorLight.withOpacity(.35), shape: BoxShape.circle),
                              child: Center(child: Image.asset(Images.product_cart, color: Theme.of(context).primaryColor, height: 25, width: 25)),
                            ),
                          ),

                          Positioned(
                              top: 5, right: 5,
                              child: GetBuilder<WishListController>(
                                builder: (wishController) {
                                  return InkWell(
                                    onTap: () {
                                      wishController.addProductToWishlist(productModel);
                                    },
                                    child: Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                                      child: Center(child: Icon(wishController.wishIdList.contains(productModel.id)?
                                      Icons.favorite:  Icons.favorite_border, color : wishController.wishIdList.contains(productModel.id)?
                                      Theme.of(context).primaryColor:
                                      Theme.of(context).hintColor)),
                                    ),
                                  );
                                }
                              )
                          ),

                          Positioned(
                            bottom: 25,left: 5,
                              child: DiscountTag(regularPrice: productModel.regularPrice, salePrice: productModel.salePrice)),

                        ],
                      ),
                    ),
                    SizedBox(height: allProduct? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Text(
                      productModel.name,
                      style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (productModel.regularPrice != productModel.price) ?
                        Text(PriceConverter.convertPrice( productModel.regularPrice, taxStatus: productModel.taxStatus, taxClass: productModel.taxClass ),
                            style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor, decoration: TextDecoration.lineThrough)) : SizedBox(),

                        (productModel.regularPrice != productModel.price) ? SizedBox(width: 3) : SizedBox(),

                        Text(PriceConverter.convertPrice(productModel.price, taxStatus: productModel.taxStatus, taxClass: productModel.taxClass ),
                            style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)),
                      ],
                    ),
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
