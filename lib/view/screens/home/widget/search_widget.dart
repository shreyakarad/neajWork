import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/util/color_utils.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_text_field.dart';
import 'package:get/get.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key key}) : super(key: key);
  FocusNode _searchFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(
      //     left: Dimensions.PADDING_SIZE_DEFAULT,
      //     right: Dimensions.PADDING_SIZE_DEFAULT,
      //     top: Dimensions.PADDING_SIZE_LARGE),
      child: Column(
        children: [
          // Container(
          //   child:
          //   Row(children: [
          //     // Padding(
          //     //     padding: EdgeInsets.fromLTRB(  Get.find<LocalizationController>().isLtr ? Dimensions.PADDING_SIZE_DEFAULT : Dimensions.PADDING_SIZE_EXTRA_SMALL,
          //     //         Dimensions.PADDING_SIZE_MEDIUM,
          //     //         Get.find<LocalizationController>().isLtr ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_MEDIUM),
          //     //     child: Image.asset(Images.search, height: Dimensions.PADDING_SIZE_EXTRA_LARGE, width: Dimensions.PADDING_SIZE_EXTRA_LARGE)),
          //     Padding(
          //         padding: EdgeInsets.fromLTRB(
          //             Get.find<LocalizationController>().isLtr
          //                 ? Dimensions.PADDING_SIZE_DEFAULT
          //                 : Dimensions.PADDING_SIZE_EXTRA_SMALL,
          //             Dimensions.PADDING_SIZE_MEDIUM,
          //             Get.find<LocalizationController>().isLtr
          //                 ? Dimensions.PADDING_SIZE_EXTRA_SMALL
          //                 : Dimensions.PADDING_SIZE_DEFAULT,
          //             Dimensions.PADDING_SIZE_MEDIUM),
          //         child: Image.asset(Images.search,
          //             height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
          //             width: Dimensions.PADDING_SIZE_EXTRA_LARGE)),
          //     Text('what_are_you_looking_for'.tr,
          //         style: robotoRegular.copyWith(
          //             fontSize: Dimensions.fontSizeSmall,
          //             color: Theme.of(context).hintColor)),
          //   ]),
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).cardColor,
          //     border: Border.all(color: ColorUtils.lightGrey),
          //     borderRadius:
          //         BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
          //   ),
          // ),

          CustomTextField(
            fieldHeight: 40,
            hintText: 'Find your perfect match...',
            textAlign: TextAlign.left,
            // controller: _passwordController,
            focusNode: _searchFocus,
            verticalContentPadding: 0.0,
            inputAction: TextInputAction.done,
            inputType: TextInputType.visiblePassword,
            prefixIcon: Images.search,
          ),
        ],
      ),
      // decoration: BoxDecoration(
      //   // gradient: LinearGradient(
      //   //   begin: Alignment.topCenter,
      //   //   end: Alignment.bottomCenter,
      //   //   colors: Get.isDarkMode
      //   //       ? [
      //   //           Theme.of(context).primaryColorLight,
      //   //           Theme.of(context).primaryColorLight
      //   //         ]
      //   //       : [Color(0xFFC0BAFB), Color(0xFFe6e5f8)],
      //   // ),
      //   borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE)),
      //   //border: Border.all(color: Theme.of(context).primaryColorLight),
      // ),
    );
  }
}
