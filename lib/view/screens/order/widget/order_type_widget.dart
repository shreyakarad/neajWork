import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';

import 'package:get/get.dart';

class OrderTypeWidget extends StatelessWidget {
  final bool isSelected;
  final String type;
  final int index;

  const OrderTypeWidget({Key key, this.isSelected, this.type, this.index, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Container(
        child: Text(type.tr, style: DMSansBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: isSelected ? Theme.of(context).cardColor : Theme.of(context).textTheme.headlineMedium.color )),
        padding: EdgeInsets.symmetric( horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL ),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
          border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).primaryColorLight.withOpacity(0.30)),
        ),
      ),
    );
  }
}









