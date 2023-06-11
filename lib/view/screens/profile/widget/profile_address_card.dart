import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/address/saved_address_screen.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/profile_model.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import '../../../../util/images.dart';

class ProfileAddressCard extends StatelessWidget {
  final String title;
  final bool billingAddress;
  final bool fromProfile;
  final ProfileAddressModel address;
  final bool formAddress;
  const ProfileAddressCard({@required this.title, @required this.billingAddress, @required this.fromProfile, this.address, this.formAddress = false});

  @override
  Widget build(BuildContext context) {
    return formAddress ?
    Container(
      width: Dimensions.WEB_MAX_WIDTH,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      // padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, 0),
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
                      Text('${address.firstName} ${address.lastName}', style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                      SizedBox(),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Text( billingAddress ? 'billing'.tr : 'shipping'.tr, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Colors.transparent,
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                        border: Border.all(color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).primaryColorLight)
                    ),
                  ),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

            Text('${address.address1} ${address.address2} ${address.city} ${address.postcode}, ${address.state != null ?  address.state : ''} , ${address.country} ', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.labelSmall.color)),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

            Text('${address.phone}', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.labelSmall.color)),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            billingAddress ?
            Text('${address.email}', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.labelSmall.color)) : SizedBox(),
            billingAddress ? SizedBox(height: Dimensions.PADDING_SIZE_SMALL) : SizedBox(),
          ],
        ),
    ) :
    Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 200], blurRadius: 10)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        GetBuilder<CartController>(
          builder: (cartController) {
            return InkWell(
              onTap: () => cartController.isLoading ? null : formAddress ? null : Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => SavedAddressScreen(fromBilling: billingAddress, fromShipping: !billingAddress, fromProfile: fromProfile))),
              child: Row(
                children: [
                  Expanded(child: Text(title, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
                  formAddress ? SizedBox() : cartController.isLoading ? SizedBox(height: 20, width:20, child: CircularProgressIndicator()) : Image.asset(Images.choose_address_image, height: 20, scale: 3),
                ],
              ),
            );
          }
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        address != null ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          address.firstName != '' ? Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Row(children: [
              Text('name'.tr + ':',
                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Expanded(child: Text(
                (address.firstName != null && address.lastName != null) ? (address.firstName + ' ' + address.lastName) : '',
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
              )),
            ]),
          ) : SizedBox(),

          address.address1 != '' ? Row(children: [
            Text('address'.tr + ':',
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Expanded(child: Text(
              address.address1 ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
            )),
          ]) : SizedBox(),

          Wrap(children: [
            (address.city != '' && address.city.isNotEmpty) ? Text('city'.tr+ ': ' + address.city + ', ',
              maxLines: 1, overflow: TextOverflow.ellipsis, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
            ) : SizedBox(),

            (address.state != '' && address.state != null ) ? Text('state'.tr +': ' + address.state + ', ',
              maxLines: 1, overflow: TextOverflow.ellipsis, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
            ) : SizedBox(),

            (address.postcode != null && address.postcode.isNotEmpty) ? Text('post_code'.tr+': ' + address.postcode,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
            ) : SizedBox(),

            (address.country != '' && address.country != null) ? Text('country'.tr+': ' + address.country,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
            ) : SizedBox(),

          ]),
          SizedBox(height: (address.phone != null && address.phone.isNotEmpty) ? Dimensions.PADDING_SIZE_SMALL : 0),

          (address.phone != null && address.phone.isNotEmpty) ? Text(
            address.phone ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
          ) : SizedBox(),

          (address.email != null && address.email.isNotEmpty) ? Text(
            address.email ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
          ) : SizedBox(),
        ]) : SizedBox(),
        SizedBox(height: address != null ? Dimensions.PADDING_SIZE_SMALL : 0),
        address == null ? Center(child: CircularProgressIndicator()) : (address.country == '' && address.state == '' && address.firstName == '' && address.firstName == '') ?
        Center(child: Text(billingAddress ? 'add_billing_address'.tr : 'add_shipping_address'.tr, style: poppinsRegular.copyWith(color: Colors.red, fontSize: Dimensions.fontSizeSmall))) :
        SizedBox(),

      ]),
    );
  }
}
