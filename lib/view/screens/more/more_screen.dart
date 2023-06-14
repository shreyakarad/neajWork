import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/shared_pref.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/confirmation_dialog.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/widget/menu_item.dart';
import 'package:flutter_woocommerce/view/screens/search/controller/search_controller.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rate_my_app/rate_my_app.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
  WidgetBuilder builder = buildProgressIndicator;

  @override
  void initState() {
    super.initState();
    if (_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'more'.tr, isBackButtonExist: false),
      body: RateMyAppBuilder(
          builder: builder,
          onInitialized: (context, rateMyApp) {
            setState(() => builder = (context) => SingleChildScrollView(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  physics: BouncingScrollPhysics(),
                  child: GetBuilder<ProfileController>(
                      builder: (profileController) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                              MenuItem(
                                  image: Images.user_icon,
                                  title:
                                      _isLoggedIn ? 'profile'.tr : 'guest'.tr,
                                  tagText: _isLoggedIn
                                      ? (profileController.profileImageUrl ==
                                                  '' ||
                                              profileController
                                                      .profileImageUrl ==
                                                  null)
                                          ? '50 %'
                                          : '100 %'
                                      : '',
                                  isTagActive: _isLoggedIn ? true : false,
                                  onTap: () {
                                    // Get.toNamed(RouteHelper.getProfileRoute());
                                    Get.toNamed(
                                        RouteHelper.getEditProfileRoute());
                                  }),

                              // MenuItem(image: Images.orders_icon, title: 'order'.tr, tagText: '5', isTagActive: false, onTap: () {
                              //   Get.to(OrderScreen(formMenu: true));
                              // }),

                              MenuItem(
                                  image: Images.saved_address_icon,
                                  title: 'saved_address'.tr,
                                  tagText: "0",
                                  isTagActive: false,
                                  onTap: () {
                                    Get.toNamed(
                                        RouteHelper.getSavedAddressRoute());
                                  }),

                              MenuItem(
                                  image: Images.my_offer_icon,
                                  title: 'coupons'.tr,
                                  onTap: () {
                                    Get.toNamed(
                                        RouteHelper.getCouponRoute(false));
                                  }),

                              // MenuItem(image: Images.payment, title: 'payment'.tr, onTap: () {}),

                              MenuItem(
                                  image: Images.settings,
                                  title: 'settings'.tr,
                                  onTap: () => Get.toNamed(
                                      RouteHelper.getSettingsRoute())),

                              MenuItem(
                                  image: Images.terms_and_condition,
                                  title: 'terms_conditions'.tr,
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getHtmlRoute(
                                        'terms-and-condition'));
                                  }),

                              MenuItem(
                                  image: Images.privacy_policy,
                                  title: 'privacy_policy'.tr,
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getHtmlRoute(
                                        'privacy-policy'));
                                  }),

                              MenuItem(
                                  image: Images.about_us,
                                  title: 'about_us'.tr,
                                  onTap: () {
                                    Get.toNamed(
                                        RouteHelper.getHtmlRoute('about_us'));
                                  }),
                            ],
                          ),

                          //SizedBox(height: 30),

                          _isLoggedIn
                              ? InkWell(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .isLoggedIn()) {
                                      Get.dialog(
                                          ConfirmationDialog(
                                              icon:
                                                  Images.delete_account_dialog,
                                              description:
                                                  'are_you_sure_to_delete_account'
                                                      .tr,
                                              isLogOut: true,
                                              onYesPressed: () async {
                                                await Get.find<AuthController>()
                                                    .deleteToken();
                                                await Get.find<
                                                        ProfileController>()
                                                    .removeUser();
                                                Get.find<ProfileController>()
                                                    .clearProfileData();
                                                Get.find<AuthController>()
                                                    .clearSharedData();
                                                Get.find<AuthController>()
                                                    .isLoggedIn();
                                                Get.find<SearchController>()
                                                    .clearSearchAddress();
                                                Get.find<WishListController>()
                                                    .getWishList();
                                                _isLoggedIn = false;
                                                Get.back();
                                                Get.toNamed(RouteHelper
                                                    .getSignInRoute());
                                              }),
                                          useSafeArea: false);
                                    } else {
                                      Get.toNamed(RouteHelper.getSignInRoute());
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_SMALL,
                                        vertical:
                                            Dimensions.PADDING_SIZE_SMALL),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            child: Image.asset(
                                                Images.wish_list_delete,
                                                height: 25,
                                                width: 25)),
                                        // SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                                        Text('delete_account'.tr,
                                            style: DMSansMedium.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeDefault,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        SizedBox(
                                            width: Dimensions
                                                .PADDING_SIZE_DEFAULT),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(),

                          InkWell(
                            onTap: () {
                              if (Get.find<AuthController>().isLoggedIn()) {
                                Get.dialog(
                                    ConfirmationDialog(
                                        icon: Images.logout_dialog,
                                        description:
                                            'are_you_sure_to_logout'.tr,
                                        isLogOut: true,
                                        onYesPressed: () async {
                                          await Get.find<AuthController>()
                                              .deleteToken();
                                          Get.find<ProfileController>()
                                              .clearProfileData();
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<AuthController>()
                                              .isLoggedIn();
                                          Get.find<SearchController>()
                                              .clearSearchAddress();
                                          Get.find<WishListController>()
                                              .getWishList();
                                          _isLoggedIn = false;
                                          Get.find<CartController>()
                                              .getCartList(notify: true);

                                          Get.back();
                                          Get.toNamed(
                                              RouteHelper.getSignInRoute());
                                          PrefManagerUtils.clearPreference();
                                        }),
                                    useSafeArea: false);
                              } else {
                                Get.toNamed(RouteHelper.getSignInRoute());
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                                  vertical: Dimensions.PADDING_SIZE_SMALL),
                              child: Container(
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  child: Row(
                                    children: [
                                      Image.asset(Images.logout,
                                          height: 25, width: 25),
                                      SizedBox(
                                          width:
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                      Text(
                                          _isLoggedIn
                                              ? 'logout'.tr
                                              : 'sign_in'.tr,
                                          style: DMSansMedium.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeDefault,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ],
                                  )),
                            ),
                          ),
                        ]);
                  }),
                ));
          }),
    );
  }
}

Widget buildProgressIndicator(BuildContext context) =>
    const Center(child: CircularProgressIndicator());

// ProfileButton(icon: Icons.dark_mode, title: 'dark_mode'.tr, isButtonActive: Get.isDarkMode, onTap: () {
// Get.find<ThemeController>().toggleTheme();
// }),
// SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//
// GetBuilder<AuthController>(builder: (authController) {
// return authController.isBiometricSupported ? Column(children: [
// ProfileButton(
// icon: Icons.fingerprint, title: 'biometric_login'.tr,
// isButtonActive: authController.biometric, onTap: () {
// authController.setBiometric(!authController.biometric);
// },
// ),
// SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
// ]) : SizedBox();
// }),
//
// _isLoggedIn ? GetBuilder<AuthController>(builder: (authController) {
// return ProfileButton(
// icon: Icons.notifications, title: 'notification'.tr,
// isButtonActive: authController.notification, onTap: () {
// authController.setNotificationActive(!authController.notification);
// },
// );
// }) : SizedBox(),
// SizedBox(height: _isLoggedIn ? Dimensions.PADDING_SIZE_SMALL : 0),
//
// ProfileButton(icon: Icons.language, title: 'language'.tr, onTap: () {
// Get.toNamed(RouteHelper.getLanguageRoute('menu'));
// }),
// SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//
//
// ProfileButton(icon: Icons.local_offer, title: 'coupon'.tr, onTap: () {
// Get.toNamed(RouteHelper.getCouponRoute(false));
// }),
// SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//
// ProfileButton(icon: Icons.list_alt, title: 'terms_conditions'.tr, onTap: () {
// Get.toNamed(RouteHelper.getHtmlRoute(HtmlType.TERMS_AND_CONDITION));
// }),
// SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//
// ProfileButton(icon: Icons.privacy_tip, title: 'privacy_policy'.tr, onTap: () {
// Get.toNamed(RouteHelper.getHtmlRoute(HtmlType.PRIVACY_POLICY));
// }),
// SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//
// ProfileButton(icon: Icons.info, title: 'about_us'.tr, onTap: () {
// Get.toNamed(RouteHelper.getHtmlRoute(HtmlType.ABOUT_US));
// }),
// SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//
// _isLoggedIn ? ProfileButton(
// icon: Icons.delete, title: 'delete_account'.tr,
// onTap: () {
// Get.dialog(ConfirmationDialog(icon: Images.support,
// title: 'are_you_sure_to_delete_account'.tr,
// description: 'it_will_remove_your_all_information'.tr, isLogOut: true,
// onYesPressed: () => profileController.removeUser(),
// ), useSafeArea: false);
// },
// ) : SizedBox(),
// SizedBox(height: _isLoggedIn ? Dimensions.PADDING_SIZE_SMALL : 0),
//
// ProfileButton(icon: _isLoggedIn ? Icons.logout : Icons.login, title: _isLoggedIn ? 'logout'.tr : 'sign_in'.tr, onTap: () {
// if(Get.find<AuthController>().isLoggedIn()) {
// Get.dialog(ConfirmationDialog(icon: Images.support, description: 'are_you_sure_to_logout'.tr, isLogOut: true, onYesPressed: () {
// Get.find<AuthController>().clearSharedData();
// Get.find<CartController>().clearCartList();
// // Get.find<WishListController>().removeWishes();
// Get.offAllNamed(RouteHelper.getSignInRoute());
// }), useSafeArea: false);
// }else {
// // Get.find<WishListController>().removeWishes();
// Get.toNamed(RouteHelper.getSignInRoute());
// }
// }),
// SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//
//
// ProfileButton(icon: Icons.star_rate_outlined, title: 'rate_my_app'.tr, onTap: () {
// rateMyApp.showRateDialog(context);
// //Get.to(() =>RateMyAppTestApp()) ;
// //Get.toNamed(RouteHelper.getHtmlRoute(HtmlType.ABOUT_US));
// }),
// SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//
// ProfileButton(icon: Icons.location_on_outlined, title: 'address'.tr, onTap: () {
// Get.toNamed(RouteHelper.getSavedAddressRoute());
// }),
// SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//
//
// Row(mainAxisAlignment: MainAxisAlignment.center, children: [
// Text('${'version'.tr}:', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
// SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
// Text(AppConstants.APP_VERSION.toString(), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
// ]),

// InkWell(
// onTap: () {
// if(profileController.profileModel != null) {
// Get.toNamed(RouteHelper.getProfileRoute());
// }
// },
// child: Row(children: [
// ClipOval(child: CustomImage(
// image: profileController.profileModel != null ? profileController.profileModel.avatarUrl : '',
// height: 50, width: 50,
// )),
// SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
// Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// Text(
// (_isLoggedIn && profileController.profileModel != null) ? ('${profileController.profileModel.firstName}'
// ' ${profileController.profileModel.lastName}') : 'guest_user'.tr,
// maxLines: 1, overflow: TextOverflow.ellipsis,
// style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
// ),
// SizedBox(height: _isLoggedIn ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),
// _isLoggedIn ? Text(
// (_isLoggedIn && profileController.profileModel != null) ? profileController.profileModel.email
//     : 'guest_user'.tr,
// maxLines: 1, overflow: TextOverflow.ellipsis,
// style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
// ) : SizedBox(),
// ])),
// Icon(Icons.arrow_forward_ios),
// ]),
// ),
