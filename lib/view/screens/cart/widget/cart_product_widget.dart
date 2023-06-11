import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductWidget extends StatelessWidget {
  final CartModel cart;
  final int cartIndex;
  CartProductWidget({@required this.cart, @required this.cartIndex});

  @override
  Widget build(BuildContext context) {
    // Get.find<ProductController>().getExistProductIndex(cart.id);
    String _variationText = '';
    // int _stock;
    if(cart.variation.length > 0) {
      List<String> _variationTypes = cart.variationText.split('-');
      if(_variationTypes.length == cart.variation.length) {
        int _index = 0;
        cart.variation.forEach((choice) {
          _variationText = _variationText + '${(_index == 0) ? '' : ',  '}${choice.attribute}: ${_variationTypes[_index]}';
          _index = _index + 1;
        });
      }else {
        _variationText = cart.variationText;
      }
    }
    String _price = cart.prices.price;
    if(cart.prices.currencyMinorUnit != null) {
      double _pr = double.parse(_price);
      for(int index=0; index<cart.prices.currencyMinorUnit; index++) {
        _pr /= 10;
      }
      _price = _pr.toString();
    }


    // _stock = cart.quantityLimits.maximum - Get.find<ProductController>().productCartQty;

    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      child: InkWell(
        onTap: () {
          Get.toNamed(RouteHelper.getProductDetailsRoute(cart.product.id,'',false));
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
          child: Stack(children: [
            Positioned(
              top: 0, bottom: 0, right: 0, left: 0,
              child: Icon(Icons.delete, color: Colors.white70, size: 50),
            ),
            Dismissible(
              key: UniqueKey(),
              onDismissed: (DismissDirection direction) => Get.find<CartController>().removeFromCart(cartIndex),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  boxShadow: [BoxShadow(
                    color: Colors.grey[Get.isDarkMode ? 800 : 200],
                    blurRadius: 5, spreadRadius: 1,
                  )],
                ),
                child: Column(
                  children: [
                    Row(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        child: CustomImage(
                          image: cart.variationImage != null ? cart.variationImage :Get.find<ProductController>().getImageUrl(cart.images),
                          height: 65, width: 70, fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(
                            cart.name,
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                            maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            PriceConverter.convertPrice(
                              _price, taxStatus: cart.product.taxStatus, taxClass: cart.product.taxClass,
                              fromCart: true,
                            ),
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                          ),
                        ]),
                      ),

                      InkWell(
                        onTap: null,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            cartIndex != -1 ? Row(children: [
                              QuantityButton(
                                onTap: () {
                                  if (cart.quantity > 1) {
                                    // Get.find<CartController>().setQuantity(false, cartIndex, cart.quantityLimits.maximum);
                                    Get.find<CartController>().setQuantity(false, cartIndex, cart.quantityLimits.maximum );
                                  }else {
                                    Get.find<CartController>().removeFromCart(cartIndex);
                                  }
                                },
                                isIncrement: false,
                              ),
                              Text(cart.quantity.toString(), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                              QuantityButton(
                                onTap: () => Get.find<CartController>().setQuantity(true, cartIndex, cart.quantityLimits.maximum),
                                isIncrement: true,
                              ),
                            ]) : Text('qnty'.tr + ': '+cart.quantity.toString()),
                          ]),
                        ),
                      ),

                      !ResponsiveHelper.isMobile(context) ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                        child: IconButton(
                          onPressed: () {
                            Get.find<CartController>().removeFromCart(cartIndex);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ) : SizedBox(),

                    ]),

                    (cart.variation.length > 0 && _variationText != '') ? Padding (
                      padding: EdgeInsets.only(top: 0),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        SizedBox(width: 80),
                        Text('${'variations'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
                        Flexible(child: Text(
                          _variationText,
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                        )),
                      ]),
                    ) : SizedBox(),

                    (cart.variation.length > 0 && _variationText != '') ? SizedBox( height: 6) : SizedBox(),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
