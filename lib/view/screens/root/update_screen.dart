import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateScreen extends StatefulWidget {
  final bool isUpdate;
  UpdateScreen({@required this.isUpdate});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              widget.isUpdate ? Images.update : Images.maintenance,
              width: MediaQuery.of(context).size.height * 0.4,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              widget.isUpdate ? 'update'.tr : 'we_are_under_maintenance'.tr,
              style: robotoBold.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.023,
                  color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              widget.isUpdate
                  ? 'your_app_is_deprecated'.tr
                  : 'we_will_be_right_back'.tr,
              style: robotoRegular.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.0175,
                  color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height: widget.isUpdate
                    ? MediaQuery.of(context).size.height * 0.04
                    : 0),
            widget.isUpdate
                ? CustomButton(
                    buttonText: 'update_now'.tr,
                    onPressed: () async {
                      String _appUrl = 'https://google.com';
                      if (GetPlatform.isAndroid) {
                        _appUrl =
                            'https://play.google.com/store/apps/details?id=com.newness.in&pli=1';
                        //_appUrl = Get.find<ConfigController>().config.appUrlAndroid;
                      } else if (GetPlatform.isIOS) {
                        _appUrl =
                            'https://apps.apple.com/bh/app/newness/id1619796369';
                        //_appUrl = Get.find<ConfigController>().config.appUrlIos;
                      }
                      if (await canLaunchUrlString(_appUrl)) {
                        launchUrlString(_appUrl);
                      } else {
                        showCustomSnackBar('${'can_not_launch'.tr} $_appUrl');
                      }
                    })
                : SizedBox(),
          ]),
        ),
      ),
    );
  }
}
