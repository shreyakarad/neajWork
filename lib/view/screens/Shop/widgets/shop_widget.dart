import 'package:flutter_woocommerce/view/screens/Shop/model/shop_model.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/Shop/shop_screen.dart';
import 'package:get/get.dart';

class ShopWidget extends StatelessWidget {
  final ShopModel shop;
  final int index;
  final int length;
  ShopWidget({@required this.shop, @required this.index, @required this.length});

  @override
  Widget build(BuildContext context) {
    bool _desktop = ResponsiveHelper.isDesktop(context);

    return InkWell(
      onTap: () async {
        Get.to(ShopScreen(shop: shop));
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
                  tag: shop.id.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    child: CustomImage(
                      image: shop.banner,
                      height: _desktop ? 120 : 65, width: _desktop ? 120 : 80, fit: BoxFit.cover,
                    ),
                  ),
                ),
              ]),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                  Text(
                    shop.storeName,
                    style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                    maxLines: _desktop ? 2 : 1, overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    shop.address,
                    style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: _desktop ? 5 : 0),

                  RatingBar(
                    rating: shop.rating,
                    size: 12, ratingCount: null,
                  ),
                  SizedBox(height: _desktop ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),

                ]),
              ),

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
