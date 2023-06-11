import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/address/controller/location_controller.dart';
import 'package:flutter_woocommerce/view/screens/address/widgets/address_card_widget.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/widget/profile_address_card.dart';
import 'package:get/get.dart';

class SavedAddressScreen extends StatefulWidget {
  final bool fromBilling;
  final bool fromShipping;
  final bool fromProfile;
  SavedAddressScreen({this.fromBilling = false, this.fromShipping = false, this.fromProfile});

  @override
  _SavedAddressScreenState createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<LocationController>().getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.fromShipping ? 'shipping_address'.tr : widget.fromBilling ? 'billing_address'.tr : 'saved_address'.tr),
      body: GetBuilder<LocationController>(
        builder: (locationController) {
          return GetBuilder<ProfileController>(
            builder: (profileController) {
              return SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: SingleChildScrollView(
                child: Column(children: [
                  (profileController.profileShippingAddress1 == null && profileController.profileBillingAddress1 == null ) ? SizedBox() :
                  Container(
                     // padding: EdgeInsets.all(profileController.profileShippingAddress1.country == '' ? 0 :  Dimensions.PADDING_SIZE_LARGE),
                    padding: EdgeInsets.fromLTRB(
                        profileController.profileShippingAddress1.country == '' ? 0 : Dimensions.PADDING_SIZE_DEFAULT,
                        profileController.profileShippingAddress1.country == '' ? 0 : Dimensions.PADDING_SIZE_DEFAULT,
                        profileController.profileShippingAddress1.country == '' ? 0 : Dimensions.PADDING_SIZE_DEFAULT,
                        0
                    ),

                    child: Column(
                      children: [
                        (profileController.profileShippingAddress1.state == ''  &&  profileController.profileShippingAddress1.country == '' )  ? SizedBox() :
                        InkWell(
                          onTap: () {
                            if(!widget.fromProfile && (widget.fromShipping || widget.fromBilling)){
                              locationController.selectProShipping(widget.fromShipping);
                            }
                          },

                          child: ProfileAddressCard (
                            title: 'shipping_address'.tr,
                            address: profileController.profileShippingAddress1,
                            billingAddress: false,
                            fromProfile: true,
                            formAddress: true,
                          ),
                        ),

                        (profileController.profileShippingAddress1.state == ''  &&  profileController.profileShippingAddress1.country == '' )  ? SizedBox() : SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                        (profileController.profileBillingAddress1.state == ''  &&  profileController.profileBillingAddress1.country == '' )  ? SizedBox() :
                        InkWell(
                          onTap: () {
                            if(!widget.fromProfile && (widget.fromShipping || widget.fromBilling)){
                              locationController.selectProBilling(widget.fromBilling);
                            }
                          },
                          child: ProfileAddressCard (
                            title: 'billing_address'.tr,
                            address: profileController.profileBillingAddress1,
                            billingAddress: true,
                            fromProfile: false,
                            formAddress: true,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                    itemCount: locationController.addressList.length,
                    itemBuilder: (context, index){
                      return AddressCardWidget(
                        addressModel: locationController.addressList[index], index: index,
                        fromBilling: widget.fromBilling,fromShipping: widget.fromShipping, fromProfile: widget.fromProfile);
                    },
                  ),

                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                      child: DottedBorder (
                        borderType: BorderType.RRect,
                        color: Theme.of(context).primaryColor,
                        radius: Radius.circular(5),
                        dashPattern: [3, 2],
                        strokeWidth: 1,
                        child: Container(
                          height: 54,
                          width: Dimensions.WEB_MAX_WIDTH,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT)
                          ),
                          child: Center(child: Text('+ '+'add_address'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).primaryColor))),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getAddAddressRoute(null, -1));
                    },
                  )
                  ]),
                ));
              }
            );
          }
       )
    );
  }
}
