import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/order/model/order_model.dart';
import 'package:get/get.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  final int index;
  const OrderWidget({Key key, this.order, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Container(
        width: Dimensions.WEB_MAX_WIDTH,
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all( Radius.circular(Dimensions.RADIUS_SMALL)),
          border: Border.all(color: Theme.of(context).primaryColorLight.withOpacity(0.20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('order'.tr+'# '+'${order.id}',
                    style: robotoBold.copyWith( fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.headlineSmall.color)),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Text(PriceConverter.convertPrice(order.total), style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                Container(
                  decoration: BoxDecoration(
                    color: (order.status == 'pending' || order.status == 'processing') ? Colors.blue.withOpacity(0.15)  :
                    (order.status == 'cancelled' || order.status == 'failed') ? Colors.red.withOpacity(0.15)  :
                    order.status == 'completed' ? Colors.green.withOpacity(0.15) :
                    Theme.of(context).primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)
                  ),
                  height: 35,
                  width: 100,
                  child: Center(child: Text(order.status.tr,
                      style: robotoMedium.copyWith(
                          color: (order.status == 'pending' || order.status == 'processing') ? Colors.blue :
                          (order.status == 'cancelled' || order.status == 'failed') ? Colors.red.withOpacity(0.50)  :
                          order.status == 'completed' ? Colors.green :
                          Theme.of(context).primaryColor))),

                )
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    order.lineItems.length >= 1 ?
                    orderProductImage (order.lineItems[0].image.src) : SizedBox(),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    order.lineItems.length >= 2 ?
                    orderProductImage (order.lineItems[1].image.src) : SizedBox(),
                  ],
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                order.lineItems.length > 2 ?
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    order.lineItems.length >= 3 ?
                    orderProductImage ( order.lineItems[2].image.src) : SizedBox(),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    order.lineItems.length > 3 ?
                    Container(
                      height:49,
                      width: 49,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), border: Border.all(color: Theme.of(context).hintColor)),
                      child: Center(
                        child: Text( order.lineItems.length == 4 ? 'see'.tr : order.lineItems.length.toString(),
                          style: DMSansBold.copyWith( fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor))
                      )) : SizedBox(),
                  ],
                ) : SizedBox(),

              ],
            )
          ],
        )
      ),
    );
  }
}




Widget orderProductImage (String image){
  return ClipRRect(
    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
    child: CustomImage(
      height: 50,
      width: 50,
      image: image,
    ),
  );
}




