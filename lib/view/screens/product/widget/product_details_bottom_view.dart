import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/view/screens/product/widget/cart_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';

class ProductDetailsBottomView extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailsBottomView({Key key, this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;
    return GetBuilder<ProductController>(
      builder: (productController) {
        return Container(height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.2), spreadRadius: 5, blurRadius: 5, offset: Offset(0,1))]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_DEFAULT),
            child: Row( children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // if(productController.cartIndex != -1) {
                            //   showCustomSnackBar( 'product_added_cart'.tr );
                            // } else {
                              showModalBottomSheet(context: context, isScrollControlled: true,
                                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
                                  builder: (con) => CartBottomSheet(product: productController.product,
                                      fromOrder: true,
                                      callback: (){
                                        showCustomSnackBar('added_to_cart'.tr, isError: false);
                              }));
                            // }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Get.isDarkMode ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.65) : Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.only(
                                bottomLeft: isLtr ? Radius.circular(100) : Radius.circular(0), topLeft: isLtr ? Radius.circular(100) : Radius.circular(0),
                                topRight: isLtr ? Radius.circular(0) : Radius.circular(100), bottomRight: isLtr ? Radius.circular(0) : Radius.circular(100),
                              )
                            ),
                            child: Center(child: Text('order_now'.tr, style: robotoRegular.copyWith(color : Colors.white)))),
                        ),
                      ),
                      Get.isDarkMode ? SizedBox(width: 2) : SizedBox(),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(context: context, isScrollControlled: true,
                                backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
                                builder: (con) => CartBottomSheet(product: productController.product,callback: (){
                                  showCustomSnackBar('added_to_cart'.tr, isError: false);
                            }));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: isLtr ? Radius.circular(100) : Radius.circular(0), bottomRight: isLtr ? Radius.circular(100) : Radius.circular(0),
                                  topLeft: isLtr ? Radius.circular(0) : Radius.circular(100), bottomLeft:  isLtr ?  Radius.circular(0) : Radius.circular(100) ),
                                color : Get.isDarkMode ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColor,
                              ),
                              child: Center(child: Text('add_to_cart'.tr, style: robotoRegular.copyWith(color : Colors.white)))),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],),
          ),

        );
      }
    );
  }
}
