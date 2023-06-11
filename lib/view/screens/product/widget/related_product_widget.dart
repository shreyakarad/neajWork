import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/discount_tag.dart';
import 'package:flutter_woocommerce/view/base/product_shimmer.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/view/screens/product/product_details_screen.dart';
import 'package:get/get.dart';

class RelatedProductWidget extends StatelessWidget {
  final ProductModel product;
  const RelatedProductWidget({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getProductDetailsRoute(product.id,'',false), arguments: ProductDetailsScreen(product: product, url: '',));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          boxShadow: [BoxShadow(
            color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
            blurRadius: 5, spreadRadius: 1,
          )],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_SMALL)),
              child: CustomImage(
                image: Get.find<ProductController>().getImageUrl(product.images),
                height: context.width/3.2, width: context.width/2, fit: BoxFit.cover,
              ),
            ),
            DiscountTag(regularPrice: product.regularPrice, salePrice: product.salePrice),
          ]),

          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  product.name,
                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        PriceConverter.convertPrice(product.price),
                        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                    ),
                    Icon(Icons.star, color: Theme.of(context).primaryColor, size: 12),
                    Text(
                      product.averageRating.toString(),
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ]),
            ),
          ),

        ]),
      ),
    );
  }
}

class RelatedProductShimmer extends StatelessWidget {
  final ProductController productController;
  const RelatedProductShimmer({Key key, @required this.productController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .58,
        mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL, crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
      ),
      itemCount: 5,
      shrinkWrap: true,
      padding: EdgeInsets.all(2),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ProductShimmer();

        /*Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(
              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
              blurRadius: 5, spreadRadius: 1,
            )],
          ),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled: productController.relatedProductList == null,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

              Container(
                height: context.width/3.2, width: context.width/2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_SMALL)),
                  color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                ),
              ),

              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 15, width: 150, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Row(
                      children: [
                        Expanded(
                          child: Container(height: 10, width: 70, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                        ),
                        Icon(Icons.star, color: Theme.of(context).primaryColor, size: 12),
                        Container(height: 10, width: 50, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                      ],
                    ),
                  ]),
                ),
              ),

            ]),
          ),
        );*/

      },
    );
  }
}

