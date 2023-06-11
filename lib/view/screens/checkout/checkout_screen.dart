import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_text_field.dart';
import 'package:flutter_woocommerce/view/screens/address/controller/location_controller.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/coupon_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/model/shipping_method_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/widget/address_card.dart';
import 'package:flutter_woocommerce/view/screens/checkout/widget/payment_button.dart';
import 'package:flutter_woocommerce/view/screens/order/controller/order_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/widget/profile_address_card.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final double orderAmount;
  final bool reOrder;
  final bool orderNow;
  final CouponModel coupon;
  final ShippingMethodModel shippingMethod;
  final List<CartModel> cartList;
  final int shippingIndex;
  CheckoutScreen({@required this.coupon, @required this.shippingMethod, @required this.orderAmount,  this.reOrder = false, this.cartList, this.shippingIndex, this.orderNow = false});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _noteController = TextEditingController();
  bool _isLoggedIn;
  List<CartModel> _cartList;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn) {
      Get.find<ProfileController>().getUserInfo();
    }

    _cartList = [];
    if(widget.cartList != null) {
      _cartList.addAll(widget.cartList);
      print(widget.cartList.length);
      print(_cartList.length);
    } else {
      _cartList.addAll(Get.find<CartController>().cartList);
    }
    Get.find<OrderController>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.find<OrderController>().isLoading) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar( title: 'checkout'.tr, isBackButtonExist : _isLoading ),
        body: GetBuilder<LocationController>(
          builder: (locationController) {
            return GetBuilder<ProfileController>(builder: (profileController) {
              return GetBuilder<OrderController>(builder: (orderController) {
                return ( Get.find<ConfigController>().settings.accountSettings != null) && (!_isLoggedIn || profileController.profileModel != null) ?
                Column(
                  children: [
                    Expanded(child: Scrollbar(child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: SizedBox(
                        width: Dimensions.WEB_MAX_WIDTH,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          locationController.profileBillingSelected == true ?
                          ProfileAddressCard (
                            title: 'select_billing_address'.tr,
                            address: Get.find<ProfileController>().profileBillingAddress,
                            billingAddress: true,
                            fromProfile: false,
                          ) : SizedBox(),

                          locationController.profileBillingSelected == true ? SizedBox() :
                          AddressCard(
                                title: 'select_billing_address'.tr,
                                address: locationController.selectedBillingAddressIndex == -1 ? null : locationController.addressList.isNotEmpty ? locationController.addressList[locationController.selectedBillingAddressIndex] : null,
                                billingAddress: true, fromProfile: false,
                          ),

                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          Get.find<ConfigController>().payment.length == 0 ? SizedBox() :
                          Text('choose_payment_method'.tr, style: robotoMedium),
                          Get.find<ConfigController>().payment.length == 0 ? SizedBox() :
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Get.find<ConfigController>().payment.length == 0 ? SizedBox() :
                          SizedBox(height: 65,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: Get.find<ConfigController>().payment.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return PaymentButton(
                                  isSelected: orderController.paymentMethodIndex == index,
                                  title: Get.find<ConfigController>().payment[index].title.tr,
                                  subtitle: Get.find<ConfigController>().payment[index].description.tr,
                                  icon: Get.find<ConfigController>().payment[index].icon,
                                  onTap: () => orderController.setPaymentMethod(index),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          CustomTextField(
                            controller: _noteController,
                            hintText: 'additional_note'.tr,
                            maxLines: 3,
                            inputType: TextInputType.multiline,
                            inputAction: TextInputAction.newline,
                            capitalization: TextCapitalization.sentences,
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          (!Get.find<AuthController>().isLoggedIn() && Get.find<ConfigController>().checkoutLoginReminder()) ? Padding(
                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text('returning_customer'.tr, style: robotoRegular),
                              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              InkWell(
                                onTap: () => Get.toNamed(RouteHelper.getSignInRoute()),
                                child : Text('click_here_to_login'.tr, style: robotoMedium.copyWith(color: Get.isDarkMode ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.90) : Theme.of(context).primaryColor)),
                              )
                            ]),
                          ) : SizedBox(),

                          ResponsiveHelper.isDesktop(context) ? Padding(
                            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                            child: _orderPlaceButton(orderController, profileController, locationController),
                          ) : SizedBox(),

                        ]),
                      ),
                    ))),
                     _orderPlaceButton(orderController, profileController, locationController),
                  ],
                ) : Center(child: CircularProgressIndicator());
              });
            });
          }
        ),
      ),
    );
  }

  Widget _orderPlaceButton(OrderController orderController, ProfileController profileController, LocationController locationController) {
    return Container(
      width: Dimensions.WEB_MAX_WIDTH,
      alignment: Alignment.center,
      padding: ResponsiveHelper.isDesktop(context) ? null : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      // !orderController.isLoading
      child: (!orderController.isLoading && !orderController.isPaymentLoading)  ?
      CustomButton(
        buttonText: 'confirm_order'.tr,
        radius: 50,
        onPressed: ()  async {
          print(locationController.selectedBillingAddressIndex == -1 && !locationController.profileBillingSelected);
          orderController.checkout( Get.find<ConfigController>().enabledGuestCheckout(), _isLoggedIn, (locationController.selectedBillingAddressIndex == -1 && !locationController.profileBillingSelected),
            (Get.find<ConfigController>().payment.length != 0), Get.find<ConfigController>().payment.isNotEmpty ? Get.find<ConfigController>().payment[orderController.paymentMethodIndex] : null, _noteController.text.trim(),
            locationController.profileShippingSelected ? Get.find<ProfileController>().profileShippingAddress : Get.find<ProfileController>().convertProfileAddress(locationController.addressList[widget.shippingIndex]),
            locationController.profileBillingSelected ? Get.find<ProfileController>().profileBillingAddress : locationController.selectedBillingAddressIndex != -1 ? Get.find<ProfileController>().convertProfileAddress(locationController.addressList[locationController.selectedBillingAddressIndex]) : null,
            _cartList, widget.coupon, widget.shippingMethod, widget.orderAmount, widget.orderNow,
          );
          if(orderController.isLoading || orderController.isPaymentLoading){
            if(_isLoading == true){
              setState(() {
                _isLoading = false;
              });
            }
          }

      }) : SizedBox(),
    );
  }

}
