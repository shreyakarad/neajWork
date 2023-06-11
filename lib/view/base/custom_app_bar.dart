import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final Function onBackPressed;
  final bool showCart;
  CustomAppBar({@required this.title, this.isBackButtonExist = true, this.onBackPressed, this.showCart = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Get.isDarkMode ? Theme.of(context).cardColor : Theme.of(context).primaryColorLight,
      centerTitle: true,
      title: Text(title, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor)),
      elevation: 0,
      titleSpacing: 0,
      leading: isBackButtonExist ? IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
        color: Theme.of(context).textTheme.bodyLarge.color,
        onPressed: () => onBackPressed != null ? onBackPressed() : Navigator.pop(context),
      ) : SizedBox(),
      // backgroundColor: Theme.of(context).primaryColorDark,
      actions: showCart ? [
        InkWell(
          child: Image.asset(Images.appbar_cart, height: 25, width: 25),
          onTap: () {},
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

        InkWell(
          child: Image.asset(Images.appbar_search, height: 25, width: 25),
          onTap: () {},
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
      ] : [],

      // flexibleSpace: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: <Color>[
      //           Theme.of(context).primaryColorLight,
      //           Theme.of(context).primaryColorLight,
      //         ],
      //     )),
      // ),
    );
  }

  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH, GetPlatform.isDesktop ? 70 : 60);
}