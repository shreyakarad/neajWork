import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/base/custom_text_field.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../../../helper/route_helper.dart';

class NewPassScreen extends StatefulWidget {
  final String resetToken;
  final String number;
  final bool fromPasswordChange;
  NewPassScreen(
      {@required this.resetToken,
      @required this.number,
      @required this.fromPasswordChange});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF2761E7),
        //appBar: CustomAppBar(title: 'reset_password'.tr),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  SizedBox(),
                  Spacer(),
                  Image.asset(
                    Images.new_logo,
                    color: Colors.white,
                    height: 50,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.offAllNamed(RouteHelper.getSignInRoute(
                          from: RouteHelper.resetPassword));
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                child: Center(
                    child: Scrollbar(
                        child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    width: context.width > 700 ? 700 : context.width,
                    padding: context.width > 700
                        ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                        : null,
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    decoration: context.width > 700
                        ? BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Colors.grey[Get.isDarkMode ? 700 : 300],
                                  blurRadius: 5,
                                  spreadRadius: 1)
                            ],
                          )
                        : null,
                    child: Column(children: [
                      Text('Create New Password',
                          style: poppinsBold.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              // decoration: TextDecoration.underline,
                              color: Colors.black)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Please enter a new password and confirm it below to reset your password.',
                          style: poppinsRegular,
                          textAlign: TextAlign.center),
                      SizedBox(height: 50),
                      Container(
                        child: Column(children: [
                          CustomTextField(
                            hintText: 'new_password'.tr,
                            controller: _newPasswordController,
                            focusNode: _newPasswordFocus,
                            nextFocus: _confirmPasswordFocus,
                            inputType: TextInputType.visiblePassword,
                            // prefixIcon: Images.lock,
                            isPassword: true,
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          CustomTextField(
                            hintText: 'confirm_password'.tr,
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocus,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                            // prefixIcon: Images.lock,
                            isPassword: true,
                          ),
                        ]),
                      ),
                      SizedBox(height: 30),
                      GetBuilder<AuthController>(builder: (authBuilder) {
                        return (!authBuilder.isLoading)
                            ? GestureDetector(
                                onTap: () {
                                  _resetPassword(
                                      widget.number,
                                      widget.resetToken,
                                      _newPasswordController.text);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2761E7),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Reset Password',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              )
                            // CustomButton(
                            //         buttonText: 'done'.tr,
                            //         radius: Dimensions.RADIUS_EXTRA_LARGE,
                            //         onPressed: () => _resetPassword(
                            //             widget.number,
                            //             widget.resetToken,
                            //             _newPasswordController.text),
                            //       )
                            : Center(child: CircularProgressIndicator());
                      }),
                    ]),
                  ),
                ))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetPassword(String email, String otp, String password) async {
    String _password = _newPasswordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 4) {
      showCustomSnackBar('password_should_be'.tr);
    } else if (_password != _confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    } else {
      Response response =
          await Get.find<AuthController>().resetPassword(otp, email, password);
      if (response.body['status'] == '200') {
        Get.offAllNamed(
            RouteHelper.getSignInRoute(from: RouteHelper.resetPassword));
      } else {
        showCustomSnackBar(response.body['status']);
      }
    }
  }
}
