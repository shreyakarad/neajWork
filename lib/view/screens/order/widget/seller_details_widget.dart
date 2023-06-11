import 'package:flutter_woocommerce/view/screens/order/model/order_model.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerDetailsWidget extends StatelessWidget {
  final OrderModel order;
  const SellerDetailsWidget({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
          border: Border.all(color: Theme.of(context).primaryColorLight.withOpacity(0.30)),
          color: Theme.of(context).cardColor
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: order.stores.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Column(
            children: [
              order.stores[index].shopName != '' ?
              orderBodyText( 'store_name'.tr , order.stores[index].shopName.capitalizeFirst) : SizedBox(),
              order.stores[index].address != null ?
              SizedBox( height: Dimensions.PADDING_SIZE_EXTRA_SMALL) : SizedBox(),

              order.stores[index].address != null ?
              orderBodyText( 'address'.tr , '${order.stores[index].address.street1} ${order.stores[index].address.street2} ${order.stores[index].address.street2 == '' ? '' : ','} '
                  '${order.stores[index].address.zip} ${order.stores[index].address.zip == '' ? '' : ','} ${order.stores[index].address.city} ${order.stores[index].address.city == '' ? '' : ','}'
                  ' ${order.billing.country}' ) : SizedBox(),
            ],
          );
        },
      ),

    );
  }
  Widget orderBodyText (String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: Text(title,maxLines: 1, overflow: TextOverflow.ellipsis ,
              style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(Get.context).hintColor))),
          SizedBox(
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(Get.context).primaryColor,), textAlign: TextAlign.end),
                ],
              ))


        ],
      ),
    );
  }
}
