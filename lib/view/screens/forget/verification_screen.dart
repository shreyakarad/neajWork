import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  final String number;
  final bool fromSignUp;
  final String token;
  final String password;
  VerificationScreen({@required this.number, @required this.password, @required this.fromSignUp,
    @required this.token});
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String _number;
  Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _number = widget.number;
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if(_seconds == 0) {
        timer?.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'otp_verification'.tr),
      body: SafeArea(child: Center(child: Scrollbar(child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: context.width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
          margin: context.width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
          decoration: context.width > 700 ? BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], blurRadius: 5, spreadRadius: 1)],
          ) : null,
          child: GetBuilder<AuthController>(builder: (authController) {
            return Column(children: [
              RichText(text: TextSpan(children: [
                TextSpan(text: 'enter_the_verification_sent_to'.tr, style: robotoRegular.copyWith(color: Theme.of(context).disabledColor)),
                TextSpan(text: ' $_number', style: robotoMedium.copyWith(color: Theme.of(context).textTheme.bodyText1.color)),
              ]), textAlign: TextAlign.center),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 35),
                child: PinCodeTextField(
                  length:4,
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.slide,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 60,
                    fieldWidth: 60,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Theme.of(context).disabledColor.withOpacity(0.2),
                    inactiveColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    activeColor: Theme.of(context).primaryColor.withOpacity(0.4),
                    activeFillColor: Theme.of(context).disabledColor.withOpacity(0.2),
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: authController.updateVerificationCode,
                  beforeTextPaste: (text) => true,
                ),
              ),

              // (widget.password != null && widget.password.isNotEmpty) ?
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'did_not_receive_the_code'.tr,
                  style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
                ),
                TextButton(
                  onPressed: _seconds < 1 ? () async {
                    Response response = await  Get.find<AuthController>().forgetPassword(widget.number);
                    if(response.body['status'] == '200'){
                      _startTimer();
                      showCustomSnackBar('resend_code_successful'.tr, isError: false);
                      print(response.body['otp']);
                      // Get.toNamed(RouteHelper.getVerificationRoute());
                    }
                  } : null,
                  child: Text('${'resend'.tr}${_seconds > 0 ? ' ($_seconds)' : ''}', style: poppinsRegular),
                ),
              ]),
                  //: SizedBox(),

              authController.verificationCode.length == 4 ? !authController.isLoading ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: CustomButton(
                  radius: Dimensions.RADIUS_EXTRA_LARGE,
                  buttonText: 'verify'.tr,
                  onPressed: () {
                    //Get.toNamed(RouteHelper.getResetPasswordRoute(widget.number,  authController.verificationCode, 'reset-password'));
                    _verifyEmail(widget.number, authController.verificationCode);
                  }
              ),
              ) : Center(child: CircularProgressIndicator()) : SizedBox.shrink(),

            ]);
          }),
        ),
      )))),
    );
  }

  void _verifyEmail(String userName, String otp) async {
    if (otp.isEmpty) {
      showCustomSnackBar('enter_email_or_username'.tr);
    }else {
      Response response = await  Get.find<AuthController>().verifyEmail(userName, otp);
      if(response.body['status'] == '200'){
        if(response.body['code'] == 'Success') {
          showCustomSnackBar('OTP_verified_successfully'.tr, isError: false);
          Get.toNamed(RouteHelper.getResetPasswordRoute(userName, otp, 'reset-password'));
        }
      }else {
        if(response.body['messege'] == 'The OTP Must Be Provided Within 60 Seconds.'){
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
}
