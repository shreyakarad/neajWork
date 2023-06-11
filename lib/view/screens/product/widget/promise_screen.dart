import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:get/get.dart';

class PromiseScreen extends StatelessWidget {
  const PromiseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
        boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.2), spreadRadius: 1, blurRadius: 5)]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(child: PromiseCardItem(title: 'seven_days_return',icon: Images.seven_day_easy_return)),
          // SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

          Expanded(child: PromiseCardItem(title: 'safe_payment',icon: Images.safe_payment)),
          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),

          Expanded(child: PromiseCardItem(title: 'authentic_product',icon: Images.hundred_par_authentic)),
        ],
      ),
    );
  }
}

class PromiseCardItem extends StatelessWidget {
  final String icon;
  final String title;
  const PromiseCardItem({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(width: 40, child: Image.asset(icon),),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
      Text(title.tr,
        maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),],);
  }
}
