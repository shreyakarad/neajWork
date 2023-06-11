import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/helper/product_type.dart';
import 'package:flutter_woocommerce/view/base/custom_shape.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/sale_product_shimmer.dart';
import 'package:flutter_woocommerce/view/screens/product/all_product_screen.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/product_details_screen.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:get/get.dart';

class SaleProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return GetBuilder<ProductController>(builder: (productController) {
      int pLength = productController.saleProductList != null ? productController.saleProductList.length > 3 ? 3 : productController.saleProductList.length : 0;

      return productController.saleProductList == null ?
      SaleProductShimmer(productController: productController) :
      (productController.saleProductList.length != null && productController.saleProductList.length == 0) ? SizedBox() :
      Column(
        children: [
          Container(decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          ),
            height: 150.0 * pLength,
            child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    topLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
              child: Stack(
                children: [
                  CustomPaint(
                    painter: OnSaleShape(),
                    size: Size(Get.width, 422),
                  ),
                  Column(
                    children: [
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0, Dimensions.PADDING_SIZE_DEFAULT,0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('on_sale_products'.tr, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.white)),
                          InkWell(
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              child: Container(
                                height: 30, width: 30,
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)),
                                    color: (productController.topProductIndex == 0) ? Theme.of(context).colorScheme.background.withOpacity(0.30) :
                                    Theme.of(context).cardColor),
                                //child: Image.asset(Images.right_button, height: 5),
                                child: Icon( Get.find<LocalizationController>().isLtr ? Icons.arrow_forward_ios_outlined : Icons.arrow_back_ios_new, size: 20, color: Theme.of(context).primaryColor)
                              ),
                            ),
                            onTap: () {
                              Get.to(()=> AllProductScreen(productType: ProductType.SALE_PRODUCT));
                            },
                          )]
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                      ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: productController.saleProductList.length > 3 ? 3 : productController.saleProductList.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,0,Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_DEFAULT),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  RouteHelper.getProductDetailsRoute(productController.saleProductList[index].id,'',false),
                                  arguments: ProductDetailsScreen(product: productController.saleProductList[index], url: '',),
                                );
                              },
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
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE)),
                                        child: CustomImage(
                                          image: productController.getImageUrl(productController.saleProductList[index].images),
                                          height: 90, width: 89, fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ]),

                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Text(
                                          productController.saleProductList[index].name,
                                          style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                                          maxLines: 1, overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                        Row(
                                          children: [
                                            Text(
                                              PriceConverter.convertPrice(
                                                productController.saleProductList[index].regularPrice,
                                              ),
                                              style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall,decoration: TextDecoration.lineThrough, color: Theme.of(context).hintColor),
                                            ),
                                            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                            Text(
                                              PriceConverter.convertPrice(
                                                productController.saleProductList[index].price,
                                                taxStatus: productController.saleProductList[index].taxStatus,
                                                taxClass: productController.saleProductList[index].taxClass,
                                              ),
                                              style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                            ),
                                          ],
                                        ),



                                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                        Row(
                                          children: [
                                            GetBuilder<WishListController>(
                                                builder: (wishController) {
                                                  return InkWell(
                                                      child: Center(child: Icon(wishController.wishIdList.contains(productController.saleProductList[index].id) ?
                                                      Icons.favorite:  Icons.favorite_border, color : wishController.wishIdList.contains(productController.saleProductList[index].id)?
                                                      Theme.of(context).primaryColor:
                                                      Theme.of(context).hintColor, size: 20)),
                                                      onTap: () {
                                                        Get.find<WishListController>().addProductToWishlist(productController.saleProductList[index]);
                                                      }
                                                  );
                                                }
                                            ),

                                            //Image.asset(Images.product_favorite, height: 20, width: 15),
                                            SizedBox(width : Dimensions.PADDING_SIZE_SMALL),
                                            // Image.asset(Images.product_cart, height: 20, width: 15),
                                          ],
                                        )

                                      ]),
                                    ),
                                  ),
                                ]),
                              ),
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
      );
    });
  }
}


//SaleProductShimmer(productController: productController)



// InkWell(
// onTap: () {
// wishController.addProductToWishlist(productModel);
// },
// child: Container(
// height: 32,
// width: 32,
// decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
// child: Center(child: Icon(wishController.wishIdList.contains(productModel.id)?
// Icons.favorite:  Icons.favorite_border, color : wishController.wishIdList.contains(productModel.id)?
// Theme.of(context).primaryColor:
// Theme.of(context).hintColor)),
// ),
// );
