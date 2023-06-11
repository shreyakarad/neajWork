import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:get/get.dart';

class CartBottomSheet extends StatefulWidget {
  final ProductModel product;
  final Function callback;
  final bool fromOrder;
  CartBottomSheet({this.callback, this.product, this.fromOrder = false});

  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {

  route(bool isRoute, String message) async {
    if (isRoute) {
      showCustomSnackBar(message, isError: false);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      showCustomSnackBar(message);

    }
  }
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Get.find<ProductController>().calculateProductPrice( Get.find<ProductController>().product );

    return GetBuilder<ProductController>(
      builder: (productController) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                ),
                child: GetBuilder<ProductController>(
                  builder: (productController) {
                    // productController.filterOp( 0, 0 );
                    productController.createProductCartModel( productController.product, (productController.cartIndex != -1 && widget.fromOrder));

                    // int _stock;
                    // CartModel _cartModel;
                    // double _priceWithQuantity = 0;
                    // String variationImage;
                    // int variationRegPrice;
                    // bool variationStock = false;
                    // int variationStockQty;
                    //
                    // if(productController.product != null && productController.variationIndex != null) {
                    //   List<String> _variationList = [];
                    //
                    //   if(productController.product.variation.isNotEmpty){
                    //   for (int index = 0; index < productController.variationAttributes.length; index++) {
                    //     if(productController.variationAttributes.isNotEmpty) {
                    //       _variationList.add(productController.variationAttributes[index].options[productController.variationIndex[index]].replaceAll(' ', ''));
                    //     }
                    //   }
                    //  }
                    //
                    //   String variationType = '';
                    //   bool isFirst = true;
                    //   _variationList.forEach((variation){
                    //     if (isFirst) {
                    //       variationType = '$variationType${variation.toLowerCase()}';
                    //       isFirst = false;
                    //     } else {
                    //       variationType = '$variationType-${variation.toLowerCase()}';
                    //     }
                    //   });
                    //
                    //   double price = productController.product.regularPrice != ''? double.parse(productController.product.regularPrice ?? '0'):0;
                    //   double priceWithDiscount = productController.product.price != '' ? double.parse(productController.product.price) : 0;
                    //   int _id = productController.product.id;
                    //
                    //   if (productController.product.stockQuantity != null) {
                    //     _stock = productController.product.stockQuantity - productController.productCartQty;
                    //   }
                    //   for (int index=0; index< productController.product.variation.length; index++) {
                    //
                    //     if (variationType == productController.product.variation[index].variation) {
                    //       print(productController.product.variation[index].variation);
                    //       price = productController.product.variation[index].regularPrice.toString() != ''? double.parse(productController.product.variation[index].regularPrice.toString()) : 0;
                    //       priceWithDiscount = productController.product.variation[index].price.toString() != ''? double.parse(productController.product.variation[index].price.toString()) : 0;
                    //       _id = productController.product.variation[index].id;
                    //       if (productController.product.variation[index].variationImage.src != null) {
                    //         variationImage = productController.product.variation[index].variationImage.src;
                    //       }
                    //       if(productController.product.variation[index].regularPrice != null) {
                    //         variationRegPrice = productController.product.variation[index].regularPrice * productController.quantity;
                    //       }
                    //       if(productController.product.variation[index].manageStock != null) {
                    //         variationStock = productController.product.variation[index].manageStock;
                    //       }
                    //
                    //       if(productController.product.variation[index].stockQuantity != null) {
                    //         variationStockQty = productController.product.variation[index].stockQuantity;
                    //       }
                    //       break;
                    //     } else {
                    //       variationImage = null;
                    //       variationRegPrice = null;
                    //       variationStock = false;
                    //       variationStockQty = null;
                    //     }
                    //   }
                    //
                    //   List<Variation> _variations = [];
                    //   for(int index=0; index< productController.product.attributes.length; index++) {
                    //     if(productController.product.variation.isNotEmpty) {
                    //       if (productController.product.attributes.isNotEmpty) {
                    //         _variations.add(Variation(
                    //           attribute: productController.product
                    //               .attributes[index].name,
                    //           value: productController.product.attributes[index]
                    //               .options[productController
                    //               .variationIndex[index]],
                    //         ));
                    //       }
                    //     }
                    //   }
                    //
                    //   _priceWithQuantity = priceWithDiscount * productController.quantity;
                    //
                    //   _cartModel = CartModel(
                    //     id: _id, quantity: productController.quantity, quantityLimits: QuantityLimits(minimum: 1, maximum: variationStock ? variationStockQty : _stock),
                    //     name: productController.product.name, shortDescription: productController.product.shortDescription,
                    //     description: productController.product.description, sku: productController.product.sku,
                    //     images: productController.product.images != [] ? productController.product.images : [], variation: _variations, variationText: variationType,
                    //     prices: Prices(price: priceWithDiscount.toString(), regularPrice: price.toString(), salePrice: priceWithDiscount.toString()),
                    //     product: productController.product, variationImage: variationImage,
                    //   );
                    //
                    //   if(!productController.product.manageStock) {
                    //     _stock = null;
                    //   }
                    // }

                    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Align(alignment: Alignment.topCenter, child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Theme.of(context).hintColor.withOpacity(.5),
                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                            ),
                          ),
                        ),
                      )),

                      Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: 100, height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: .5,color: Theme.of(context).primaryColor.withOpacity(.20))
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CustomImage(image: productController.variationImage != null ? productController.variationImage : productController.getImageUrl(widget.product.images))
                                )),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(productController.product.name ?? '',
                                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                                      maxLines: 3, overflow: TextOverflow.ellipsis),
                                ])),

                              Container(width: 35,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(.1),
                                  border: Border.all(width: .25, color: Theme.of(context).hintColor),
                                  borderRadius: BorderRadius.circular(50)),
                                child: Column(children: [
                                  InkWell(
                                    onTap : () {
                                      if(!productController.variationStock && productController.product.manageStock && productController.stock == null) {
                                        Get.back();
                                        showCustomSnackBar('out_of_stock'.tr);
                                      }else if (productController.variationStock && productController.variationStockQty == null) {
                                        Get.back();
                                        showCustomSnackBar('out_of_stock'.tr);
                                      }else if( widget.fromOrder && productController.cartIndex != -1) {
                                        print(productController.stock);
                                        productController.setQuantity( true, productController.stock, isOrderNow : true);
                                      } else if(productController.cartIndex != -1 ) {
                                        Get.find<CartController>().setQuantity(true, productController.cartIndex, productController.variationStock ? productController.variationStockQty : productController.stock, fromBottomSheet: true);
                                      }else {
                                        productController.setQuantity(true, productController.variationStock ? productController.variationStockQty : productController.stock);
                                      }
                                    },
                                   // onTap: () => productController.cartIndex != -1 ? Get.find<CartController>().setQuantity(true, productController.cartIndex, variationStock ? variationStockQty : _stock, fromBottomSheet: true) :  productController.setQuantity(true, variationStock ? variationStockQty : _stock),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Icon(Icons.add_circle_outline, size: Dimensions.ICON_SIZE_DEFAULT, weight: .1),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
                                    child: GetBuilder<CartController>(builder: (cartController) {
                                      return Text(
                                          (widget.fromOrder && productController.cartIndex != -1) ? productController.orderNowQuantity.toString() : productController.cartIndex != -1 ? cartController.cartList[productController.cartIndex].quantity.toString() : productController.quantity.toString(),
                                        style:robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                                      );
                                    }),
                                  ),

                                  InkWell(
                                    onTap: () {
                                      if(widget.fromOrder && productController.cartIndex != -1 && productController.orderNowQuantity> 1) {
                                        productController.setQuantity(false, productController.variationStock ? productController.variationStockQty : productController.stock, isOrderNow : true);
                                      }
                                      else if(productController.cartIndex != -1) {
                                        if(Get.find<CartController>().cartList[productController.cartIndex].quantity > 1) {
                                          Get.find<CartController>().setQuantity(false, productController.cartIndex, productController.variationStock ? productController.variationStockQty : productController.stock, fromBottomSheet: true);
                                        }
                                      }else {
                                        if(productController.quantity > 1) {
                                          productController.setQuantity(false, productController.variationStock ? productController.variationStockQty : productController.stock);
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Icon(Icons.remove_circle_outline, size: Dimensions.ICON_SIZE_DEFAULT, weight: .1,),
                                    ),
                                  ),
                                ]),
                              ),

                          ]),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: Row(
                              children: [
                                Text(
                                  '${PriceConverter.convertPrice(
                                    productController.hasDiscount ? productController.startingDiscountedPrice.toString() : productController.startingPrice.toString(),
                                    taxStatus: widget.product.taxStatus, taxClass: widget.product.taxClass,
                                  )}'
                                      '${productController.endingPrice!= null ? ' - ${PriceConverter.convertPrice(
                                    productController.endingDiscountedPrice != null ? productController.endingDiscountedPrice.toString() : productController.endingPrice.toString(),
                                    taxStatus: widget.product.taxStatus, taxClass: widget.product.taxClass,
                                  )}' : ''}',
                                  style: robotoBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),
                                ),
                                SizedBox(width: 5),

                                productController.hasDiscount ? Text(
                                  '${PriceConverter.convertPrice(productController.startingPrice.toString(), taxStatus: widget.product.taxStatus, taxClass: widget.product.taxClass)}'
                                      '${productController.endingPrice!= null ? ' - ${PriceConverter.convertPrice(productController.endingPrice.toString(), taxStatus: widget.product.taxStatus, taxClass: widget.product.taxClass)}' : ''}',
                                  style: robotoRegular.copyWith(color: Theme.of(context).hintColor, decoration: TextDecoration.lineThrough),
                                ) : SizedBox(),
                              ],
                            ),
                          ),
                          // Variation
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: productController.variationAttributes.length,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return productController.variationAttributes[index].options.isNotEmpty ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(productController.variationAttributes[index].name.capitalizeFirst, style:robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: (1 / 0.25),
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: productController.variationAttributes[index].options.length,
                                  itemBuilder: (context, i) {
                                    return InkWell(
                                      onTap: () {
                                        productController.setCartVariationIndex(index, i, productController.product);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                        decoration: BoxDecoration(
                                          color: productController.variationIndex[index] != i ? Theme.of(context).disabledColor : Get.isDarkMode ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(5),
                                          border: productController.variationIndex[index] != i ? Border.all(color: Theme.of(context).disabledColor, width: 2) : null,
                                        ),
                                        child: Text(
                                          productController.variationAttributes[index].options[i].trim(), maxLines: 1, overflow: TextOverflow.ellipsis,
                                          style:robotoRegular.copyWith(
                                            color: productController.variationIndex[index] != i ? Colors.black : Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: index != productController.product.attributes.length-1 ? Dimensions.PADDING_SIZE_LARGE : 0),
                              ]) : SizedBox();
                            },
                          ),
                          productController.product.attributes.length > 0 ? SizedBox(height: Dimensions.PADDING_SIZE_LARGE) : SizedBox(),
                          // TextButton(
                          //   onPressed: (){
                          //     print(productController.variationIndex.toString());
                          //   },
                          //   child: Text('---Hello---')
                          // ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        ],
                      ),


                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                     (widget.fromOrder || productController.cartIndex == -1 || productController.cartIndex != -1) ?
                      Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${'total'.tr}', style:robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                              Row(children: [
                                Text('${'price'.tr}', style:robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                productController.variationRegPrice == productController.priceWithQuantity ? SizedBox() : productController.variationRegPrice != null ?
                                Text(PriceConverter.convertPrice(productController.variationRegPrice.toString() ?? 0.0), style: robotoRegular.copyWith(
                                  color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault, decoration: TextDecoration.lineThrough
                                )) : SizedBox(),
                                productController.variationRegPrice == productController.priceWithQuantity ? SizedBox() :SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                Text(PriceConverter.convertPrice(productController.priceWithQuantity.toString() ?? 0.0), style:robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge,
                                )),
                              ]),
                            ],
                          ),
                        ),


                        SizedBox(width: 150,height: 40,
                          child: CustomButton(
                            radius: 100,
                              buttonText: widget.fromOrder ?  'order_now'.tr : productController.cartIndex == -1  ? 'add_to_cart'.tr : 'update_cart'.tr,
                              onPressed : () {
                                if (productController.variationStock) {
                                  if(productController.variationStockQty != null && productController.variationStockQty > 0) {
                                    if (widget.fromOrder) {
                                      Get.toNamed(RouteHelper.getCartRoute(cartModel: productController.cartModel, fromOrder : widget.fromOrder));
                                    } else if(productController.cartIndex == -1) {
                                      Get.back();
                                      Get.find<CartController>().addToCart(productController.cartModel, productController.cartIndex);
                                    } else{
                                      Get.back();
                                    }
                                  } else {
                                    Get.back();
                                    showCustomSnackBar('out_of_stock'.tr);
                                  }
                                }
                                else {
                                  if(productController.product.manageStock) {
                                    if(productController.stock != null && productController.stock > 0) {
                                      if (widget.fromOrder) {
                                        Get.toNamed(RouteHelper.getCartRoute(cartModel: productController.cartModel, fromOrder: widget.fromOrder));
                                      } else if(productController.cartIndex == -1) {
                                        Get.back();
                                        Get.find<CartController>().addToCart(productController.cartModel, productController.cartIndex);
                                      } else{
                                        Get.back();
                                      }
                                    } else {
                                      Get.back();
                                      showCustomSnackBar('out_of_stock'.tr);
                                    }
                                  } else {
                                    if(widget.fromOrder) {
                                      Get.toNamed(RouteHelper.getCartRoute(cartModel: productController.cartModel, fromOrder: widget.fromOrder));
                                    }else if(productController.cartIndex == -1) {
                                      Get.back();
                                      Get.find<CartController>().addToCart(productController.cartModel, productController.cartIndex);
                                    }else{
                                      Get.back();
                                    }
                                  }
                                }
                              },
                          ),
                        ),
                       // SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                      ]) :  SizedBox(),
                    ]);
                  },
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}




