import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/auth/model/signup_body.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../util/shared_pref.dart';

List<String> genders = ['Male', 'Female', 'Other'];

class SignInScreen extends StatefulWidget {
  final String from;

  const SignInScreen({Key key, this.from}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();

  bool isTapOnSignUp = false;
  String selectedGender = genders.first;
  DateTime selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    print('PrefManagerUtils.getCountry-------${PrefManagerUtils.getCountry()}');

    super.initState();
    _emailController.text = Get.find<AuthController>().getUserEmail() ?? '';
    _passwordController.text =
        Get.find<AuthController>().getUserPassword() ?? '';
    // Get.find<AuthController>().authenticateWithBiometric(null, true);
    if (_passwordController.text != '') {
      Get.find<AuthController>().setRememberMe();
    }
    print(widget.from);
  }

  @override
  Widget build(BuildContext context) {
    print("isTapOnSignUp === $isTapOnSignUp");
    return Scaffold(
      // appBar: CustomAppBar(
      //     title: 'sign_in'.tr,
      //     onBackPressed: () {
      //       if (widget.from == RouteHelper.resetPassword) {
      //         Get.offAllNamed(RouteHelper.getInitialRoute());
      //       } else {
      //         Get.back();
      //       }
      //     }),
      body: WillPopScope(
        onWillPop: () async {
          if (widget.from == RouteHelper.resetPassword) {
            return Get.offAllNamed(RouteHelper.getInitialRoute());
          } else {
            Get.back();
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Color(0xff2761E7),
          body: Column(
            children: [
              SizedBox(height: 40),

              ///top logo and back icon
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.white,
                        )),
                    Spacer(),
                    Image.asset(
                      Images.new_logo,
                      color: Colors.white,
                      height: 50,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed(RouteHelper.getInitialRoute());
                      },
                      child: Text('Skip',
                          style: poppinsBold.copyWith(
                              color: Colors.white,
                              fontSize: Dimensions.fontSizeDefault)),
                    ),
                  ],
                ),
              ),

              ///bottom view
              isTapOnSignUp == true
                  ? Expanded(
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: GetBuilder<AuthController>(
                                builder: (authController) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 40),
                                  Text('Sign Up',
                                      style: poppinsBold.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeOverLarge)),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _passwordController.clear();
                                        _emailController.clear();
                                        isTapOnSignUp = false;
                                      });
                                      //Get.toNamed(RouteHelper.getSignInRoute());
                                    },
                                    child: Row(
                                      children: [
                                        Text("Already have an account? ",
                                            style: poppinsMedium.copyWith(
                                                color: Color(0xff7A869A),
                                                fontSize: Dimensions
                                                    .fontSizeDefault)),
                                        Text("Log In",
                                            style: poppinsMedium.copyWith(
                                                color: Color(0xff0041C4),
                                                fontSize: Dimensions
                                                    .fontSizeDefault)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  CustomTextField(
                                    hintText: 'Full Name',
                                    controller: _firstNameController,
                                    focusNode: _firstNameFocus,
                                    nextFocus: _emailFocus,
                                    inputType: TextInputType.name,
                                    capitalization: TextCapitalization.words,
                                    sufixIcon: Icon(Icons.person_outlined),
                                    divider: false,
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextField(
                                    hintText: 'E-mail ID',
                                    controller: _emailController,
                                    focusNode: _emailFocus,
                                    nextFocus: _passwordFocus,
                                    inputType: TextInputType.emailAddress,
                                    sufixIcon: Icon(
                                      Icons.email_outlined,
                                    ),
                                    divider: false,
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextField(
                                    hintText: 'password'.tr,
                                    controller: _passwordController,
                                    focusNode: _passwordFocus,
                                    inputAction: TextInputAction.done,
                                    inputType: TextInputType.visiblePassword,
                                    isPassword: true,
                                    onSubmit: (text) => (GetPlatform.isWeb &&
                                            authController.acceptTerms)
                                        ? _register(authController)
                                        : null,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColorLight
                                                  .withOpacity(0.50),
                                            ),
                                          ),
                                          child:
                                              DropdownButtonFormField<String>(
                                            icon:
                                                Icon(Icons.keyboard_arrow_down),
                                            value: selectedGender,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                selectedGender = newValue;
                                              });
                                            },
                                            items: genders
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeLarge),
                                                ),
                                              );
                                            }).toList(),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 8.0),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                          child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColorLight
                                                      .withOpacity(0.50),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      selectedDate == null
                                                          ? "Birthdate"
                                                          : "${DateFormat("dd MMM yyyy").format(selectedDate)}",
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeLarge),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      size: 20,
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL),
                                  Row(children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        activeColor: Get.isDarkMode
                                            ? Color(0xFF3B62FF)
                                            : Color(0xFF3B62FF),
                                        value: authController.acceptTerms,
                                        onChanged: (bool isChecked) =>
                                            authController.toggleTerms(),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    InkWell(
                                        onTap: () {
                                          authController.toggleTerms();
                                        },
                                        child: Text('I accept the',
                                            style: robotoRegular.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(.75)))),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(RouteHelper.getHtmlRoute(
                                            'terms-and-condition'));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                        child: Text('terms_conditions'.tr,
                                            style: robotoMedium.copyWith(
                                                color: Color(0xFF3B62FF))),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      _register(authController);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF2761E7),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Create account',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text('or',
                                        style: poppinsBold.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            // decoration: TextDecoration.underline,
                                            color:
                                                Colors.black.withOpacity(0.3))),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF4167B2),
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Facebook',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE95B25),
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Google',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: GetBuilder<AuthController>(
                                builder: (authController) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 40),
                                  Text('Login',
                                      style: poppinsBold.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeOverLarge)),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isTapOnSignUp = true;
                                        _passwordController.clear();
                                        _emailController.clear();
                                      });
                                      //Get.toNamed(RouteHelper.getSignUpRoute());
                                    },
                                    child: Row(
                                      children: [
                                        Text("Don't have an account? ",
                                            style: poppinsMedium.copyWith(
                                                color: Color(0xff7A869A),
                                                fontSize: Dimensions
                                                    .fontSizeDefault)),
                                        Text("Sign up",
                                            style: poppinsMedium.copyWith(
                                                color: Color(0xff0041C4),
                                                fontSize: Dimensions
                                                    .fontSizeDefault)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  CustomTextField(
                                    hintText: 'E-mail ID',
                                    controller: _emailController,
                                    focusNode: _emailFocus,
                                    nextFocus: _passwordFocus,
                                    inputType: TextInputType.emailAddress,
                                    sufixIcon: Icon(
                                      Icons.email_outlined,
                                    ),
                                    divider: false,
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextField(
                                    hintText: 'password'.tr,
                                    controller: _passwordController,
                                    focusNode: _passwordFocus,
                                    inputAction: TextInputAction.done,
                                    inputType: TextInputType.visiblePassword,
                                    isPassword: true,
                                    onSubmit: (text) => (GetPlatform.isWeb &&
                                            authController.acceptTerms)
                                        ? _login(authController)
                                        : null,
                                  ),
                                  SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      child: Text('${'forgot_password'.tr}?',
                                          style: poppinsRegular.copyWith(
                                              // decoration: TextDecoration.underline,
                                              color: Colors.grey)),
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.getForgotPassRoute());
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  GestureDetector(
                                    onTap: () {
                                      _login(authController);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF2761E7),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Sign in',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text('or',
                                        style: poppinsBold.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            // decoration: TextDecoration.underline,
                                            color:
                                                Colors.black.withOpacity(0.3))),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF4167B2),
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Facebook',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE95B25),
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Google',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        // child: SingleChildScrollView(
        //   physics: BouncingScrollPhysics(),
        //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        //   child: Container(
        //     width: context.width > 700 ? 700 : context.width,
        //     padding: context.width > 700
        //         ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
        //         : null,
        //     decoration: context.width > 700
        //         ? BoxDecoration(
        //             color: Theme.of(context).cardColor,
        //             borderRadius:
        //                 BorderRadius.circular(Dimensions.RADIUS_SMALL),
        //             boxShadow: [
        //               BoxShadow(
        //                   color: Colors.grey[Get.isDarkMode ? 700 : 300],
        //                   blurRadius: 5,
        //                   spreadRadius: 1)
        //             ],
        //           )
        //         : null,
        //     child: GetBuilder<AuthController>(builder: (authController) {
        //       return Column(children: [
        //         SizedBox(height: 40),
        //
        //         Image.asset(
        //             Get.isDarkMode ? Images.logo_dark : Images.logo_light,
        //             height: 70),
        //         SizedBox(height: 40),
        //         Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text('username_email'.tr,
        //                   style: poppinsMedium.copyWith(
        //                       fontSize: Dimensions.fontSizeDefault)),
        //               SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //               SizedBox(
        //                 child: CustomTextField(
        //                   hintText: 'enter_your_username_email'.tr,
        //                   controller: _emailController,
        //                   focusNode: _emailFocus,
        //                   nextFocus: _passwordFocus,
        //                   inputType: TextInputType.emailAddress,
        //                   divider: false,
        //                 ),
        //               ),
        //               Padding(
        //                   padding: EdgeInsets.symmetric(
        //                       horizontal: Dimensions.PADDING_SIZE_LARGE),
        //                   child: Divider(height: 1)),
        //               SizedBox(height: 20),
        //               Text('password'.tr,
        //                   style: poppinsMedium.copyWith(
        //                       fontSize: Dimensions.fontSizeDefault)),
        //               SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //               CustomTextField(
        //                 hintText: 'password'.tr,
        //                 controller: _passwordController,
        //                 focusNode: _passwordFocus,
        //                 inputAction: TextInputAction.done,
        //                 inputType: TextInputType.visiblePassword,
        //                 isPassword: true,
        //                 onSubmit: (text) =>
        //                     (GetPlatform.isWeb && authController.acceptTerms)
        //                         ? _login(authController)
        //                         : null,
        //               ),
        //             ]),
        //         SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
        //         Row(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               InkWell(
        //                 onTap: () {
        //                   authController.toggleRememberMe();
        //                 },
        //                 child: Row(
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     SizedBox(
        //                       width: 20,
        //                       height: 20,
        //                       child: Checkbox(
        //                         shape: RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(5)),
        //                         activeColor: Get.isDarkMode
        //                             ? Theme.of(context)
        //                                 .colorScheme
        //                                 .primaryContainer
        //                             : Theme.of(context).primaryColor,
        //                         value: authController.isActiveRememberMe,
        //                         onChanged: (bool isChecked) =>
        //                             authController.toggleRememberMe(),
        //                       ),
        //                     ),
        //                     SizedBox(
        //                       width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        //                     ),
        //                     Text('remember_me'.tr),
        //                   ],
        //                 ),
        //               ),
        //               InkWell(
        //                 child: Text('${'forgot_password'.tr}?',
        //                     style: poppinsRegular.copyWith(
        //                         decoration: TextDecoration.underline,
        //                         color: Theme.of(context)
        //                             .colorScheme
        //                             .primaryContainer)),
        //                 onTap: () {
        //                   Get.toNamed(RouteHelper.getForgotPassRoute());
        //                 },
        //               ),
        //             ]),
        //         SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
        //         !authController.isLoading
        //             ? Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   CustomButton(
        //                     width: 160,
        //                     radius: 50,
        //                     buttonText: 'login'.tr,
        //                     onPressed: authController.acceptTerms
        //                         ? () => _login(authController)
        //                         : null,
        //                   ),
        //                 ],
        //               )
        //             : Center(child: CircularProgressIndicator()),
        //         SizedBox(height: 30),
        //         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //           Text('don\'t_have_an_account'.tr + ' ',
        //               style: poppinsRegular.copyWith(
        //                   color: Theme.of(context).hintColor)),
        //           InkWell(
        //               child: Text('sign_up'.tr + ' ',
        //                   style: poppinsRegular.copyWith(
        //                       color: Theme.of(context)
        //                           .colorScheme
        //                           .primaryContainer,
        //                       decoration: TextDecoration.underline)),
        //               onTap: () => Get.toNamed(
        //                     RouteHelper.getSignUpRoute(),
        //                   )),
        //         ]),
        //         SizedBox(height: 30),
        //         // InkWell(
        //         //   onTap: () {
        //         //     Get.offAllNamed(RouteHelper.getInitialRoute());
        //         //   },
        //         //   child: Text('skip'.tr + ' ',
        //         //       style: poppinsRegular.copyWith(
        //         //           fontSize: 14,
        //         //           decoration: TextDecoration.underline,
        //         //           color: Theme.of(context)
        //         //               .colorScheme
        //         //               .primaryContainer)),
        //         // ),
        //         SizedBox(height: 30),
        //         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //           InkWell(
        //             onTap: () {
        //               Get.toNamed(
        //                   RouteHelper.getHtmlRoute('terms-and-condition'));
        //             },
        //             child: Padding(
        //               padding:
        //                   EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //               child: Text('terms_conditions'.tr,
        //                   style: poppinsRegular.copyWith(
        //                       color: Theme.of(context)
        //                           .colorScheme
        //                           .primaryContainer,
        //                       decoration: TextDecoration.underline)),
        //             ),
        //           ),
        //         ]),
        //       ]);
        //     }),
        //   ),
        // ),
      ),
    );
  }

  void _login(AuthController authController) async {
    String _email = _emailController.text.trim();
    String _password = _passwordController.text.trim();
    if (_email.isEmpty) {
      showCustomSnackBar('enter_username_or_email'.tr);
    }
    // else if (_email.contains('@') && !GetUtils.isEmail(_email)) {
    //   showCustomSnackBar('invalid_email_address'.tr);
    // }
    else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    } else {
      authController.login(_email, _password, fromLogin: true);
    }
  }

  void _register(AuthController authController) async {
    String _firstName = _firstNameController.text.trim();
    // String _lastName = _lastNameController.text.trim();
    // String _username = _usernameController.text.trim();
    String _email = _emailController.text.trim();
    String _password = _passwordController.text.trim();
    // String _confirmPassword = _confirmPasswordController.text.trim();

    if (authController.acceptTerms == false) {
      showCustomSnackBar('please_agree_with'.tr);
    } else if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    }
    // else if (_lastName.isEmpty) {
    //   showCustomSnackBar('enter_your_last_name'.tr);
    // } else if (_username.isEmpty) {
    //   showCustomSnackBar('enter_your_username'.tr);
    // }
    else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    } else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    } else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    }
    // else if (_password != _confirmPassword) {
    //   showCustomSnackBar('confirm_password_does_not_matched'.tr);
    // }
    else {
      authController.registration(SignUpBody(
        firstName: _firstName,
        //lastName: _lastName,
        email: _email,
        password: _password,
        // username: _username,
      ));
    }
  }
}
