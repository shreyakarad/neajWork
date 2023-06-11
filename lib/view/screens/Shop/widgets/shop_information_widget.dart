import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/Shop/controller/shop_controller.dart';
import 'package:flutter_woocommerce/view/screens/Shop/model/shop_model.dart';
import 'package:get/get.dart';

class ShopInformationWidget extends StatelessWidget {
  final ShopController shopController;
  final ShopModel shop;
  const ShopInformationWidget({Key key, this.shopController, this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSize = 90;
    double reviewIconSize = 15;
    return shop != null?
    Padding(padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        children: [
          Row(crossAxisAlignment :CrossAxisAlignment.start, children: [
            Column(
              children: [
                Container(
                  transform: Matrix4.translationValues(0, 0, 0),
                  width: imageSize, height: imageSize,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.12), spreadRadius: 1, blurRadius: 5)],
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
                    child: shop.id == 1 ?
                    Image.asset(
                      Images.logo,
                      fit: BoxFit.fill,
                    ) : CustomImage(image: shop.gravatar),
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ],
            ),

            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),


            Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('${shop?.storeName ?? ''}',
                //   style: robotoBold.copyWith(
                //       fontSize: Dimensions.fontSizeDefault)),
                // SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: Dimensions.ICON_SIZE_DEFAULT,
                        child:Icon(Icons.place)),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                      child: Text(shop?.address != '' ? shop?.address : 'no_address_available'.tr,
                        style: robotoRegular.copyWith(), maxLines: 2,
                        overflow: TextOverflow.ellipsis,softWrap: false,),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: Dimensions.ICON_SIZE_DEFAULT,
                        child:Icon(Icons.call)),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                      child: Text( shop?.phone != '' ? shop?.phone : 'no_phone_number_available'.tr,
                        style: robotoRegular.copyWith(), maxLines: 2,
                        overflow: TextOverflow.ellipsis,softWrap: false,),
                    ),
                  ],
                ),
              ])),

          ]),

          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: Row(
              mainAxisAlignment: AppConstants.vendorType == VendorType.dokan ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
              children: [
                AppConstants.vendorType == VendorType.dokan ? Column(
                  children: [
                    Container(width: Dimensions.ICON_SIZE_SMALL, height: Dimensions.ICON_SIZE_SMALL,
                      child: Icon(Icons.star)),
                    SizedBox( height: Dimensions.PADDING_SIZE_EXTRA_SMALL ),

                    Text('${shop.rating.toDouble()?.toStringAsFixed(1) ?? ''}', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  ]) : SizedBox(),

                // Column(children: [
                //   Padding(
                //     padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                //     child: SizedBox(width: reviewIconSize,child: Image.asset(Images.my_reviews)),
                //   ),
                //   Row(children: [
                //     Text('${NumberFormat.compact().format(shop.re)}',
                //       style: robotoRegular.copyWith(
                //           fontSize: Dimensions.fontSizeDefault),),
                //     SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                //
                //     Text('reviews'.tr,
                //       style: robotoRegular.copyWith(
                //           fontSize: Dimensions.fontSizeDefault),),
                //   ],)
                // ]),

                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                    child: SizedBox(width: reviewIconSize,
                        child: Image.asset(Images.product_icon)),
                  ),
                  Row(children: [

                    Text(shopController.dokanProductList != null? shopController.dokanProductList.length.toString() : '0',
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault),),

                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),


                    Text('products'.tr,
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault),)
                  ],)
                ],)


            ],),
          )
        ],
      ),
    ):CircularProgressIndicator();
  }
}

