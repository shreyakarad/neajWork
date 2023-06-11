import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/address/saved_address_screen.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/address_model.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import '../../../../util/images.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final AddressModel address;
  final bool billingAddress;
  final bool fromProfile;
  const AddressCard({@required this.title, @required this.address, @required this.billingAddress, @required this.fromProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onTap: () =>  cartController.isLoading ? null : Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => SavedAddressScreen(fromBilling: billingAddress, fromShipping: !billingAddress, fromProfile: false))),
              child: Row(
                children: [
                  Expanded(child: Text(title, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
                  cartController.isLoading ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator()) : Image.asset(Images.choose_address_image, height: 25, scale: 3),
                ],
              ),
            );
          }
        ),

        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        address != null ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          address.firstName != null ? Padding(
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

          address.address1 != null ? Row(children: [
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
            (address.city != null && address.city.isNotEmpty) ? Text('city'.tr+ ': ' + address.city + ', ',
              maxLines: 1, overflow: TextOverflow.ellipsis, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
            ) : SizedBox(),

            (address.state != null && address.state != null ) ? Text('state'.tr +': ' + address.state.name + ', ',
              maxLines: 1, overflow: TextOverflow.ellipsis, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
            ) : SizedBox(),

            (address.postcode != null && address.postcode.isNotEmpty) ? Text('post_code'.tr+': ' + address.postcode,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
            ) : SizedBox(),

            (address.country != null && address.country != null) ? Text('country'.tr+': ' + address.country.name,
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
      ]),
    );
  }
}
