import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/widget/profile_button.dart';
import 'package:flutter_woocommerce/view/screens/root/not_logged_in_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getUserInfo();
    }
    Get.find<ProfileController>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'profile'.tr, isBackButtonExist : true, onBackPressed: () => Get.back()),
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<ProfileController>(builder: (profileController) {
        if(profileController.profileModel != null && _emailController.text.isEmpty) {
          _firstNameController.text = profileController.profileModel.firstName ?? '';
          _lastNameController.text = profileController.profileModel.lastName ?? '';
          _emailController.text = profileController.profileModel.email ?? '';
        }


        return _isLoggedIn ? profileController.profileModel != null ?
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 85,
                        width: Dimensions.WEB_MAX_WIDTH,
                        decoration: BoxDecoration( color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(50)),
                      ),

                      Container(
                        height: 85,
                        width: 300,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_SMALL),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CustomImage(
                                  image: profileController.profileImageUrl ?? ' ',
                                  height: 72,
                                  width: 72,
                                )),
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(profileController.profileModel.firstName+' '+profileController.profileModel.lastName,
                                    style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                Text(profileController.profileModel.username,
                                    style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(color: Theme.of(context).cardColor.withOpacity(.5), borderRadius: BorderRadius.circular(50)),
                      ),

                      Positioned(
                        child: Align(
                          alignment: Get.find<LocalizationController>().isLtr ? Alignment.centerRight: Alignment.centerLeft,
                          child: InkWell(child: Padding(
                            padding: const EdgeInsets.only(top: 30, left: 35, right: 35),
                            child: Image.asset(Images.editAddress, height: 20, width: 20),
                          ),
                            onTap: () {
                              Get.toNamed(RouteHelper.getEditProfileRoute());
                            },
                          )),
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  ProfileButton(
                    title: 'email'.tr,
                    image: Images.email_icon,
                    subTitle: profileController.profileModel.email,
                  ),

                  ProfileButton(
                    title: 'phone_number'.tr,
                    image: Images.phone_icon,
                    subTitle:  profileController.profileModel.billing != null ? profileController.profileModel.billing.phone : '',
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                    child: Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset( Images.profile_address_icon, height: 25, width: 25),
                                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                                Text('my_address'.tr, style: DMSansBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor), textAlign: TextAlign.justify),
                                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                              ],
                            ),

                            Expanded(child: Text(profileController.profileModel.billing != null ? '${profileController.profileModel.billing.address1} ${profileController.profileModel.billing.address2} '
                              '${profileController.profileModel.billing.city} ${profileController.profileModel.billing.state}, ${profileController.profileModel.billing.country}' : '',
                              style: DMSansMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                              maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end,)),
                          ],
                        )),
                  ),

                  // InkWell(
                  //   onTap: () {
                  //     if(Get.find<AuthController>().isLoggedIn()) {
                  //       Get.dialog(ConfirmationDialog(icon: Images.delete_account_dialog, description: 'are_you_sure_to_delete_account'.tr, isLogOut: true, onYesPressed: () {
                  //         Get.find<ProfileController>().removeUser();
                  //         Get.find<AuthController>().clearSharedData();
                  //         Get.find<CartController>().clearCartList();
                  //       }), useSafeArea: false);
                  //     }else {
                  //       Get.toNamed(RouteHelper.getSignInRoute());
                  //     }
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_SMALL),
                  //     child: Container(
                  //         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Image.asset(Images.wish_list_delete, color: Theme.of(context).primaryColorLight, height: 25, width: 25),
                  //             SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  //             Text( 'delete_account'.tr, style: DMSansMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)),
                  //             SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  //           ],
                  //         )),
                  //   ),
                  // ),
                ]
              ),
            ) : Center(child: CircularProgressIndicator()) : NotLoggedInScreen();

      }),
    );
  }

}

