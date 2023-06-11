import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/confirmation_dialog.dart';
import 'package:flutter_woocommerce/view/screens/address/add_address_screen.dart';
import 'package:flutter_woocommerce/view/screens/address/controller/location_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/address_model.dart';
import 'package:get/get.dart';

class AddressCardWidget extends StatelessWidget {
  final AddressModel addressModel;
  final int index;
  final bool fromBilling;
  final bool fromShipping;
  final bool fromProfile;
  const AddressCardWidget({Key key, this.addressModel, this.index, this.fromBilling = false, this.fromShipping = false, this.fromProfile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_EXTRA_SMALL, Dimensions.PADDING_SIZE_DEFAULT, 15, 0),
      child: InkWell(
        onTap: () {
          if(fromProfile && fromShipping) {
            Get.find<ProfileController>().setProfileAddress(addressModel, fromShipping);
            Get.find<LocationController>().setProfileSelectedShippingAddressIndex(index);
            Get.back();
          } else if (fromProfile && fromBilling) {
            Get.find<ProfileController>().setProfileAddress(addressModel, false);
            Get.find<LocationController>().setProfileSelectedBillingAddressIndex(index);
            Get.back();
          }
          else if(fromBilling){
            Get.find<LocationController>().setBillingAddressIndex(index);
            Get.find<LocationController>().setProfileSelectedBillingAddressIndex(index);
            Get.back();
          }else if(fromShipping){
            Get.find<LocationController>().setShippingAddressIndex(index, notify: true);
            Get.find<LocationController>().setProfileSelectedShippingAddressIndex(index);
            Get.back();
          }
        },

        child: Container(
          width: Dimensions.WEB_MAX_WIDTH,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all( Radius.circular(Dimensions.RADIUS_LARGE)),
            border: Border.all(color: Theme.of(context).primaryColorLight.withOpacity(0.20)),
          ),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${addressModel.firstName} ${addressModel.lastName}', style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                      InkWell(child: Image.asset(Images.editAddress, height: 20, width: 20),
                        onTap: () {
                          Get.to(()=> AddAddressScreen(address: addressModel, index: index, fromEdit: true));
                      }),
                    ],
                  ),

                  InkWell(
                    child: Image.asset(Images.deleteAddress, height: 20, width: 20),
                    onTap: () {
                      Get.dialog(ConfirmationDialog(icon: Images.deleteAddress, description: 'are_you_sure_to_delete_address'.tr, isLogOut: true, onYesPressed: () {
                        Get.find<LocationController>().removeFromAddressList(index);
                        Get.back();
                      }), useSafeArea: false);
                  }),
                ]),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              Text('${addressModel.address1} ${addressModel.address2} ${addressModel.city} ${addressModel.postcode}, ${addressModel.state != null ?  addressModel.state.name : ''} , ${addressModel.country.name} ', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.labelSmall.color)),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

              Text('${addressModel.phone}', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.labelSmall.color)),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text('${addressModel.email}', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.labelSmall.color)),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            ],
          ),
        ),
      ),
    );
  }
}

