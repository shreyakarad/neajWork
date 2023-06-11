import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/data/model/payment_model.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/order/model/place_order_body.dart';
import 'package:flutter_woocommerce/view/screens/payment/paypal/flutter_paypal.dart';
import 'package:flutter_woocommerce/view/screens/payment/razorpay/razorpay_payment.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PaymentHelper {


  static Future<PaymentResponse> makePayment(PlaceOrderBody placeOrderBody, double total, PaymentModel payment, List<CartModel> cartList) async {
    if(payment.paymentType == PaymentType.cod) {
      return PaymentResponse(isSuccess: true, status: 'cod');
    }else if(payment.paymentType == PaymentType.paypal) {
      return await payViaPaypal(placeOrderBody, total, payment, cartList);
    }else if(payment.paymentType == PaymentType.stripe) {
      return await payViaStripe(placeOrderBody, total, payment);
    }else if(payment.paymentType == PaymentType.razorpay) {
      return await payViaRazorpay(placeOrderBody, total, payment, cartList);
    }else if(payment.paymentType == PaymentType.paystack) {
      return await payViaPaystack(placeOrderBody, total, payment);
    }else if(payment.paymentType == PaymentType.paytm) {
      return await payViaPaytm(placeOrderBody, total, payment);
    }else if(payment.paymentType == PaymentType.flutterwave) {
      return await payViaFlutterwave(placeOrderBody, total, payment);
    }
    return PaymentResponse(isSuccess: false);
  }


  static Future<PaymentResponse> payViaPaypal(PlaceOrderBody placeOrderBody, double total, PaymentModel payment, List<CartModel> cartList) async {
    // List<Map<String, dynamic>> _items = [];
    // double _itemsPrice = 0;
    // for(CartModel item in cartList) {
    //   _itemsPrice += double.parse(item.prices.price);
    //   _items.add({
    //     "name": item.name,
    //     "quantity": item.quantity,
    //     "price": double.parse(item.prices.price).toStringAsFixed(2),
    //     "currency": Get.find<ConfigController>().getCurrency()
    //   });
    // }
    PaymentResponse _paymentResponse;
    await Navigator.of(Get.context).push(MaterialPageRoute(builder: (BuildContext context) {
      UsePaypal _usePaypal = UsePaypal(
          sandboxMode: true,
          clientId: "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
          secretKey: "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
          returnURL: "https://samplesite.com/return",
          cancelURL: "https://samplesite.com/cancel",
          transactions: const [
            {
              "amount": {
                "total": '10.12',
                "currency": "USD",
                "details": {
                  "subtotal": '10.12',
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description":
              "The payment transaction description.",
              // "payment_options": {
              //   "allowed_payment_method":
              //       "INSTANT_FUNDING_SOURCE"
              // },
              "item_list": {
                "items": [
                  {
                    "name": "A demo product",
                    "quantity": 1,
                    "price": '10.12',
                    "currency": "USD"
                  }
                ],

                // shipping address is not required though
                "shipping_address": {
                  "recipient_name": "Jane Foster",
                  "line1": "Travis County",
                  "line2": "",
                  "city": "Austin",
                  "country_code": "US",
                  "postal_code": "73301",
                  "phone": "+00000000",
                  "state": "Texas"
                },
              }
            }
          ],
          note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          _paymentResponse = PaymentResponse(isSuccess: true, status: params['paymentId']);
          print('Heri is success ===> ${params['paymentId']}');
          return _paymentResponse;

        },
        onError: (error) {
          _paymentResponse = PaymentResponse(isSuccess: false, status: 'payment_failed'.tr);
          print('paypal_error_printing');
          print(error.toString());
          return _paymentResponse;
        },
        onCancel: (params) {
          _paymentResponse = PaymentResponse(isSuccess: false, status: params.toString());
          print('onCanceled Call');
          return _paymentResponse;
        },
        onClose: () {
          _paymentResponse = PaymentResponse(isSuccess: false, status: 'payment_cancelled'.tr);
          print('onClose Call');
          return _paymentResponse;
        },

      );
      print('Paypal Data:========>${_usePaypal.transactions}');
      return _usePaypal;

    }));
    // Timer _timer;
    for(;;) {
      await Future.delayed(Duration(seconds: 2));
      if(_paymentResponse != null) {
        break;
      }
    }
    return _paymentResponse;
  }



  // static Future<PaymentResponse> payViaPaypal(PlaceOrderBody placeOrderBody, double total, PaymentModel payment, List<CartModel> cartList) async {
  //   List<Map<String, dynamic>> _items = [];
  //   double _itemsPrice = 0;
  //   for(CartModel item in cartList) {
  //     _itemsPrice += double.parse(item.prices.price);
  //     _items.add({
  //       "name": item.name,
  //       "quantity": item.quantity,
  //       "price": double.parse(item.prices.price).toStringAsFixed(2),
  //       "currency": Get.find<ConfigController>().getCurrency()
  //     });
  //   }
  //   PaymentResponse _paymentResponse;
  //   await Navigator.of(Get.context).push(MaterialPageRoute(builder: (BuildContext context) {
  //     UsePaypal _usePaypal = UsePaypal(
  //       sandboxMode: true,
  //       clientId: "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
  //       secretKey: "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
  //       returnURL: "https://samplesite.com/return",
  //       cancelURL: "https://samplesite.com/cancel",
  //       transactions: [{
  //         "amount": {
  //           "total": total.toStringAsFixed(2),
  //           "currency": Get.find<ConfigController>().getCurrency(),
  //           "details": {
  //             "subtotal": _itemsPrice.toStringAsFixed(2),
  //             "shipping": (total - _itemsPrice).toStringAsFixed(2),
  //             "shipping_discount": 0
  //           }
  //         },
  //         "description": payment.description,
  //         "item_list": {
  //           "items": _items,
  //           // shipping address is not required though
  //           "shipping_address": {
  //             "recipient_name": "${placeOrderBody.shipping.firstName ?? ''} ${placeOrderBody.shipping.lastName ?? ''}",
  //             "line1": placeOrderBody.shipping.address1 ?? '',
  //             "line2": placeOrderBody.shipping.address2 ?? '',
  //             "city": placeOrderBody.shipping.city ?? '',
  //             "country_code": Get.find<ConfigController>().getDefaultCountry(),
  //             "postal_code": placeOrderBody.shipping.postcode ?? '',
  //             "phone": '+8801879762951' ?? '',
  //             "state": placeOrderBody.shipping.state ?? ''
  //           },
  //         }
  //       }],
  //       note: "",
  //       onSuccess: (Map params) async {
  //         _paymentResponse = PaymentResponse(isSuccess: true, status: params['paymentId']);
  //         return PaymentResponse(isSuccess: true, status: params['paymentId']);
  //       },
  //       onError: (error) {
  //         _paymentResponse = PaymentResponse(isSuccess: false, status: error['message']);
  //         return PaymentResponse(isSuccess: false, status: error['message']);
  //       },
  //       onCancel: (params) {
  //         _paymentResponse = PaymentResponse(isSuccess: false, status: params.toString());
  //         return PaymentResponse(isSuccess: false, status: params['message']);
  //       },
  //     );
  //     print('Paypal Data:========>${_usePaypal.transactions}');
  //     return _usePaypal;
  //   }));
  //   return _paymentResponse;
  // }

  static Future<PaymentResponse> payViaStripe(PlaceOrderBody placeOrderBody, double total, PaymentModel payment) async {
    Stripe.publishableKey = payment.publishableKey;
    Stripe.merchantIdentifier = 'my_stripe_payment';
    await Stripe.instance.applySettings();
    Map<String, dynamic> paymentIntentData;
    try {
      Map<String, dynamic> body = {
        'amount': (total * 100).toStringAsFixed(0),
        'currency': Get.find<ConfigController>().getCurrency(),
        'payment_method_types[]': 'card'
      };
      Http.Response _response = await Http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${payment.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      paymentIntentData = jsonDecode(_response.body);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantCountryCode: Get.find<ConfigController>().getDefaultCountry(),
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData['customer'],
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
        ));
        await Stripe.instance.presentPaymentSheet();
        print('Stripe Data:========>$paymentIntentData');
        return PaymentResponse(isSuccess: true, status: paymentIntentData['id']);
      }
    } on Exception catch (e) {
      if (e is StripeException) {
        return PaymentResponse(isSuccess: false, status: e.error.localizedMessage);
      } else {
        return PaymentResponse(isSuccess: false, status: e.toString());
      }
    } catch (e) {
      return PaymentResponse(isSuccess: false, status: e.toString());
    }
    return null;
  }

  static Future<PaymentResponse> payViaRazorpay(PlaceOrderBody placeOrderBody, double total, PaymentModel payment, List<CartModel> cartList) async {
    final _result = await Get.to(RazorpayPayment(placeOrderBody: placeOrderBody, payment: payment, cartList: cartList, total: total));
    if(_result is PaymentResponse) {
      return _result;
    }else {
      return PaymentResponse(isSuccess: false);
    }
  }

  static Future<PaymentResponse> payViaPaystack(PlaceOrderBody placeOrderBody, double total, PaymentModel payment) async {
    PaystackPlugin _paystack = PaystackPlugin();
    await _paystack.initialize(publicKey: payment.publicKey);
    // String platform;
    //String _reference;
    // if (GetPlatform.isIOS) {
    //   platform = 'iOS';
    // } else {
    //   platform = 'Android';
    // }
    //_reference = 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';

    var charge = Charge()
      ..amount = 10000 *
          100 //the money should be in kobo hence the need to multiply the value by 100
      ..reference = getReference()
      ..putCustomField('custom_id',
          '846gey6w') //to pass extra parameters to be retrieved on the response from Paystack
      ..email = 'tutorial@email.com';

    CheckoutResponse response = await _paystack.checkout(
      Get.context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    print('Paystack Data:========>$response');
    if (response.status == true) {
      return PaymentResponse(isSuccess: true, status: response.reference);
    } else {
      return PaymentResponse(isSuccess: false, status: response.message);
    }
  }
  static String getReference(){
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  static Future<PaymentResponse> payViaPaytm(PlaceOrderBody placeOrderBody, double total, PaymentModel payment) async {
    bool _testing = true;
    try {
      String orderId = DateTime.now().millisecondsSinceEpoch.toString();
      String callBackUrl = (_testing ? 'https://securegw-stage.paytm.in' : 'https://securegw.paytm.in') + '/theia/paytmCallback?ORDER_ID=' + orderId;
      Http.Response response;
      try {
        response = await Http.post(
          Uri.parse('https://securegw-stage.paytm.in/theia/api/v1/initiateTransaction?mid=${payment.merchantMid}&orderId=$orderId'),
          body: {
            "requestType": "payment",
            "mid": payment.merchantMid,
            "key_secret": payment.merchantKey,
            "websiteName": payment.merchantWebsite,
            "orderId": orderId,
            "txnAmount": {"value": total.toString(), "currency": "INR"},
            "callbackUrl": callBackUrl,
            "userInfo": {"custId": "0"},
            "testing": _testing ? 0 : 1
          },
          headers: {'Content-type': "application/json"},
        );
        print("Response is${response.body}");
      }catch(e) {}
      Map<dynamic, dynamic> _response = await AllInOneSdk.startTransaction(
        payment.merchantMid, '0', total.toString(), response.body.toString(), '', false, true,
      );
      print('Paytm Data:========>$_response');
    } on PlatformException catch(error) {
      print('error');
      if (error is PlatformException) {
        return PaymentResponse(isSuccess: false, status: error.message + " \n  " + error.details.toString());
      } else {
        return PaymentResponse(isSuccess: false, status: error.toString());
      }
    }catch(e) {
      return PaymentResponse(isSuccess: false, status: e.toString());
    }
    return PaymentResponse(isSuccess: false);
  }



  static Future<PaymentResponse> payViaFlutterwave(PlaceOrderBody placeOrderBody, double total, PaymentModel payment) async {

    final Customer customer = Customer(
        name: placeOrderBody.shipping.firstName,
        phoneNumber: placeOrderBody.shipping.phone,
        email: "customer@customer.com");

    final Flutterwave flutterwave = Flutterwave(
        context: Get.context,
        publicKey: payment.publicKey,
        currency: 'RWF',
        redirectUrl: 'https://facebook.com',
        txRef: DateTime.now().toIso8601String(),
        amount: total.toString(),
        customer: customer,
        paymentOptions: "card, payattitude, barter, bank transfer, ussd",
        customization: Customization(title: "Test Payment"),
        isTestMode: true);

    final ChargeResponse _response = await flutterwave.charge();
    if (_response != null) {
      if(_response.success) {
        print('Flutterwave Data:========>${_response.toJson()}');
        return PaymentResponse(isSuccess: true, status: _response.transactionId);
      } else {
        return PaymentResponse(isSuccess: false);
      }
    } else {
      return PaymentResponse(isSuccess: false, status: 'payment_cancelled'.tr);
    }
  }
}


class PaymentResponse {
  bool isSuccess;
  String status =  'payment_failed_try_again'.tr;
  PaymentResponse({@required this.isSuccess, this.status});
}