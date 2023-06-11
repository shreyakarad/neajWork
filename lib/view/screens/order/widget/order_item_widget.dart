import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/order/model/order_model.dart';
import 'package:get/get.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel order;
  final LineItems item;
  final int index;
  OrderItemWidget({@required this.order, @required this.item, this.index});
  @override
  Widget build(BuildContext context) {
    if (order.couponLines != null) {
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.1), spreadRadius: 1,blurRadius: 5)]
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              child: CustomImage(
                height: 65, width: 65, fit: BoxFit.cover,
                image: item.image.src,
              ),
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item.name,
                        style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor), maxLines: 1, overflow: TextOverflow.ellipsis )
                    ),

                    // (_isLoggedIn && order.status == 'completed') ?
                    // InkWell(
                    //   child: Container(
                    //     padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    //     child: Text('give_review'.tr, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                    //       border: Border.all(color: Theme.of(context).primaryColorLight)
                    //     ),
                    //   ),
                    //   onTap: () {Get.toNamed(RouteHelper.getWriteReviewRoute(item));
                    //   },
                    // ) : SizedBox(),
                  ]
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                Text( PriceConverter.convertPrice((double.parse(item.subtotal) / item.quantity).toString()), style: DMSansBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor)),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    item.variationProducts != null ?
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: item.variationProducts.attributesArr.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Text(
                            '${item.variationProducts.attributesArr[index].name} : ${item.variationProducts.attributesArr[index].option}',
                            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColorDark),
                          );
                        },
                      ),
                    ) : SizedBox(),

                    Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Text('${'quantity'.tr} : ' + item.quantity.toString(),
                        style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        color: Get.isDarkMode ? Theme.of(context).cardColor : Theme.of(context).primaryColorLight.withOpacity(0.30),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          ]),
        ]),
      ),
    );
  }
}
