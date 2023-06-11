import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int quantity;
  final bool isCartWidget;
  final int stock;
  final bool isExistInCart;
  final int cartIndex;
  QuantityButton({
    @required this.isIncrement,
    @required this.quantity,
    @required this.stock,
    @required this.isExistInCart,
    @required this.cartIndex,
    this.isCartWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  () {
        if(isExistInCart) {
          if (!isIncrement && quantity > 1) {
            Get.find<CartController>().setQuantity(false, cartIndex, stock);
          } else if (isIncrement) {
            if(stock == null || quantity < stock) {
              Get.find<CartController>().setQuantity(true, cartIndex, stock);
            }else {
              showCustomSnackBar('out_of_stock'.tr);
            }
          }
        } else {
          if (!isIncrement && quantity > 1) {
            Get.find<ProductController>().setQuantity(false, stock);
          } else if (isIncrement) {
            if(stock == null || quantity < stock) {
              Get.find<ProductController>().setQuantity(true, stock);
            }else {
              showCustomSnackBar('out_of_stock'.tr);
            }
          }
        }
      },

      child: Container(
        // padding: EdgeInsets.all(3),
        height: 50,width: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Theme.of(context).primaryColor),
        child: Center(
          child: Icon(
            isIncrement ? Icons.add : Icons.remove,
            color: isIncrement ? Colors.white : quantity > 1 ? Colors.white : Colors.white,
            size: isCartWidget ? 26 : 20,
          ),
        ),
      ),
    );
  }
}