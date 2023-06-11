import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter/material.dart';

enum NoDataType {
  CART,
  NOTIFICATION,
  ORDER,
  COUPON,
  OTHERS,
  WISH,
  SEARCH,
  PAGES
}

class NoDataScreen extends StatelessWidget {
  final NoDataType type;
  final String text;
  NoDataScreen({@required this.text, this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Column( mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(),
        Image.asset(
          (type == NoDataType.CART)
              ? Images.empty_cart
              : type == NoDataType.COUPON
              ? Images.empty_coupon:
                type == NoDataType.PAGES
              ? Images.no_pages_found
              : type == NoDataType.NOTIFICATION
              ? Images.no_notification_found
              : type == NoDataType.ORDER
              ? Images.no_order_found
              : type == NoDataType.WISH
              ? Images.empty_wishlist
              : type == NoDataType.SEARCH
              ? Images.no_search_found
              : Images.no_internet,
          width: MediaQuery.of(context).size.height * 0.20,
          height: MediaQuery.of(context).size.height * 0.20,
        ),

        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

        Text(text,
          style: robotoMedium.copyWith(fontSize: MediaQuery.of(context).size.height*0.0175, color: Theme.of(context).disabledColor),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
