 import 'dart:async';
import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/coupon_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/checkout_screen.dart';
import 'package:flutter_woocommerce/view/screens/checkout/model/shipping_method_model.dart';
import 'package:flutter_woocommerce/view/screens/order/controller/order_controller.dart';
import 'package:flutter_woocommerce/view/screens/order/model/order_model.dart';
import 'package:flutter_woocommerce/view/screens/order/order_tracking_screen.dart';
import 'package:flutter_woocommerce/view/screens/order/widget/seller_details_widget.dart';
import 'package:flutter_woocommerce/view/screens/order/widget/shipping_details_widget.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/confirmation_dialog.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/screens/order/widget/order_item_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel orderModel;
  final bool guestOrder;
  OrderDetailsScreen({@required this.orderModel, this.guestOrder});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  StreamSubscription _stream;

  void _loadData(BuildContext context, bool reload) async {
    await Get.find<OrderController>().getOrderDetails(widget.orderModel.id,);
    if (widget.orderModel == null) {
      await Get.find<ConfigController>().getGeneralSettings();
    }
  }

  @override
  void initState() {
    super.initState();
    print('orderModel');
    print(widget.orderModel.id);

    _stream = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage on Details: ${message.data}");
      _loadData(context, true);
    });

    if(widget.guestOrder == null) {
      _loadData(context, false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.orderModel == null) {
          return Get.offAllNamed(RouteHelper.getInitialRoute());
        }else {
          return true;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: 'order_details'.tr, onBackPressed: () {
          if(widget.orderModel == null) {
            Get.offAllNamed(RouteHelper.getInitialRoute());
          }else {
            Get.back();
          }
        }),
        body: GetBuilder<OrderController>(builder: (orderController) {
          double _deliveryCharge = 0;
          double _productPrice = 0;
          double _discount = 0;
          double _couponDiscount = 0;
          double _tax = 0;
          OrderModel _order = orderController.order;
          if(_order != null) {
            _deliveryCharge = double.parse(_order.shippingTotal);
            _couponDiscount = double.parse(_order.discountTotal);
            _tax = double.parse(_order.totalTax);
            for(LineItems item in _order.lineItems) {
              bool _hasVariation = item.variationProducts != null;
              double _itemPrice = 0;

              if(_hasVariation ? item.variationProducts.regularPrice.isNotEmpty : item.price != null) {
                _itemPrice = double.parse(_hasVariation ? item.variationProducts.regularPrice  : item.price.toString()) * item.quantity;
                _discount += (double.parse(_hasVariation ? item.variationProducts.regularPrice : item.price.toString())
                    - double.parse(_hasVariation ? item.variationProducts.price : item.price.toString())) * item.quantity;
              }else {
                _itemPrice = double.parse(_hasVariation ? item.variationProducts.price : item.price.toString()) * item.quantity;
              }
              _productPrice += _itemPrice;
            }
          }
          double _subTotal = _productPrice - _discount;
          double _total = _subTotal - _couponDiscount + _tax + _deliveryCharge;

          return !orderController.showNotFound ? _order != null ? Column(children: [
            Expanded(child: Scrollbar(child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.zero : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    Text('${'order_id'.tr}', style: DMSansMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColorDark)),
                    Text('# ${_order.id}', style: DMSansMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColorDark)),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  ]
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _order.lineItems.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return OrderItemWidget(order: _order, item: _order.lineItems[index], index: index);
                  },
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text('shipping_details'.tr, style: DMSansMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
                ),
                SizedBox( height: Dimensions.PADDING_SIZE_SMALL),
                ShippingDetailsWidget(order: _order),

                // Seller Details
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text('seller_details'.tr, style: DMSansMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
                ),
                SizedBox( height: Dimensions.PADDING_SIZE_SMALL ),

                _order.stores == null ? SizedBox() :
                SellerDetailsWidget(order: _order),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text('payment_details'.tr, style: DMSansMedium.copyWith( fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor )),
                ),
                SizedBox( height: Dimensions.PADDING_SIZE_SMALL),
                Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                      border: Border.all(color: Theme.of(context).primaryColorLight.withOpacity(0.30)),
                      color: Theme.of(context).cardColor
                  ),
                  child:  Column(
                    children: [
                      _order.paymentMethod != '' ?
                      orderBodyText( 'payment_method'.tr , _order.paymentMethod == 'cod' ? 'COD' : _order.paymentMethod) : SizedBox(),
                      SizedBox( height: Dimensions.PADDING_SIZE_SMALL),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _order.lineItems.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          double _itemTotal = double.parse(_order.lineItems[index].subtotal);
                          int _itemQuantity = _order.lineItems[index].quantity;
                          double _itemStubTotal = _itemTotal;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(child: Row(
                                  children: [
                                    Get.find<LocalizationController>().isLtr ? SizedBox() : Text(' (${_order.lineItems[index].quantity} ' + 'qnty'.tr + ')', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
                                    Expanded(
                                      child: Text(
                                          _order.lineItems[index].name,
                                          overflow: TextOverflow.ellipsis ,
                                          style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
                                    ),

                                    Get.find<LocalizationController>().isLtr ? Text(' (${_order.lineItems[index].quantity} ' + 'qnty'.tr + ')', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)) : SizedBox(),
                                  ],
                                  ),
                                ),

                                SizedBox(
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(PriceConverter.convertPrice(_itemStubTotal.toString()), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge.color)),
                                      ],
                                    ))
                              ],
                            ),
                          );





                          //   orderBodyText(
                          //   _order.lineItems[index].name + ' (${_order.lineItems[index].quantity} ' + 'qnty'.tr + ')',
                          //   PriceConverter.convertPrice(_itemStubTotal.toString())
                          // );
                        },
                      ),

                      //orderBodyText( 'discount'.tr , '(-) ${PriceConverter.convertPrice(_discount.toString())}'),

                      _couponDiscount > 0 ?
                      orderBodyText( 'coupon_discount'.tr , '${Get.find<LocalizationController>().isLtr ? '(-) ' : ''} ${PriceConverter.convertPrice((_couponDiscount).toString())} ${Get.find<LocalizationController>().isLtr ? '' : ' (-)'}') : SizedBox(),
                      // _couponDiscount > 0 ? SizedBox( height: Dimensions.PADDING_SIZE_EXTRA_SMALL) : SizedBox(),

                      orderBodyText('shipping_fee'.tr , _deliveryCharge > 0  ? '${Get.find<LocalizationController>().isLtr ? '(+) ' : ''} ${PriceConverter.convertPrice(_deliveryCharge.toString())}  ${Get.find<LocalizationController>().isLtr ? '' : ' (+)'}' : 'free'.tr),
                      // _deliveryCharge > 0 ? SizedBox( height: Dimensions.PADDING_SIZE_EXTRA_SMALL) : SizedBox(),

                      _tax > 0  ?
                      orderBodyText('tax'.tr ,  '${Get.find<LocalizationController>().isLtr ? '(+) ' : ''} ${PriceConverter.convertPrice(_tax.toString())} ${Get.find<LocalizationController>().isLtr ? '' : ' (+)'}') : SizedBox(),
                      // _deliveryCharge > 0 ? SizedBox( height: Dimensions.PADDING_SIZE_EXTRA_SMALL) : SizedBox(),

                      Divider(
                        thickness: 1, color: Theme.of(context).hintColor.withOpacity(0.5),
                      ),

                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text('total_amount'.tr, style: poppinsMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor,
                        )),
                        Text(
                          PriceConverter.convertPrice(( _total + _couponDiscount).toString() ),
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                        ),
                      ]),
                    ],
                  )
                ),

                /*Container(
                  width: Dimensions.WEB_MAX_WIDTH,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Row(
                    children: [
                      Flexible (
                        child: CustomButton(
                            buttonText: 'cancel_order'.tr,
                            radius: 50,
                            onPressed: () {
                              orderController.cancelOrder(_order.id);
                            }
                        ),
                      ),
                    ],
                  ),
                )*/

              ])),
            ))),
            (_order.status == 'completed' || _order.status == 'cancelled' || _order.status == 'failed' || _order.status == 'trash') ? SizedBox() :
             _bottomView(orderController, _order),
         ]) : Center(child: CircularProgressIndicator()) : Center(child: Text('invalid_order_id'.tr));
        }),
      ),
    );
  }

  void openDialog( BuildContext context, String imageUrl ) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular( Dimensions.RADIUS_LARGE )),
        child: Stack(children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            child: PhotoView(
              tightMode: true,
              imageProvider: NetworkImage(imageUrl),
              heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
            ),
          ),

          Positioned(top: 0, right: 0, child: IconButton(
            splashRadius: 5,
            onPressed: () => Get.back(),
            icon: Icon(Icons.cancel, color: Colors.red),
          )),

        ]),
      );
    },
  );

 // GetBuilder<OrderController>(builder: (orderController) {
  Widget _bottomView(OrderController orderController, OrderModel order) {
    return Column(children: [
      Container(
        width: Dimensions.WEB_MAX_WIDTH,
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Row(
          children: [
            Flexible (
              child: CustomButton(
                  height: 40,
                  buttonText: 'track_order'.tr,
                  radius: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderTrackingScreen(orderId: int.parse(order.id.toString()), order: orderController.order)));
                  }
              ),
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

            (order.paymentMethod == 'cod' && (order.status == 'processing' || order.status == 'pending')) ? Flexible (
              child: CustomButton(
                height: 40,
                transparent: true,
                buttonText: 'cancel_order'.tr,
                radius: 50,
                onPressed: () {
                  Get.dialog(ConfirmationDialog(icon: Images.orders_icon, description: 'are_you_sure_to_cancel_order'.tr, isLogOut: true, onYesPressed: () async {
                    await  orderController.cancelOrder(order.id);
                    Get.back();
                  }), useSafeArea: false);
                }
              ),
            ) : SizedBox(),

          ],
        ),
      ),

      // Center(
      //   child: Container(
      //     width: Dimensions.WEB_MAX_WIDTH,
      //     padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      //     child: CustomButton(
      //       radius: 50,
      //       buttonText: 'order_again'.tr,
      //       onPressed: () {
      //         reOrder(widget.orderModel);
      //       },
      //     ),
      //   ),
      // ),

    ]);
  }




  Widget orderBodyText (String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: Text(title,maxLines: 1, overflow: TextOverflow.ellipsis ,
              style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor))),
          SizedBox(
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(value, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge.color)),
              ],
            ))
        ],
      ),
    );
  }

  void reOrder (OrderModel orderModel) {
    CouponModel _coupon;
    ShippingMethodModel _shippingMethod;
    double _total = double.tryParse(orderModel.total);
    List<CartModel> _cartList = [];

    widget.orderModel.lineItems.forEach((product) {
      List<Variation> _variation = [];
      if(product.variationProducts != null) {
        for (int i =0; i< product.variationProducts.attributesArr.length; i++) {
          _variation.add(Variation(
            attribute: product.variationProducts.attributesArr[i].name,
            value: product.variationProducts.attributesArr[i].option,
          ));}
      }

      CartModel _cartModel = CartModel(
        id: product.productId, quantity: product.quantity, quantityLimits: QuantityLimits(minimum: 1, maximum: 15),
        name: product.name, shortDescription: '',
        description: '', sku: '',
        images: [ ImageModel(id: product.image.id, name: product.image.name) ],
        variation: _variation,
        variationText: ' ',
        prices: Prices(price: product.price.toString(), regularPrice: product.price.toString(), salePrice: product.price.toString()),
        product: ProductModel(id: product.productId, name: product.name,),
      );
      _cartList.add(_cartModel);
    });




    if( orderModel.couponLines != [] ) {
      if(orderModel.couponLines[0].metaData != []) {
        _coupon = CouponModel(
          id: orderModel.couponLines[0].metaData[0].value.id,
          code: orderModel.couponLines[0].metaData[0].value.code,
          amount: orderModel.couponLines[0].metaData[0].value.amount,
          status: orderModel.couponLines[0].metaData[0].value.status,
          discountType: orderModel.couponLines[0].metaData[0].value.discountType,
          description: orderModel.couponLines[0].metaData[0].value.description,
          dateCreated:orderModel.couponLines[0].metaData[0].value.dateCreated.date,
          dateExpires:orderModel.couponLines[0].metaData[0].value.dateExpires.date,
        );}
    }

    if( orderModel.shippingLines != [] ) {
      _shippingMethod = ShippingMethodModel(
        id: orderModel.shippingLines[0].id,
        methodTitle: orderModel.shippingLines[0].methodTitle,
        methodId: orderModel.shippingLines[0].methodId,
        //total: orderModel.shippingLines[0].total,
      );
    }

    if( _cartList != null){
      print(_cartList.length);
      Get.to(()=> CheckoutScreen(
        cartList: _cartList,
        coupon: _coupon,
        shippingMethod: _shippingMethod,
        orderAmount: _total,
      ));
      //Get.toNamed(RouteHelper.getCheckoutRoute(RouteHelper.orderDetails, null, null, reOrder: true));
    }
  }
}