import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/staticData.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/base/custom_text_field.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/forget/verification_screen.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPassScreen extends StatefulWidget {
  ForgetPassScreen();

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  String email;
  String token;
  int pageRoute = 0;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  ///screen verify
  Timer _timer;
  int _seconds = 0;
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xFF2761E7),
          child: pageRoute == 0
              ? forgotPasswordUI()
              : pageRoute == 1
                  ? verifyOtpUI(context)
                  : setPasswordUI(context),
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
          // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
          // GetBuilder<AuthController>(builder: (authController) {
          //   return !authController.isLoading
          //       ? CustomButton(
          //     radius: Dimensions.RADIUS_EXTRA_LARGE,
          //     buttonText: 'next'.tr,
          //     onPressed: () => _forgetPass(_emailController.text),
          //   )
          //       : Center(child: CircularProgressIndicator());
          // }),
          //]
          // ),
          //),)
          // )
          //
          //
          // ),,
        ),
      ),
    );
  }

  ///view for set password
  Column setPasswordUI(BuildContext context) {
    return Column(
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
                              color: Colors.grey[Get.isDarkMode ? 700 : 300],
                              blurRadius: 5,
                              spreadRadius: 1)
                        ],
                      )
                    : null,
                child: Column(children: [
                  SizedBox(
                    height: 50,
                  ),
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
                    return GestureDetector(
                      onTap: () {
                        _resetPassword(
                            email, token, _newPasswordController.text);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Color(0xFF2761E7),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: (!authBuilder.isLoading)
                            ? Center(
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )
                            : Center(child: StaticData.commonLoader()),
                      ),
                    );
                    // CustomButton(
                    //         buttonText: 'done'.tr,
                    //         radius: Dimensions.RADIUS_EXTRA_LARGE,
                    //         onPressed: () => _resetPassword(
                    //             widget.number,
                    //             widget.resetToken,
                    //             _newPasswordController.text),
                    //       )
                  }),
                ]),
              ),
            )),
          ),
        ),
      ],
    );
  }

  ///view for set verify otp
  Column verifyOtpUI(BuildContext context) {
    return Column(
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
            child: Scrollbar(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                width: context.width > 700 ? 700 : context.width,
                padding: context.width > 700
                    ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                    : null,
                margin: context.width > 700
                    ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                    : null,
                decoration: context.width > 700
                    ? BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[Get.isDarkMode ? 700 : 300],
                              blurRadius: 5,
                              spreadRadius: 1)
                        ],
                      )
                    : null,
                child: GetBuilder<AuthController>(builder: (authController) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),

                        Text('Reset Your Password',
                            style: poppinsBold.copyWith(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                // decoration: TextDecoration.underline,
                                color: Colors.black)),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    //text: 'enter_the_verification_sent_to'.tr,
                                    text:
                                        'We just sent an email to the address you provided. Please enter the 4-digit OTP from the email below to reset your password on.',
                                    style: robotoRegular.copyWith(
                                        color:
                                            Theme.of(context).disabledColor)),
                                TextSpan(
                                    text: ' $email',
                                    style: robotoMedium.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color)),
                              ]),
                              textAlign: TextAlign.center),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 39, vertical: 35),
                          child: PinCodeTextField(
                            length: 4,
                            appContext: context,
                            keyboardType: TextInputType.number,
                            animationType: AnimationType.none,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              fieldHeight: 60,
                              fieldWidth: 60,
                              borderWidth: 1,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SMALL),
                              selectedColor: Color(0xFF2761E7).withOpacity(0.2),
                              selectedFillColor: Colors.white,
                              inactiveFillColor: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.2),
                              inactiveColor: Color(0xFF2761E7).withOpacity(0.2),
                              activeColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                              activeFillColor: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.2),
                            ),
                            // animationDuration: Duration(milliseconds: 300),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: authController.updateVerificationCode,
                            beforeTextPaste: (text) => true,
                          ),
                        ),

                        // (widget.password != null && widget.password.isNotEmpty) ?
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'did_not_receive_the_code'.tr,
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context).disabledColor),
                              ),
                              TextButton(
                                onPressed: _seconds < 1
                                    ? () async {
                                        Response response =
                                            await Get.find<AuthController>()
                                                .forgetPassword(email);
                                        if (response.body['status'] == '200') {
                                          _startTimer();
                                          showCustomSnackBar(
                                              'resend_code_successful'.tr,
                                              isError: false);
                                          print(response.body['otp']);
                                          // Get.toNamed(RouteHelper.getVerificationRoute());
                                        }
                                      }
                                    : null,
                                child: Text(
                                    '${'resend'.tr}${_seconds > 0 ? ' ($_seconds)' : ''}',
                                    style: poppinsRegular.copyWith(
                                        color: Color(0xFF2761E7))),
                              ),
                            ]),
                        //: SizedBox(),

                        authController.verificationCode.length == 4
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _verifyEmail(
                                        email, authController.verificationCode);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2761E7),
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: !authController.isLoading
                                        ? Center(
                                            child: Text(
                                              'Verify',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          )
                                        : Center(
                                            child: StaticData.commonLoader()),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ]);
                }),
              ),
            )),
          ),
        ),
      ],
    );
  }

  ///view for forgot pass
  Column forgotPasswordUI() {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       SizedBox(),
        //       Image.asset(Images.new_logo, height: 50, color: Colors.white),
        //       Padding(
        //         padding: const EdgeInsets.only(right: 20),
        //         child: GestureDetector(
        //           onTap: () {
        //             Get.back();
        //           },
        //           child: Icon(
        //             Icons.close,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

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
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text('Forgot Your Password?',
                      style: poppinsBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          // decoration: TextDecoration.underline,
                          color: Colors.black)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Please enter the email address associated with your account and click the button below. We\'ll send you an email with a 4-digit OTP to reset your password.',
                      style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          // decoration: TextDecoration.underline,
                          color: Colors.grey)),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    //focusNode: _passwordFocus,
                    inputAction: TextInputAction.done,
                    hintText: 'Email Address',
                    controller: _emailController,
                    inputType: TextInputType.text,
                    divider: false,
                    sufixIcon: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GetBuilder<AuthController>(builder: (authController) {
                    return GestureDetector(
                      onTap: () {
                        _forgetPass(_emailController.text);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Color(0xFF2761E7),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: !authController.isLoading
                            ? Center(
                                child: Text(
                                  'Send OTP',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )
                            : Center(child: StaticData.commonLoader()),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ))
      ],
    );
  }

  ///forgot pass
  void _forgetPass(String userName) async {
    if (userName.isEmpty) {
      showCustomSnackBar('enter_email_or_username'.tr);
    } else {
      Response response =
          await Get.find<AuthController>().forgetPassword(userName);
      if (response.body['status'] == '200') {
        // print(response.body['otp']);
        setState(() {
          pageRoute = 1;

          email = response.body['email'];
          print('widget email---${email}');
        });
        _startTimer();
        // Get.toNamed(RouteHelper.getVerificationRoute(_email, '', '', ''));
      } else {
        showCustomSnackBar('no_user_found_with'.tr + ' ' + userName);
      }
    }
  }

  ///verify otp timer
  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if (_seconds == 0) {
        timer?.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  ///verify otp
  void _verifyEmail(String userName, String otp) async {
    if (otp.isEmpty) {
      showCustomSnackBar('enter_email_or_username'.tr);
    } else {
      Response response =
          await Get.find<AuthController>().verifyEmail(userName, otp);
      if (response.body['status'] == '200') {
        if (response.body['code'] == 'Success') {
          showCustomSnackBar('OTP_verified_successfully'.tr, isError: false);
          // Get.toNamed(RouteHelper.getResetPasswordRoute(
          //     userName, otp, 'reset-password'));

          setState(() {
            token = otp;
            pageRoute = 2;
          });
        }
      } else {
        if (response.body['messege'] ==
            'The OTP Must Be Provided Within 60 Seconds.') {
          showCustomSnackBar('the_OTP_must_be_provided'.tr);
        } else if (response.body['messege'] == 'Provided OTP Does Not Match.') {
          showCustomSnackBar('provided_OTP_does_not'.tr);
        } else if (response.body['code'] == 'OTP Expired!') {
          showCustomSnackBar('otp_expired'.tr);
        } else {
          showCustomSnackBar(response.body['messege']);
        }
      }
    }
  }

  ///set pass
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
