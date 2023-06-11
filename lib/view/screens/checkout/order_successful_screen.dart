import 'dart:async';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/checkout/widget/payment_failed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../order/order_tracking_screen.dart';

class OrderSuccessfulScreen extends StatefulWidget {
  final String orderID;
  final bool success;
  final bool orderNow;
  OrderSuccessfulScreen({@required this.orderID, @required this.success, @required this.orderNow});

  @override
  State<OrderSuccessfulScreen> createState() => _OrderSuccessfulScreenState();
}

class _OrderSuccessfulScreenState extends State<OrderSuccessfulScreen> {

  @override
  void initState() {
    super.initState();

    if(!widget.success) {
      Future.delayed(Duration(seconds: 1), () {
        Get.dialog(PaymentFailedDialog(orderID: int.parse(widget.orderID)), barrierDismissible: false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    print('----order=id--->${widget.orderID}');
    print('-----OrderNowSuccessScreen---->${widget.orderNow}');

    return WillPopScope(
      onWillPop: () async {
        if(widget.orderNow) {
          Get.toNamed(RouteHelper.getInitialRoute());
          return true;
        }else {
          Get.toNamed(RouteHelper.getInitialRoute());
          return true;
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

              Image.asset(widget.success ? Images.success : Images.warning, width: 100, height: 100),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              Text(
                widget.success ? 'you_placed_the_order_successfully'.tr : 'your_order_is_failed_to_place'.tr,
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
                child: Text(
                  widget.success ? 'your_order_is_placed_successfully'.tr : 'your_order_is_failed_to_place_because'.tr,
                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                  textAlign: TextAlign.center,
                ),
              ),


              if(!Get.find<AuthController>().isLoggedIn())
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
                child: Text('${'your_order_id_is'.tr} : ${widget.orderID.toString()}',
                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50),


              InkWell(
                onTap: (){
                  Navigator.push( context, MaterialPageRoute(builder: (_)=> OrderTrackingScreen(order: null, orderId: int.parse(widget.orderID.toString()))), );
                  // Get.to(()=> OrderTrackingScreen(orderId: int.parse(widget.orderID.toString())));
                },
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Text('track_order'.tr, style: robotoBold.copyWith(color: Theme.of(context).primaryColor),),
                ),
              ),


              Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: CustomButton(buttonText: 'continue_shopping'.tr,
                    radius: 50,
                    width: 250,
                    onPressed: () => Get.offAllNamed(RouteHelper.getInitialRoute())),
              ),

            ])),
          ),
        ),
      ),
    );
  }
}
