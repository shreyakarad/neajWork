import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/home/controller/banner_controller.dart';
import 'package:get/get.dart';

class BlogBanner extends StatelessWidget {
  const BlogBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(builder: (bannerController) {
      return (bannerController.bannerList != null && bannerController.bannerList.isNotEmpty) ?
      Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.4,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                  child: GetBuilder<AuthController>(builder: (splashController) {
                    return CustomImage(
                      image: '${bannerController.bannerList[0].image}',
                      fit: BoxFit.cover,
                    );
                  },
                  ),
                )
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:  EdgeInsets.fromLTRB( 50, MediaQuery.of(context).size.width * 0.28,50, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(width: .7, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Text('visit_us'.tr, style: robotoRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeExtraLarge),),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ): SizedBox();
    });
  }
}
