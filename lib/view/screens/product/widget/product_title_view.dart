import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';

class ProductTitleView extends StatelessWidget {
  final ProductModel product;
  ProductTitleView({@required this.product});

  @override
  Widget build(BuildContext context) {
    double _startingPrice;
    double _startingDiscountedPrice;
    double _endingPrice;
    double _endingDiscountedPrice;
    bool _hasDiscount = false;
    if(product.variation.length != 0) {
      List<double> _priceList = [];
      List<double> _discountedPriceList = [];

      product.variation.forEach((variation) {
        if(variation.regularPrice != null && variation.regularPrice.toString().trim().isNotEmpty) {
          //if(variation.salePrice != null && variation.salePrice.toString().trim().isNotEmpty) {
            _priceList.add(double.parse(variation.regularPrice.toString()));
          //}
        }else {
          _priceList.add(0);
        }
      });

      product.variation.forEach((variation) {
        if( variation.salePrice.toString() != 'null') {
          _hasDiscount = true;
          _discountedPriceList.add(double.parse(variation.salePrice.toString()));
        } else if (variation.regularPrice != null){
          _discountedPriceList.add(double.parse(variation.regularPrice.toString()));
        }
      });


      // Get.find<ProductController>().variations.forEach((variation) {
      //   print('========${variation.toJson()}');
      //   if(variation.regularPrice != null && variation.regularPrice.trim().isNotEmpty) {
      //     _priceList.add(double.parse(variation.regularPrice));
      //   }else {
      //     _priceList.add(0);
      //   }
      // });
      // Get.find<ProductController>().variations.forEach((variation) {
      //   if(variation.salePrice.isNotEmpty) {
      //     _hasDiscount = true;
      //     _discountedPriceList.add(double.parse(variation.salePrice));
      //   }
      // });


      _priceList.sort((a, b) => a.compareTo(b));
      _discountedPriceList.sort((a, b) => a.compareTo(b));
      if(_priceList.length > 0) {
        _startingPrice = _priceList[0];
      }

      if(_discountedPriceList.length > 0) {
        _startingDiscountedPrice = _discountedPriceList[0];
      }
      if(_priceList.length > 0) {
      if(_priceList[0] < _priceList[_priceList.length-1]) {
        _endingPrice = _priceList[_priceList.length-1];
      }
      }
      if(_discountedPriceList.length > 0 && _discountedPriceList[0] < _discountedPriceList[_discountedPriceList.length-1]) {
        _endingDiscountedPrice = _discountedPriceList[_discountedPriceList.length-1];
      }
    }else {
      _hasDiscount = product.salePrice.isNotEmpty;
      _startingPrice = product.regularPrice != ''? double.parse(product.regularPrice.toString()) : 0;
      _startingDiscountedPrice = product.price != ''? double.parse(product.price):0;
    }



    return  GetBuilder<ProductController>(
      builder: (productController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(
              product.name ?? '',
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor),
              maxLines: 2, overflow: TextOverflow.ellipsis,
            )),
            InkWell(
              onTap: () {
                Get.find<WishListController>().addProductToWishlist(product);
              },
              child: GetBuilder<WishListController>(
                builder: (wishlistController) {
                  return Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                    child: Center(child: Icon(wishlistController.wishIdList.contains(product.id) ?
                    Icons.favorite:  Icons.favorite_border, color: wishlistController.wishIdList.contains(product.id)?
                    Theme.of(context).primaryColor:
                    Theme.of(context).hintColor)),
                  );
                }
              ),
            )
          ]),



          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _startingDiscountedPrice != null ? Text(
                      '${PriceConverter.convertPrice(
                        _hasDiscount ? _startingDiscountedPrice.toString() : _startingPrice.toString(),
                        taxStatus: product.taxStatus, taxClass: product.taxClass,
                      )}'

                      '${_endingPrice != null ? ' - ${PriceConverter.convertPrice(
                         _endingDiscountedPrice != null ? _endingDiscountedPrice.toString() : _endingPrice.toString(),
                        taxStatus: product.taxStatus, taxClass: product.taxClass,
                      )}' : ''}',
                      style: robotoBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),
                    ) : SizedBox(),
                    SizedBox(width: 5),

                    _hasDiscount ? Text(
                      '${PriceConverter.convertPrice(_startingPrice.toString(), taxStatus: product.taxStatus, taxClass: product.taxClass)}'
                      '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(_endingPrice.toString(), taxStatus: product.taxStatus, taxClass: product.taxClass)}' : ''}',
                      style: robotoRegular.copyWith(color: Theme.of(context).hintColor, decoration: TextDecoration.lineThrough),
                    ) : SizedBox(),
                  ],
                ),
              ],
            ),
          ),

          (product.manageStock && (product.stockQuantity != null && product.stockQuantity > 0)) ?
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 3),
            decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(100),
          ),child: Text('${'in_stock'.tr} : ${product.stockQuantity??0}',style: robotoRegular )) : SizedBox(),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, color: Colors.amber),
                SizedBox(width: 5),
                Text(double.parse(product.averageRating.toString()).toStringAsFixed(1), style: robotoRegular.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: Dimensions.fontSizeLarge,
                )),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                Text('${product.ratingCount.toString()} ${'reviews'.tr}', style: robotoRegular.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: Dimensions.fontSizeLarge,
                )),
              ],
            ),

            InkWell(
              child: Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Text('give_review'.tr, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),),
                decoration: BoxDecoration(
                    color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Colors.transparent,
                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                    border: Border.all(color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).primaryColorLight)
                ),
              ),
              onTap: () {Get.toNamed(RouteHelper.getWriteReviewRoute(product.id));
              },
            ),
          ]),

        ]);
      },
    );
  }
}
