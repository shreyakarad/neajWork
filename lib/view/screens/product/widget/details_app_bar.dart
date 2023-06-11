import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';

class DetailsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Key key;
  final String productSlug;
  final bool formSplash;
  DetailsAppBar ({@required this.productSlug,this.key, this.formSplash});

  @override
  DetailsAppBarState createState() => DetailsAppBarState();

  @override
  Size get preferredSize => Size(double.maxFinite, 50);
}

class DetailsAppBarState extends State<DetailsAppBar> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void shake() {
    controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 15.0).chain(CurveTween(curve: Curves.elasticIn)).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });

    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyLarge.color),
        onPressed: () {
          //Get.find<ProductController>().resetImageIndex();
          Get.find<ProductController>().productDetailsBack();
          Get.back();
          // widget.formSplash ? Get.offNamed(RouteHelper.getInitialRoute()) : Navigator.pop(context) ;
        }),
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
      title: Text(
        'product_details'.tr,
        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge.color),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          padding: EdgeInsets.all(0.0),
          onPressed: () {
          Get.find<ProductController>().shareProductLink(productSlug: Get.find<ProductController>().product.slug);
        }, icon: Icon(Icons.share, color: Theme.of(context).primaryColor)),

        // IconButton(
        //     padding: EdgeInsets.all(0.0),
        //     onPressed: () {
        //       Get.find<ProductController>().shareProductLink(productSlug: Get.find<ProductController>().product.slug);
        //     }, icon: Icon(Icons.share, color: Theme.of(context).primaryColor)),

        AnimatedBuilder(
        animation: offsetAnimation,
        builder: (buildContext, child) {
          return Container(
            padding: EdgeInsets.only(right: 15.0 - offsetAnimation.value),
            child: Stack(children: [
              IconButton(
                padding: EdgeInsets.all(0.0),
                icon: Icon(Icons.shopping_cart, color: Theme.of(context).primaryColor), onPressed: () {
                Navigator.pushNamed(context, RouteHelper.getCartRoute());
              }),
              Positioned(
                top: 5, right: 5,
                child: Container(
                  padding: EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: GetBuilder<CartController>(builder: (cartController) {
                    return Text(
                      cartController.cartList.length.toString(),
                      style: robotoMedium.copyWith(color: Colors.white, fontSize: 8),
                    );
                  }),
                ),
              ),
            ]),
          );
        },
      )
      ],
    );
  }
}
