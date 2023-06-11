import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscountTag extends StatelessWidget {
  final String regularPrice;
  final String salePrice;
  final double fromTop;
  final double fontSize;
  final bool inLeft;
  final bool inTop;
  final double fromBottom;
  DiscountTag({
    @required this.regularPrice, @required this.salePrice, this.fromTop = 10, this.fontSize, this.inLeft = true, this.inTop = false, this.fromBottom,
  });

  @override
  Widget build(BuildContext context) {
    double _regularPrice = regularPrice.isNotEmpty ? double.parse(regularPrice) : 0;
    double _salePrice = salePrice.isNotEmpty ? double.parse(salePrice) : -1;
    double _percentage = (100 - (_salePrice/_regularPrice) * 100);
    String _newline = inTop ? ' ' : '\n';

    return (_salePrice != -1 && _salePrice < _regularPrice) ? Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Text(
        '${_percentage.toStringAsFixed(1)}%' + _newline + 'off'.tr,
        style: robotoMedium.copyWith(
          color: Colors.white,
          fontSize: fontSize != null ? fontSize : ResponsiveHelper.isMobile(context) ? 8 : 12,
        ),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL)),
      ),
    ) : SizedBox();
  }
}
