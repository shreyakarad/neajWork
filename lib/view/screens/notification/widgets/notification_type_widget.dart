import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';

class NotificationType extends StatelessWidget {
  final String image;
  final String title;
  final int unSeenCount;
  final Function onTap;
  const NotificationType({Key key, this.image, this.title, this.unSeenCount, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(image, height: 25, width: 25),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Text(title, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
              ],
            ),

            Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).primaryColorLight),
          ],
        ),
      ),
    );
  }
}

