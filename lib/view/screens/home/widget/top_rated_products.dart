import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/view/screens/blog/widget/post_view_widget.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/discount_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/product_details_screen.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:get/get.dart';

class TopRatedProduct extends StatefulWidget {
  TopRatedProduct();
  @override
  State<TopRatedProduct> createState() => _TopRatedProductState();
}

class _TopRatedProductState extends State<TopRatedProduct> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      List<ProductModel> _productList = [];
      _productList = productController.reviewedProductList;

      return (_productList != null && _productList.isNotEmpty) ?
      Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('top_rated_product'.tr, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),

              Row(
                children: [
                  InkWell(
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        height: 30, width: 30,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: (productController.topProductIndex == 0) ? Theme.of(context).colorScheme.background.withOpacity(0.30) :
                        Theme.of(context).cardColor),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(Get.find<LocalizationController>().isLtr ? 10 : 0, 0, Get.find<LocalizationController>().isLtr ? 0 : 10, 0) ,
                          //Get.find<LocalizationController>().isLtr ? ,
                          child: Icon( Icons.arrow_back_ios, size: 20, color: Theme.of(context).primaryColor)),
                        //child: Icon( Get.find<LocalizationController>().isLtr ?  Icons.arrow_back_ios_new : Icons.arrow_forward_ios , size: 20, color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onTap: () {
                      if(productController.topProductIndex > 0) {
                        productController.setTopProductIndex(false);
                      }
                    },
                  ),

                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                  InkWell(
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        height: 30, width: 30,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: productController.topProductIndex == productController.reviewedProductList.length - 1 ?
                          Theme.of(context).colorScheme.background.withOpacity(0.30) : Theme.of(context).cardColor
                        ),
                        child:  Icon( Get.find<LocalizationController>().isLtr ? Icons.arrow_forward_ios_outlined : Icons.arrow_back_ios_new,  size: 20, color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onTap: () {
                      if( productController.topProductIndex != productController.reviewedProductList.length-1) {
                        productController.setTopProductIndex(true);
                      }
                    },
                  )
                ],
              )
            ]
            ),
          ),

          InkWell(
            onTap: (){
              Get.toNamed(
                RouteHelper.getProductDetailsRoute(_productList[productController.topProductIndex].id,'',false),
                arguments: ProductDetailsScreen(product: _productList[productController.topProductIndex], url: '',),
              );
            },
            child: SizedBox(
              height: 342,
              child: _productList != null ? Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Container (
                  width: Dimensions.WEB_MAX_WIDTH,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE), color: Theme.of(context).cardColor),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                        child: CustomImage(
                            image: productController.getImageUrl(_productList[productController.topProductIndex].images),
                            height: 342, width: Dimensions.WEB_MAX_WIDTH , fit: BoxFit.cover
                        ),
                      ),

                      DiscountTag(
                        regularPrice: _productList[productController.topProductIndex].regularPrice,
                        salePrice: _productList[productController.topProductIndex].salePrice,
                        inTop: true,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ],
                  ),
                ),
              ) : PopularFoodShimmer(enabled: _productList == null),
            ),
          ),


          Padding(
            padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, bottom: Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _productList[productController.topProductIndex??0].name,
                        style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeLarge, ),
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    GetBuilder<WishListController> (
                      builder: (wishListController) {
                        return InkWell(
                          onTap: () {
                            wishListController.addProductToWishlist(_productList[productController.topProductIndex]);
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                            child: Center(child: Icon(wishListController.wishIdList.contains(_productList[productController.topProductIndex].id) ?
                            Icons.favorite : Icons.favorite_border, color: wishListController.wishIdList.contains(_productList[productController.topProductIndex].id)?
                            Theme.of(context).primaryColor: Theme.of(context).hintColor)),
                          ),
                        );
                      }
                    )
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                Text(
                  PriceConverter.convertPrice(
                    _productList[productController.topProductIndex].price, taxStatus: _productList[productController.topProductIndex].taxStatus,
                    taxClass: _productList[productController.topProductIndex].taxClass,
                  ),
                  style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.red),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset( Images.rating, height: 15 ),
                        SizedBox( width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(_productList[productController.topProductIndex].averageRating.toString(),
                            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault,) ),
                      ],
                    ),

                    _productList[productController.topProductIndex].stockQuantity != null ?
                    Container(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: Text('in_stock'.tr + ' : ${_productList[productController.topProductIndex].stockQuantity}'),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                          color: Theme.of(context).colorScheme.background.withOpacity(0.50)
                      ),
                    ) : SizedBox()

                  ],
                ),
              ],
            ),
          ),
        ],
      ): SizedBox();
    });
  }
}



