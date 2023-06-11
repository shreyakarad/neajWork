import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/country.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/state.dart' as st;


class ZoneDropdown extends StatelessWidget {
  final bool isCountry;
  const ZoneDropdown({Key key, this.isCountry = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<CartController>(
      builder: (cartController) {
        return Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            height: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(width: 1,color: Theme.of(context).primaryColorLight.withOpacity(0.20)),
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            ),

            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                hint: Text(isCountry ? 'choose_country'.tr : 'choose_state'.tr),
                value: isCountry ? cartController.selectedCountry : cartController.selectedState,
                icon: const Icon(Icons.keyboard_arrow_down),
                items:  isCountry ? cartController.countrylist.map<DropdownMenuItem<Country>>((Country value) {
                  return DropdownMenuItem<Country>(
                    value: value,
                    child: Text(value != null ? value.name:'select_country'.tr),
                  );
                }).toList() :
                cartController.dropdownStateList.map<DropdownMenuItem<st.State>>((st.State value) {
                  return DropdownMenuItem<st.State>(
                    value: value,
                    child: Text( value != null? value.name:"select_state".tr),
                  );
                }).toList(),

                onChanged: (newValue) {
                  if(isCountry){
                    cartController.setSelectedCountry(newValue);
                  }else{
                    cartController.setSelectedState(newValue);
                  }
                },
              ),
            ),
          ),
        );
      }
    );
  }
}
