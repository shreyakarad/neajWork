import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/screens/address/controller/location_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/coupon_model.dart';
import 'package:flutter_woocommerce/view/screens/cart/widget/cart_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/checkout/checkout_screen.dart';
import 'package:flutter_woocommerce/view/screens/checkout/model/shipping_method_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/widget/address_card.dart';
import 'package:flutter_woocommerce/view/screens/coupon/controller/coupon_controller.dart';
import 'package:flutter_woocommerce/view/screens/order/controller/order_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/widget/profile_address_card.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  final bool fromOrder;
  final fromNav;
  final CartModel cartModel;
  CartScreen({@required this.fromNav, this.cartModel, this.fromOrder = false});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponController = TextEditingController();
  String shippingFee = '0';
  @override
  void initState() {
    super.initState();
    Get.find<LocationController>().getUserAddress();
    if(Get.find<CartController>().cartList.length == 0 ) {
      Get.find<CouponController>().removeCouponData(false);
    }
    Get.find<OrderController>().setShippingIndex(-1);
    if(Get.find<OrderController>().shippingZonesList == null) {
      Get.find<OrderController>().getShippingZones();
    }
    Get.find<LocationController>().emptyOrderAddress(notify: false);
    Get.find<OrderController>().emptyShippingMethodList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'my_cart'.tr, isBackButtonExist: (ResponsiveHelper.isDesktop(context) || !widget.fromNav)),
      body: GetBuilder<CartController>(builder: (cartController) {
        return GetBuilder<LocationController>(builder: (locationController) {
          return GetBuilder<ProfileController>(builder: (profileController) {
            return GetBuilder<CouponController>(builder: (couponController) {
              return GetBuilder<OrderController>(builder: (orderController) {
                double _shippingFee = 0;
                double _shippingTax = 0;
                double _tax = 0;
                double _couponDiscount = couponController.discount;
                double minShippingAmount = 0;
                List<CartModel> _cartList = [];

                if (widget.cartModel != null) {
                  _cartList = [widget.cartModel];
                } else {
                  _cartList = cartController.cartList;
                }

                cartController.calculateProductPrice( _cartList );
                _shippingFee = cartController.calculateShippingFee( _cartList, (orderController.shippingIndex != -1 && orderController.shippingMethodList.isNotEmpty) ? orderController.shippingMethodList[orderController.shippingIndex] : null);
                if(Get.find<ConfigController>().calculateTax()) {
                  _tax = cartController.calculateTax( _cartList, Get.find<ConfigController>().taxClassList, couponController.itemDiscountList, locationController.selectedShippingAddressIndex != -1 ? locationController.addressList[locationController.selectedShippingAddressIndex] : null, profileController.profileShippingAddress, locationController.profileShippingSelected == true);
                  _shippingTax = cartController.calculateShippingTax( _cartList, Get.find<ConfigController>().taxClassList, _tax, locationController.selectedShippingAddressIndex != -1 ? locationController.addressList[locationController.selectedShippingAddressIndex] : null, profileController.profileShippingAddress, locationController.profileShippingSelected == true);
                }
                _couponController.text = Get.find<CouponController>().selectedCouponCode != null ? Get.find<CouponController>().selectedCouponCode : '';

                double _subTotal = cartController.productPrice - cartController.discount;
                double _total = _subTotal - _couponDiscount + _tax + _shippingFee + _shippingTax;

                return (_cartList != null && orderController.shippingMethodList != null
                && Get.find<ConfigController>().settings.shippingSettings != null) ? _cartList.length > 0 ? Column(children: [
                   Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL), physics: BouncingScrollPhysics(),
                        child: SizedBox(
                          width: Dimensions.WEB_MAX_WIDTH,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            // Product
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: _cartList.length,
                              itemBuilder: (context, index) {
                                return CartProductWidget(cart: _cartList[index], cartIndex: widget.cartModel != null ? -1 : index);
                              },
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            //couponController.itemDiscountList

                            // Coupon
                            Get.find<ConfigController>().enabledCoupon() ? Row(children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getCouponRoute(true));
                                },
                                child: Container(
                                  height: 50, width: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorLight.withOpacity(.75),
                                    boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(Get.find<LocalizationController>().isLtr ? 10 : 0),
                                      right: Radius.circular(Get.find<LocalizationController>().isLtr ? 0 : 10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(Images.coupon),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: SizedBox(height: 50, child: TextField (
                                controller: _couponController,
                                style: robotoRegular.copyWith(height: ResponsiveHelper.isMobile(context) ? null : 2),
                                decoration: InputDecoration(
                                  hintText: 'enter_promo_code'.tr,
                                  hintStyle: robotoRegular.copyWith(color: Theme.of(context).hintColor),
                                  isDense: true,
                                  filled: true,
                                  //enabled: true,
                                  enabled: couponController.discount == 0,
                                  fillColor: Theme.of(context).cardColor,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ))),
                              InkWell(
                                onTap: () {
                                  String _couponCode = _couponController.text.trim();
                                  if(couponController.discount < 1) {
                                    if(_couponCode.isNotEmpty && !couponController.isLoading) {
                                      couponController.applyCoupon(_couponCode, _subTotal, _cartList, minShippingAmount).then((discount) {
                                        if (discount > 0) {
                                          showCustomSnackBar(
                                            '${'you_got_discount_of'.tr} ${PriceConverter.convertPrice(discount.toString())}',
                                            isError: false,
                                          );
                                          print(_couponCode);
                                          setState(() {
                                            _couponController.text = _couponCode;
                                          });
                                          couponController.setSelectedCoupon(_couponCode);
                                          print(_couponController.text);
                                        }
                                      });
                                    } else if(_couponCode.isEmpty) {
                                      showCustomSnackBar('enter_a_coupon_code'.tr);
                                    }
                                  }
                                  else {
                                    couponController.removeCouponData(true);
                                  }
                                },
                                child: Container(
                                  height: 50, width: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorLight,
                                    boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(Get.find<LocalizationController>().isLtr ? 0 : 10),
                                      right: Radius.circular(Get.find<LocalizationController>().isLtr ? 10 : 0),
                                    ),
                                  ),
                                  child: couponController.discount <= 0 ? !couponController.isLoading ? Text(
                                    'apply'.tr,
                                    style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),
                                  ) : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                                      : Icon(Icons.clear, color: Colors.white),
                                ),
                              ),
                            ]) : SizedBox(),
                            SizedBox( height: Get.find<ConfigController>().enabledCoupon() ? Dimensions.PADDING_SIZE_LARGE : 0 ),

                           /* TextButton(
                              onPressed: (){
                                print(locationController.selectedShippingAddressIndex);
                              },
                              child: Text('Hello'),
                            ), */


                            locationController.profileShippingSelected == true ?
                              ProfileAddressCard (
                                title: 'select_shipping_address'.tr,
                                address: Get.find<ProfileController>().profileShippingAddress,
                                billingAddress: false,
                                fromProfile: false,
                              ) : SizedBox(),


                            locationController.profileShippingSelected == true ? SizedBox() :
                            GetBuilder<LocationController>(
                                builder: (addressController) {
                                  return AddressCard(
                                    title: 'select_shipping_address'.tr,
                                    address: addressController.selectedShippingAddressIndex == -1 ? null : addressController.addressList.isNotEmpty ? addressController.addressList[addressController.selectedShippingAddressIndex] : null,
                                    //address: null,
                                    billingAddress: false, fromProfile: false,
                                  );
                                }
                            ),


                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                            SizedBox(height: Get.find<ConfigController>().enabledCoupon() ? Dimensions.PADDING_SIZE_LARGE : 0),

                            (orderController.shippingMethodList != null && orderController.shippingMethodList.length != 0) ? Text(
                              'shipping_method'.tr, style: robotoRegular,
                            ) : SizedBox(),
                            Get.find<ConfigController>().enabledShipping() ? ListView.builder(
                              itemCount: orderController.shippingMethodList.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {

                                if( orderController.shippingMethodList[index].methodId == "free_shipping" && orderController.shippingMethodList[index].data['settings']['requires']['value'] == 'min_amount' &&
                                    (orderController.shippingMethodList[index].data['settings']['min_amount']['value'] != '' && orderController.shippingMethodList[index].data['settings']['min_amount']['value'] != 0)) {
                                  minShippingAmount = double.parse(orderController.shippingMethodList[index].data['settings']['min_amount']['value']);
                                }
                                return InkWell(
                                  onTap: () => orderController.setShippingIndex(index),
                                  child: (orderController.shippingMethodList[index].methodId == "free_shipping" && _total > minShippingAmount) ? Row(children: [
                                    Radio<int>(
                                      value: index, groupValue: orderController.shippingIndex,
                                      activeColor: Theme.of(context).primaryColor,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      onChanged: (int i) => orderController.setShippingIndex(i),
                                    ),
                                    Expanded(child: Text( orderController.shippingMethodList[index].title, style: robotoRegular )),
                                    Text(
                                      orderController.shippingMethodList[index].total.toString(),
                                      style: robotoMedium,
                                    ),
                                  ]) : (orderController.shippingMethodList[index].methodId != "free_shipping") ? Row(children: [
                                    Radio<int>(
                                      value: index, groupValue: orderController.shippingIndex,
                                      activeColor: Theme.of(context).primaryColor,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      onChanged: (int i) => orderController.setShippingIndex(i),
                                    ),
                                    Expanded(child: Text( orderController.shippingMethodList[index].title, style: robotoRegular )),

                                    Text(
                                      PriceConverter.convertPrice(((orderController.shippingMethodList[index].methodId == 'flat_rate' ? cartController.shippingClassFee : 0) + orderController.shippingMethodList[index].total).toString()),
                                      style: robotoMedium,
                                    ),
                                  ]) : SizedBox(),
                                );
                              },
                            ) : SizedBox(),
                            SizedBox(height: (orderController.shippingMethodList.isNotEmpty && Get.find<ConfigController>().enabledShipping())
                                ? Dimensions.PADDING_SIZE_LARGE : 0 ),

                            // Total
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('product_price'.tr, style: robotoRegular),
                              Text(PriceConverter.convertPrice(cartController.productPrice.toString()), style: robotoRegular),
                            ]),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('discount'.tr, style: robotoRegular),
                              Text(  '(-) ' + PriceConverter.convertPrice(cartController.discount.toString()), style: robotoRegular),
                            ]),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(0.5)),
                            ),

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('subtotal'.tr, style: robotoMedium),
                              Text(
                                PriceConverter.convertPrice(_subTotal.toString()),
                                style: robotoMedium,
                              ),
                            ]),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            Get.find<ConfigController>().enabledCoupon() ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Expanded (
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('coupon_discount'.tr,
                                      style: poppinsRegular,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    SizedBox(
                                      width: 150,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Text((couponController.coupon != null ? couponController.discount == 0 ? '' : ' (${couponController.coupon.code}' : ''),
                                              style: poppinsRegular,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          (couponController.coupon != null && couponController.discount != 0) ?
                                          Text(')') : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 20),


                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(Get.find<LocalizationController>().isLtr ? '(-) ' : ''),
                                  Text(PriceConverter.convertPrice( couponController.discount.toString()), style: robotoRegular),
                                  Text(Get.find<LocalizationController>().isLtr ? '' : ' (-)'),
                                ],
                              ),
                            ]) : SizedBox(),
                            SizedBox(height: Get.find<ConfigController>().enabledCoupon() ? Dimensions.PADDING_SIZE_SMALL : 0),

                            (orderController.shippingMethodList.isNotEmpty && Get.find<ConfigController>().enabledShipping()) ? ! cartController.isLoading?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('shipping_fee'.tr, style: robotoRegular),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(Get.find<LocalizationController>().isLtr ? '(+) ' : '', style: robotoRegular),
                                    Text(_shippingFee != 0 ? PriceConverter.convertPrice(_shippingFee.toString()) : 'free'.tr),
                                    Text(Get.find<LocalizationController>().isLtr ? '' : ' (+)'),
                                  ],
                                ),
                              ],
                            ) : CircularProgressIndicator():SizedBox(),

                            SizedBox(height: (orderController.shippingMethodList.isNotEmpty && Get.find<ConfigController>().calculateTax()
                                && Get.find<ConfigController>().enabledShipping()) ? Dimensions.PADDING_SIZE_SMALL : 0),


                            (orderController.shippingMethodList.isNotEmpty && Get.find<ConfigController>().enabledShipping()) ? ! cartController.isLoading ?
                            _shippingTax> 0 ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('shipping_tax'.tr, style: robotoRegular),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(Get.find<LocalizationController>().isLtr ? '(+) ' : '', style: robotoRegular),
                                    Text(PriceConverter.convertPrice(_shippingTax.toString())),
                                    Text(Get.find<LocalizationController>().isLtr ? '' : ' (+)'),
                                  ],
                                ),
                              ],
                            ) : SizedBox() : CircularProgressIndicator():SizedBox(),

                            SizedBox(height: _shippingTax>0 ? Dimensions.PADDING_SIZE_SMALL : 0),

                            Get.find<ConfigController>().calculateTax() ? Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('vat_tax'.tr, style: robotoRegular),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(Get.find<LocalizationController>().isLtr ? '(+) ' : ''),
                                  Text(PriceConverter.convertPrice(_tax.toString()), style: robotoRegular),
                                  Text(Get.find<LocalizationController>().isLtr ? '' : ' (+)'),
                                ],
                              ),
                            ]) : SizedBox(),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                              child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(0.5)),
                            ),

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('total_amount'.tr,
                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                              ),
                              Text(PriceConverter.convertPrice(_total.toString()),
                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                              ),
                            ]),

                          ]),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    color: Get.isDarkMode ? Colors.black54 : Theme.of(context).cardColor,
                    width: Dimensions.WEB_MAX_WIDTH,
                    padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL, bottom: Dimensions.PADDING_SIZE_SMALL, left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('${'total'.tr} : ',
                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            PriceConverter.convertPrice(_total.toString()),
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                          ),
                        ]),

                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                        !cartController.isLoading ? CustomButton(
                            height: 35,
                            width: 140,
                            buttonText: 'proceed_to_checkout'.tr,
                            fontSize: 12,
                            radius: 50,
                            onPressed: () {
                              if(locationController.selectedShippingAddressIndex == -1 && !locationController.profileShippingSelected) {
                                showCustomSnackBar('please_select_your_shipping_address'.tr);
                              }else{
                                CouponModel _coupon;
                                if(couponController.coupon != null) {
                                  _coupon = couponController.coupon;
                                  _coupon.amount = couponController.discount.toString();
                                }
                                ShippingMethodModel _shipping;
                                if(orderController.shippingMethodList.isNotEmpty) {
                                  _shipping = orderController.shippingMethodList[orderController.shippingIndex];
                                  _shipping.methodDescription = _shippingFee.toString();

                                  print('ShippingFee-->${_shippingFee.toString()}');
                                  //_shipping.title = _total.toString();
                                }
                                Get.to(()=> CheckoutScreen(cartList: widget.fromOrder ? _cartList : null, coupon: _coupon, shippingMethod: _shipping, orderAmount: _total, shippingIndex : Get.find<LocationController>().selectedShippingAddressIndex, orderNow: widget.fromOrder));
                                // Get.toNamed(RouteHelper.getCheckoutRoute('cart', _coupon, _shipping));
                                // Get.find<CouponController>().removeCouponData(false);
                              }
                            }) : Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  )
                ]) : NoDataScreen(type: NoDataType.CART, text: 'cart_is_empty'.tr) : Center(child: CircularProgressIndicator());
              });
            });
          }
        );
      });
      }),
    );
  }
}
