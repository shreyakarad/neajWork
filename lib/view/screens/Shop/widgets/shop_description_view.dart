import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/Shop/model/shop_model.dart';
import 'package:get/get.dart';

class ShopDescriptionView extends StatelessWidget {
  final ShopModel shop;
  ShopDescriptionView({@required this.shop});

  @override
  Widget build(BuildContext context) {
    Color _textColor = ResponsiveHelper.isDesktop(context) ? Colors.white : null;
    return Column(children: [
      Row(children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          child: Stack(children: [
            CustomImage(
              image: shop.gravatar,
              height: ResponsiveHelper.isDesktop(context) ? 80 : 60, width: ResponsiveHelper.isDesktop(context) ? 100 : 70, fit: BoxFit.cover,
            ),

          ]),
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            shop.storeName, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: _textColor),
            maxLines: 1, overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          Text(
            "Dhaka,BD" ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
          ),
          SizedBox(height: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),
        ])),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

        ResponsiveHelper.isDesktop(context) ? InkWell(
          //onTap: () => Get.toNamed(RouteHelper.getSearchRestaurantProductRoute(restaurant.id)),
          child: ResponsiveHelper.isDesktop(context) ? Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT), color: Theme.of(context).primaryColor),
            child: Center(child: Icon(Icons.search, color: Colors.white)),
          ) : Icon(Icons.search, color: Theme.of(context).primaryColor),
        ) : SizedBox(),
        SizedBox(width: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_SMALL : 0),

/*        GetBuilder<WishListController>(builder: (wishController) {
          bool _isWished = wishController.wishRestIdList.contains(restaurant.id);
          return InkWell(
            onTap: () {
              if(Get.find<AuthController>().isLoggedIn()) {
                _isWished ? wishController.removeFromWishList(restaurant.id, true)
                    : wishController.addToWishList(null, restaurant, true);
              }else {
                showCustomSnackBar('you_are_not_logged_in'.tr);
              }
            },
            child: ResponsiveHelper.isDesktop(context) ? Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT), color: Theme.of(context).primaryColor),
              child: Center(child: Icon(_isWished ? Icons.favorite : Icons.favorite_border, color: Colors.white)),
            ) :Icon(
              _isWished ? Icons.favorite : Icons.favorite_border,
              color: _isWished ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
            ),
          );
        }),*/

      ]),
      SizedBox(height: ResponsiveHelper.isDesktop(context) ? 30 : Dimensions.PADDING_SIZE_SMALL),

      Row(children: [
        Expanded(child: SizedBox()),
        InkWell(
          //onTap: () => Get.toNamed(RouteHelper.getRestaurantReviewRoute(restaurant.id)),
          child: Column(children: [
            Row(children: [
              Icon(Icons.star, color: Theme.of(context).primaryColor, size: 20),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(
                 shop.rating.toString(),
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor),
              ),
            ]),
            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          ]),
        ),

        Expanded(child: SizedBox()),
        InkWell(
          onTap: (){
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: Text('shop_location'.tr),
                  content: Text(shop.address, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor)),
                  actions: [
                    TextButton(
                      child: Text('close'.tr),
                      onPressed: () {Navigator.of(context).pop();},
                    )
                  ],
                );
              });
          },
          child: Column(children: [
            Icon(Icons.location_on, color: Theme.of(context).primaryColor, size: 20),
            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text('location'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor)),
          ]),
        ),
        Expanded(child: SizedBox()),
      ]),
    ]);
  }
}
