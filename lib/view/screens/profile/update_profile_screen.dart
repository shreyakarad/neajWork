import 'dart:io';
import 'package:flutter_woocommerce/data/model/response_model.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/base/my_text_field.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/checkout/widget/address_input_field.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/profile_model.dart';
import 'package:flutter_woocommerce/view/screens/profile/widget/profile_address_card.dart';
import 'package:flutter_woocommerce/view/screens/root/not_logged_in_screen.dart';
import 'package:get/get.dart';
import '../../base/custom_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn && Get.find<ProfileController>().profileModel != null) {
      Get.find<ProfileController>().getUserInfo();
    }
    Get.find<ProfileController>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Get.find<ProfileController>().getUserInfo();
      },
      child: Scaffold(
        appBar: CustomAppBar(title: 'update_profile'.tr, isBackButtonExist : true, onBackPressed: () => Get.back()),
        backgroundColor: Theme.of(context).cardColor,
        body: GetBuilder<ProfileController>(builder: (profileController) {
          if(profileController.profileModel != null && _emailController.text.isEmpty) {
            _firstNameController.text = profileController.profileModel.firstName ?? '';
            _lastNameController.text = profileController.profileModel.lastName ?? '';
            _emailController.text = profileController.profileModel.email ?? '';
          }

          return _isLoggedIn ? profileController.profileModel != null ? Column(children: [
            Expanded(child: Scrollbar(child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height : 100,
                      width: 100,
                      child: Stack(children: [
                        ClipOval(child: profileController.pickedFile != null ? Image.file(
                          File(profileController.pickedFile.path), width: 100, height: 100, fit: BoxFit.cover,
                        ) : CustomImage(
                          image: profileController.profileImageUrl ?? '',
                          height: 100, width: 100, fit: BoxFit.cover,
                        )),
                        Positioned(
                          bottom: 0, right: 0, top: 0, left: 0,
                          child: InkWell(
                            onTap: () => profileController.pickImage(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3), shape: BoxShape.circle,
                                border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2, color: Colors.white),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.camera_alt, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                   SizedBox(width: Dimensions.PADDING_SIZE_LARGE),

                   // profileController.isAvatarLoading ?
                   //   InkWell(
                   //     child: Container(
                   //       //height: 30,
                   //       padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                   //       child: !profileController.isAvatarLoading ? Text('update_avatarr'.tr, style: poppinsRegular.copyWith(color: Theme.of(context).cardColor)) :
                   //       CircularProgressIndicator(color: Theme.of(context).cardColor),
                   //       decoration: BoxDecoration(
                   //         color: Theme.of(context).primaryColorLight,
                   //         borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)
                   //       ),
                   //     ),
                   //     onTap: () => profileController.updateProfileAvatar(),
                   //   ),
                  ],
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                AddressInputField(
                    title: 'first_name'.tr,
                    controller: _firstNameController,
                    focusNode: _firstNameFocus,
                    nextNode: _lastNameFocus,
                    require: true,
                    inputType: TextInputType.name,
                    validator: (value) {
                      if(value == '') {
                        return 'please_enter_first_name'.tr;
                      }
                      return null;
                    }
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                AddressInputField(
                    title: 'last_name'.tr,
                    controller: _lastNameController,
                    focusNode: _lastNameFocus,
                    nextNode: _emailFocus,
                    require: true,
                    inputType: TextInputType.name,
                    validator: (value) {
                      if(value == '') {
                        return 'please_enter_last_name'.tr;
                      }
                      return null;
                    }
                ),

                Row(children: [
                  Text('email'.tr,
                    style: DMSansBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Text('(${'non_changeable'.tr})', style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).colorScheme.error,
                  )),
                ]),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                MyTextField(
                  fillColor: Get.isDarkMode ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.30) : Theme.of(context).primaryColorLight.withOpacity(0.15),
                  hintText: 'email'.tr,
                  controller: _emailController,
                  isEnabled: false,
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                ProfileAddressCard (
                  title: 'select_shipping_address'.tr,
                  address: profileController.profileShippingAddress,
                  billingAddress: false,
                  fromProfile: true,
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                ProfileAddressCard (
                  title: 'select_billing_address'.tr,
                  address: profileController.profileBillingAddress,
                  billingAddress: true,
                  fromProfile: true,
                ),

              ]))),
            ))),

            !profileController.isLoading ? Padding(
              padding: EdgeInsets.symmetric( horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_SMALL),
              child: CustomButton(
                radius: Dimensions.RADIUS_EXTRA_LARGE,
                height: 40,
                onPressed: () => _updateProfile(profileController),
                buttonText: 'update'.tr,
              ),
            ) : Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Center(child: CircularProgressIndicator()),
            ),
          ])
          : Center(child: CircularProgressIndicator()) : NotLoggedInScreen();



        }),
      ),
    );
  }

  void _updateProfile(ProfileController profileController) async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _lastNameController.text.trim();
    String _email = _emailController.text.trim();
    if (profileController.profileModel.firstName == _firstName &&
        profileController.profileModel.email == _emailController.text && profileController.pickedFile == null &&
        profileController.profileBillingAddress == profileController.profileBillingAddress1 &&
        profileController.profileShippingAddress == profileController.profileShippingAddress1
    ) {
      showCustomSnackBar('change_something_to_update'.tr);
    }else if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    }else if (_lastName.isEmpty) {
      showCustomSnackBar('enter_your_last_name'.tr);
    }else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    }else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    }else {
      ProfileModel _updatedUser = ProfileModel( firstName: _firstName, lastName: _lastName, email: _email);
      if (profileController.profileShippingAddress.firstName != '') {
        _updatedUser.shipping = profileController.profileShippingAddress;
      }
      if (profileController.profileBillingAddress.firstName != '' ) {
        _updatedUser.billing = profileController.profileBillingAddress;
      }
      ResponseModel _responseModel = await profileController.updateUserInfo(_updatedUser);
      if(_responseModel.isSuccess) {
        showCustomSnackBar('profile_updated_successfully'.tr, isError: false);
      }else {
        showCustomSnackBar(_responseModel.message);
      }
    }
  }
}




// return _isLoggedIn ? profileController.profileModel != null ? ProfileBgWidget(
//   backButton: true,
//   circularImage: Center(child: Stack(children: [
//     ClipOval(child: profileController.pickedFile != null ? GetPlatform.isWeb ? Image.network(
//       profileController.pickedFile.path, width: 100, height: 100, fit: BoxFit.cover,
//     ) : Image.file(
//       File(profileController.pickedFile.path), width: 100, height: 100, fit: BoxFit.cover,
//     ) : CustomImage(
//       image: profileController.profileModel.avatarUrl ?? '',
//       height: 100, width: 100, fit: BoxFit.cover,
//     )),
//     Positioned(
//       bottom: 0, right: 0, top: 0, left: 0,
//       child: InkWell(
//         onTap: () => profileController.pickImage(),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.3), shape: BoxShape.circle,
//             border: Border.all(width: 1, color: Theme.of(context).primaryColor),
//           ),
//           child: Container(
//             margin: EdgeInsets.all(25),
//             decoration: BoxDecoration(
//               border: Border.all(width: 2, color: Colors.white),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(Icons.camera_alt, color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//   ])


//),
//   mainWidget: Column(children: [
//
//     Expanded(child: Scrollbar(child: SingleChildScrollView(
//       physics: BouncingScrollPhysics(),
//       padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//       child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//
//         Text(
//           'first_name'.tr,
//           style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//         ),
//         SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//         MyTextField(
//           hintText: 'first_name'.tr,
//           controller: _firstNameController,
//           focusNode: _firstNameFocus,
//           nextFocus: _lastNameFocus,
//           inputType: TextInputType.name,
//           capitalization: TextCapitalization.words,
//         ),
//         SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//
//         Text(
//           'last_name'.tr,
//           style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//         ),
//         SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//         MyTextField(
//           hintText: 'last_name'.tr,
//           controller: _lastNameController,
//           focusNode: _lastNameFocus,
//           nextFocus: _emailFocus,
//           inputType: TextInputType.name,
//           capitalization: TextCapitalization.words,
//         ),
//         SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//
//         Row(children: [
//           Text(
//             'email'.tr,
//             style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//           ),
//           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//           Text('(${'non_changeable'.tr})', style: robotoRegular.copyWith(
//             fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).errorColor,
//           )),
//         ]),
//         SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//         MyTextField(
//           hintText: 'email'.tr,
//           controller: _emailController,
//           focusNode: _emailFocus,
//           isEnabled: false,
//           inputAction: TextInputAction.done,
//           inputType: TextInputType.emailAddress,
//         ),
//         SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//
//         AddressCard(
//           title: 'shipping_address'.tr,
//           address: profileController.shippingAddress,
//           billingAddress: false,
//           fromProfile: true,
//         ),
//         SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//
//         AddressCard(
//           title: 'billing_address'.tr,
//           address: profileController.billingAddress,
//           billingAddress: true,
//           fromProfile: true,
//         ),
//
//       ]))),
//     ))),
//
//     !profileController.isLoading ? CustomButton(
//       onPressed: () => _updateProfile(profileController),
//       margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//       buttonText: 'update'.tr,
//     ) : Padding(
//       padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//       child: Center(child: CircularProgressIndicator()),
//     ),
//
//   ]),
// ) : Center(child: CircularProgressIndicator()) : NotLoggedInScreen();
