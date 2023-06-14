import 'package:flutter_woocommerce/view/base/product_card.dart';
import 'package:flutter_woocommerce/view/screens/Shop/model/shop_model.dart';
import 'package:flutter_woocommerce/view/screens/Shop/widgets/shop_card_widget.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter_woocommerce/view/base/product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductView extends StatelessWidget {
  final List<ProductModel> products;
  final List<ShopModel> shops;
  final EdgeInsetsGeometry padding;
  final bool isShop;
  final bool isScrollable;
  final int shimmerLength;
  final String noDataText;
  ProductView(
      {@required this.products,
      this.isScrollable = false,
      this.shimmerLength = 20,
      this.padding = const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      this.noDataText,
      this.shops,
      this.isShop = false});

  @override
  Widget build(BuildContext context) {
    bool _isNull = true;
    int _length = 0;
    if (isShop) {
      _isNull = shops == null;
      if (!_isNull) {
        _length = shops.length;
      }
    } else {
      _isNull = products == null;
      if (!_isNull) {
        _length = products.length;
      }
    }

    return !_isNull
        ? _length > 0
            ? GridView.builder(
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: isShop
                      ? .58
                      : Get.width < 400
                          ? .58
                          : .66,
                  crossAxisCount: isShop ? 2 : 2,
                ),
                physics: isScrollable
                    ? BouncingScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                shrinkWrap: isScrollable ? false : true,
                itemCount: _length,
                padding: padding,
                itemBuilder: (context, index) {
                  return isShop
                      ? AllShopCardWidget(shopModel: shops[index])
                      : ProductCard(
                          productModel: products[index],
                          allProduct: true,
                          index: index,
                          productList: products);
                },
              )
            : SizedBox(
                height: Get.context.height - 150,
                width: Get.context.width,
                child: NoDataScreen(
                    text: noDataText != null
                        ? noDataText
                        : isShop
                            ? 'no_shop_available'.tr
                            : 'no_product_available'.tr,
                    type: NoDataType.SEARCH))
        : GridView.builder(
            key: UniqueKey(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
              mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                  ? Dimensions.PADDING_SIZE_LARGE
                  : 0.05,
              childAspectRatio: .58,
              crossAxisCount: 2,
            ),
            physics: isScrollable
                ? BouncingScrollPhysics()
                : NeverScrollableScrollPhysics(),
            shrinkWrap: isScrollable ? false : true,
            itemCount: shimmerLength,
            padding: padding,
            itemBuilder: (context, index) {
              return ProductShimmer(
                  isEnabled: _isNull, hasDivider: index != shimmerLength - 1);
            },
          );
  }
}
