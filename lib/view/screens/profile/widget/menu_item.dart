import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isButtonActive;
  final bool isTagActive;
  final String tagText;
  final String image;
  final Function onTap;
  MenuItem({ this.icon, this.title, this.onTap, this.isButtonActive, this.isTagActive = false, this.tagText, this.image });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(image, height: 25, width: 25),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  Text( title, style: DMSansMedium.copyWith( color: Theme.of(context).primaryColor)),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                  isTagActive ? Container(
                    child: Center(child: Text( tagText, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColorLight))),
                    padding: EdgeInsets.symmetric(horizontal :Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ?  Theme.of(context).colorScheme.primaryContainer.withOpacity(0.70) : Theme.of(context).primaryColorLight.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(50)
                    )) : SizedBox(),
                ],
              ),

              Icon(Get.find<LocalizationController>().isLtr ? Icons.arrow_forward_ios_outlined : Icons.arrow_back_ios_new, size: 15, color: Theme.of(context).hintColor, ),
              // Image.asset(Images.profile_button_right_icon, height: 22, width: 22),
            ],
        )),
      ),
    );
  }
}
