import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/model/payment_model.dart';
import 'package:flutter_woocommerce/helper/payment_helper.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/order/model/place_order_body.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment extends StatefulWidget {
  final PlaceOrderBody placeOrderBody;
  final PaymentModel payment;
  final double total;
  final List<CartModel> cartList;
  RazorpayPayment({@required this.placeOrderBody, @required this.payment, @required this.cartList, @required this.total});

  @override
  State<RazorpayPayment> createState() => _RazorpayPaymentState();
}

class _RazorpayPaymentState extends State<RazorpayPayment> {
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
      print('Stripe Data:========>${response.paymentId}');
      Get.back(result: PaymentResponse(isSuccess: true, status: response.paymentId));
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
      Get.back(result: PaymentResponse(isSuccess: false, status: response.message));
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) {
      Get.back(result: PaymentResponse(isSuccess: false, status: response.walletName));
    });
    _razorpay.open({
      'key': widget.payment.keyId,
      'amount': (widget.total * 100).floor(),
      'name': widget.cartList[0].name,
      'description': '',
      'timeout': 600
    });
  }

  @override
  void dispose() {
    _razorpay.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Theme.of(context).cardColor));
  }
}
