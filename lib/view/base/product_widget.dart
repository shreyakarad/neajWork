import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/discount_tag.dart';
import 'package:flutter_woocommerce/view/base/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/product_details_screen.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final int index;
  final int length;
  ProductWidget({@required this.product, @required this.index, @required this.length});

  @override
  Widget build(BuildContext context) {
    bool _desktop = ResponsiveHelper.isDesktop(context);

    return InkWell(
      onTap: () async {
        Get.toNamed(RouteHelper.getProductDetailsRoute(product.id ,'',false), arguments: ProductDetailsScreen(product: product, url: '',));
      },
      child: Container(
        padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL) : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          color: ResponsiveHelper.isDesktop(context) ? Theme.of(context).cardColor : null,
          boxShadow: ResponsiveHelper.isDesktop(context) ? [BoxShadow(
            color: Colors.grey[Get.isDarkMode ? 700 : 300], spreadRadius: 1, blurRadius: 5,
          )] : null,
        ),

        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(child: Padding(
            padding: EdgeInsets.symmetric(vertical: _desktop ? 0 : Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Row(children: [

              Stack(children: [
                Hero(
                  tag: product.id.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    child: CustomImage(
                      image: product.images !=[] ? product.images[0] : '',
                      height: _desktop ? 120 : 65, width: _desktop ? 120 : 80, fit: BoxFit.cover,
                    ),
                  ),
                ),
                DiscountTag(regularPrice: product.regularPrice, salePrice: product.salePrice),
              ]),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                  Text(
                    product.name,
                    style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                    maxLines: _desktop ? 2 : 1, overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    product.shortDescription ?? '',
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeExtraSmall,
                      color: Theme.of(context).disabledColor,
                    ),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: _desktop ? 5 : 0),

                  RatingBar(
                    rating: product.averageRating,
                    size: _desktop ? 15 : 12,
                    ratingCount: product.ratingCount,
                  ),
                  SizedBox(height: _desktop ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),

                  Row(children: [

                    Text(
                      PriceConverter.convertPrice(product.price, taxStatus: product.taxStatus, taxClass: product.taxClass),
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                    ),
                    SizedBox(width: product.salePrice.isNotEmpty ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),

                    product.salePrice.isNotEmpty ? Text(
                      PriceConverter.convertPrice(product.regularPrice, taxStatus: product.taxStatus, taxClass: product.taxClass),
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context).disabledColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ) : SizedBox(),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  ]),

                ]),
              ),

              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                Padding(
                  padding: EdgeInsets.symmetric(vertical: _desktop ? Dimensions.PADDING_SIZE_SMALL : 0),
                  child: Icon(Icons.add, size: _desktop ? 30 : 25),
                ),

                // GetBuilder<WishListController>(builder: (wishController) {
                //   bool _isWished = isRestaurant ? wishController.wishRestIdList.contains(restaurant.id)
                //       : wishController.wishProductIdList.contains(product.id);
                //   return InkWell(
                //     onTap: () {
                //       if(Get.find<AuthController>().isLoggedIn()) {
                //         _isWished ? wishController.removeFromWishList(isRestaurant ? restaurant.id : product.id, isRestaurant)
                //             : wishController.addToWishList(product, restaurant, isRestaurant);
                //       }else {
                //         showCustomSnackBar('you_are_not_logged_in'.tr);
                //       }
                //     },
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(vertical: _desktop ? Dimensions.PADDING_SIZE_SMALL : 0),
                //       child: Icon(
                //         _isWished ? Icons.favorite : Icons.favorite_border,  size: _desktop ? 30 : 25,
                //         color: _isWished ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                //       ),
                //     ),
                //   );
                // }),

              ]),

            ]),
          )),

          _desktop ? SizedBox() : Padding(
            padding: EdgeInsets.only(left: _desktop ? 130 : 90),
            child: Divider(color: index == length-1 ? Colors.transparent : Theme.of(context).disabledColor),
          ),

        ]),
      ),
    );
  }
}




// class ProductWidget extends StatelessWidget {
//   final ProductModel product;
//   final int index;
//   final int length;
//   ProductWidget({@required this.product, @required this.index, @required this.length});
//
//   @override
//   Widget build(BuildContext context) {
//     bool _desktop = ResponsiveHelper.isDesktop(context);
//
//     return InkWell(
//       onTap: () async {
//         await Get.find<WishListController>().getWished(product);
//         Get.toNamed(RouteHelper.getProductDetailsRoute(product.id ,'',false), arguments: ProductDetailsScreen(product: product));
//       },
//       child: Column(
//         children: [
//           Container(
//             height: 165,
//             width: 120,
//             color: Colors.red,
//             child: Stack(
//               children: [
//
//
//               ],
//             ),
//           ),
//         ],
//       )
//     );
//   }
// }