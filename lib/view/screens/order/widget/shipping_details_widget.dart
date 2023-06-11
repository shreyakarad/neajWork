import 'package:flutter_woocommerce/view/screens/order/model/order_model.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingDetailsWidget extends StatelessWidget {
  final OrderModel order;
  const ShippingDetailsWidget({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
          border: Border.all(color: Theme.of(context).primaryColorLight.withOpacity(0.30)),
          color: Theme.of(context).cardColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(),
          order.shipping.phone != '' ?
          orderBodyText( 'delivery_contact'.tr, order.shipping.phone ) : SizedBox(),

          order.shipping.phone != '' ?
          SizedBox( height: Dimensions.PADDING_SIZE_EXTRA_SMALL) : SizedBox(),


          order.shipping.country != '' ?
          orderBodyText( 'delivery_address'.tr, '${order.shipping.address1} ${order.shipping.address2}, ${order.shipping.city}, ${order.shipping.state}, ${order.shipping.country}') : SizedBox(),

          order.shipping.country != '' ?
          SizedBox( height: Dimensions.PADDING_SIZE_EXTRA_SMALL) : SizedBox(),

          order.billing.country != '' ?
          orderBodyText( 'billing_address'.tr, '${order.billing.address1} ${order.billing.address2}, ${order.billing.city}, ${order.billing.state}, ${order.billing.country}') : SizedBox(),
          order.billing.country != '' ?
          SizedBox( height: Dimensions.PADDING_SIZE_EXTRA_SMALL) : SizedBox(),
        ],
      ),
    );
  }
  Widget orderBodyText (String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(child: Text(title, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(Get.context).hintColor))),
        SizedBox(
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(value, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(Get.context).primaryColor), textAlign: TextAlign.end),
              ],
        ))
      ],
    );
  }
}
