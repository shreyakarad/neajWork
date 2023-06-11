import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:get/get.dart';

class ProductDetailsTable extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailsTable({Key key, this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Get.isDarkMode? Theme.of(context).primaryColor.withOpacity(0):
          Theme.of(context).primaryColor.withOpacity(.125), blurRadius:1, spreadRadius: 1, offset: Offset(1,2))]
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL),
          child: Text('product_specification'.tr, style: robotoMedium,),
        ),

        Row(children: [
          Expanded(flex: 4,child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(title: 'purchase_price'),
            CustomText(title: 'selling_price'),
            CustomText(title: 'tax'),
            CustomText(title: 'discount'),
            CustomText(title: 'current_stock'),
            CustomText(title: 'category'),
            // CustomText(title: 'sub_category'),
            CustomText(title: 'product_type'),
            CustomText(title: 'shipping_cost'),
          ])), Container(transform: Matrix4.translationValues(0, 4, 0),
            height: 345, width: .25, color: Theme.of(context).hintColor,),

          Expanded(flex: 8,child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(amount: productModel.regularPrice, amountValue: true,),
            CustomText(amount: productModel.regularPrice, amountValue: true,),
            CustomText(title: productModel.regularPrice.toString(), isPercentage: true, isLocale: false,),
            CustomText(amount: productModel.salePrice, isLocale: false,
                title: '0',
                amountValue: true),
            CustomText(title:  productModel.stockQuantity.toString() , isLocale: false,),
            CustomText(title: 'category', isLocale: false,),
            // CustomText(title: subCategory, isLocale: false,),
            CustomText(title:  'phy'),

            CustomText(amount: productModel.salePrice, amountValue: true),

          ])),
        ],)
      ],),);
  }
}

class CustomText extends StatelessWidget {
  final String title;
  final String amount;
  final bool amountValue;
  final bool isLocale;
  final bool isPercentage;
  const CustomText({Key key, this.title, this.amountValue = false, this.amount,
    this.isLocale = true, this.isPercentage = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(thickness: 1,),
        SizedBox(height: 28,
          child: Padding(
            padding:  EdgeInsets.only(left: Get.find<LocalizationController>().isLtr? Dimensions.PADDING_SIZE_DEFAULT :0,
                right: Get.find<LocalizationController>().isLtr ? 0: Dimensions.PADDING_SIZE_DEFAULT),
            child: amountValue?
            Text('${PriceConverter.convertPrice(amount.toString())}'):
            isLocale?
            Text(title.tr):
            isPercentage?
            Text('$title%'):
            Text(title),
          ),
        ),
      ],
    );
  }
}