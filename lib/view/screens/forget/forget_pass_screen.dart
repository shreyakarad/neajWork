import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/base/custom_text_field.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

class ForgetPassScreen extends StatefulWidget {
  ForgetPassScreen();

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'forgot_password'.tr),
      body: Scaffold(
        body: Column(
          children: [],
        ),
      ),
      // body: SafeArea(
      //     child: Center(
      //         child: Container(
      //   width: context.width > 700 ? 700 : context.width,
      //   padding: context.width > 700
      //       ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
      //       : null,
      //   margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      //   decoration: context.width > 700
      //       ? BoxDecoration(
      //           color: Theme.of(context).cardColor,
      //           borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
      //           boxShadow: [
      //             BoxShadow(
      //                 color: Colors.grey[Get.isDarkMode ? 700 : 300],
      //                 blurRadius: 5,
      //                 spreadRadius: 1)
      //           ],
      //         )
      //       : null,
      //   child: SingleChildScrollView(
      //     child: Column(children: [
      //       Image.asset(Images.forgot, height: 220),
      //       Padding(
      //         padding: EdgeInsets.all(30),
      //         child: Text('please_enter_email_or_username'.tr,
      //             style: poppinsRegular, textAlign: TextAlign.center),
      //       ),
      //       CustomTextField(
      //         hintText: '',
      //         controller: _emailController,
      //         inputType: TextInputType.text,
      //         divider: false,
      //       ),
      //       SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
      //       GetBuilder<AuthController>(builder: (authController) {
      //         return !authController.isLoading
      //             ? CustomButton(
      //                 radius: Dimensions.RADIUS_EXTRA_LARGE,
      //                 buttonText: 'next'.tr,
      //                 onPressed: () => _forgetPass(_emailController.text),
      //               )
      //             : Center(child: CircularProgressIndicator());
      //       }),
      //     ]),
      //   ),
      // ))
      //
      //
      // ),
    );
  }

  void _forgetPass(String userName) async {
    if (userName.isEmpty) {
      showCustomSnackBar('enter_email_or_username'.tr);
    } else {
      Response response =
          await Get.find<AuthController>().forgetPassword(userName);
      if (response.body['status'] == '200') {
        // print(response.body['otp']);
        String _email = response.body['email'];
        Get.toNamed(RouteHelper.getVerificationRoute(_email, '', '', ''));
      } else {
        showCustomSnackBar('no_user_found_with'.tr + ' ' + userName);
      }
    }
  }
}
