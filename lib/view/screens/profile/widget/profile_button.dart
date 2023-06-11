import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  ProfileButton({ this.title, this.image, this.subTitle });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(image, height: 25, width: 25),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  Text( title, style: DMSansBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                ],
              ),

              Flexible(child: Text(subTitle, style: DMSansMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                maxLines: 1, overflow: TextOverflow.ellipsis,)),
            ],
          )),
    );
  }
}
