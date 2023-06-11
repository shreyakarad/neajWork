import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/view/screens/product/product_details_screen.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:get/get.dart';

class WishedProductWidget extends StatelessWidget {
  final int index;
  final ProductModel productModel;
  const WishedProductWidget ({Key key, this.productModel, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListController>(
      builder: (wishListController) {
        return GetBuilder<ProductController>(
          builder: (productController) {
           // productController.setExistInCart(productModel);
            return Padding(
              padding: EdgeInsets.all(0),
              child: InkWell(
                onTap: () async {
                  Get.toNamed(RouteHelper.getProductDetailsRoute(productModel.id ,'',false), arguments: ProductDetailsScreen(product: productModel, url: '',));
                },
                child: Container(
                  width: Dimensions.WEB_MAX_WIDTH,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(
                    children: [
                      Divider(),
                      Row (children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: wishListController.removedSelectedId.contains(productModel.id),
                              onChanged: (bool value) {
                                if(value){
                                  wishListController.setRemoveProductId(productModel.id);
                                } else {
                                  wishListController.removeSelectedRemoveId(productModel.id);
                                }}
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              child: CustomImage(height: 70, width: 70, image:  (productModel.images != [] || productModel.images != null) ?  productModel.images[0].src : ''),
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                          ],
                        ),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productModel.name, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.headlineSmall.color),
                                  maxLines: 2, overflow: TextOverflow.ellipsis),

                              Text(PriceConverter.convertPrice(productModel.price, taxStatus: productModel.taxStatus, taxClass: productModel.taxClass),
                                style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                              )
                            ]),
                        ),

                        // InkWell(
                        //   onTap: () {
                        //     productController.getProductDetails(productModel, notify: true);
                        //
                        //     showModalBottomSheet(context: context, isScrollControlled: true,
                        //         backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
                        //         builder: (con) =>
                        //         CartBottomSheet(product: productController.product,callback: (){
                        //           Get.back();
                        //           showCustomSnackBar('added_to_cart'.tr, isError: false);
                        //         }));
                        //   },
                        //   child: Container(
                        //     height: 32,
                        //     width: 32,
                        //     decoration: BoxDecoration(
                        //       color: Theme.of(context).cardColor,
                        //       borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        //     ),
                        //     child: Center(child: Image.asset(Images.appbar_cart, height: 17, width: 17)),
                        //   ),
                        // ),

                      ],
                    ),
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}
