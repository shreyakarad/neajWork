import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/view/screens/address/controller/location_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:get/get.dart';

import '../../../util/dimensions.dart';
import '../../base/custom_button.dart';
import '../auth/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  final String pendingDynamicLink;
  final String notyType;
  const SplashScreen({Key key, this.pendingDynamicLink, this.notyType})
      : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  bool _navigate = true;
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  List language = [
    "Bahrain",
    "Bangladesh",
    "Saudi Arabia",
    "United Arab Emirates",
  ];
  int langSelect;
  bool isOpenBottomSheet = false;
  @override
  void initState() {
    super.initState();
    int _count = 0;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _count += 1;
      if (_count > 2) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          Get.find<ConfigController>().getGeneralSettings();
          //Get.find<ConfigController>().getTaxSettings();
          Get.find<ConfigController>().getTaxClasses();
        }
      }
    });

    Get.find<ConfigController>().initSharedData();
    Get.find<CartController>().getCartList();
    //Get.find<ConfigController>().getTaxSettings();
    Get.find<ConfigController>().getTaxClasses();
    Get.find<CartController>().initList();
    Get.find<LocationController>().initList();
    Get.find<ProductController>().initDynamicLinks();
    print('NotificationType: ${widget.notyType}');
    Future.delayed(
      Duration(seconds: 2),
      () {
        setState(() {
          isOpenBottomSheet = true;
        });
        //selectLangBottomSheet();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<ConfigController>().getGeneralSettings().then((isSuccess) {
      if (isSuccess) {
        double _minimumVersion = 0;
        if (GetPlatform.isAndroid) {
          _minimumVersion = double.parse(Get.find<ConfigController>()
              .settings
              .appSettings
              .googleStore
              .minimumVersion
              .toString());

          print(
              '----------my version=====${_minimumVersion}---backned version---${AppConstants.APP_VERSION}');
        } else if (GetPlatform.isIOS) {
          _minimumVersion = double.parse(Get.find<ConfigController>()
              .settings
              .appSettings
              .appleStore
              .minimumVersion
              .toString());
        }
        if (AppConstants.APP_VERSION < _minimumVersion ||
            Get.find<ConfigController>()
                    .settings
                    .businessSettings
                    .maintenanceMode ==
                1) {
          Get.offNamed(RouteHelper.getUpdateRoute(
              AppConstants.APP_VERSION < _minimumVersion));
        } else {
          // Get.offNamed(RouteHelper.getInitialRoute());
          Get.offNamed(RouteHelper.getSignInRoute());
        }

        // if(widget.pendingDynamicLink != null) {
        //   Get.offNamed(RouteHelper.getProductDetailsRoute(-1, widget.pendingDynamicLink, true));
        // }
        // else if (widget.notyType != '' && widget.notyType != null) {
        //   Get.offNamed(RouteHelper.notificationViewRoute(widget.notyType));
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfigController>(builder: (configController) {
      // if(configController.settings != null && configController.taxClassList != null && _navigate) {
      //   _navigate = false;
      //   _route();
      // }
      ///changes
      // _route();

      return Scaffold(
        key: _globalKey,
        backgroundColor:
            Get.isDarkMode ? Theme.of(context).primaryColorLight : Colors.white,
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.color),
                  fit: BoxFit.cover,
                  image: AssetImage(
                      Get.isDarkMode ? Images.new_splash : Images.new_splash))),
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xff20273C).withOpacity(0.8),
                ),
                child: Image.asset(Images.new_logo, color: Colors.white),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isOpenBottomSheet == true)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.2),
                        child:
                            Image.asset(Images.new_logo, color: Colors.white),
                      ),
                    ),
                  if (isOpenBottomSheet == true)
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                            vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Country',
                              style: TextStyle(
                                  color: Color(0xFF322F27),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: language.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      langSelect = index;
                                    });

                                    // #212E4F
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                        color: langSelect == index
                                            ? Color(0xFF212E4F)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: Color(0xFFE4E4E4))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 22),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            language[index],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: langSelect == index
                                                    ? Colors.white
                                                    : Color(0xFF322F27)),
                                          ),
                                          langSelect == index
                                              ? CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: Colors.green
                                                      .withOpacity(0.8),
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 25),
                            GestureDetector(
                              onTap: () {
                                if (langSelect == null) {
                                  Get.snackbar(
                                      'error', 'Please select language');
                                } else {
                                  LocalizationController
                                      localizationController = Get.find();
                                  // localizationController.setSelectIndex(langSelect + 1);

                                  // localizationController.setLanguage(Locale(
                                  //   AppConstants
                                  //       .languages[localizationController.selectedIndex]
                                  //       .languageCode,
                                  //   AppConstants
                                  //       .languages[localizationController.selectedIndex]
                                  //       .countryCode,
                                  // ));
                                  _route();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                width: Get.width,
                                decoration: BoxDecoration(
                                  // color: Color(0xFF3B62FF),
                                  color: Color(0xFF1C61E7),
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Center(
                                  child: Text(
                                    'Start',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
          // child: Image.asset(
          //   Get.isDarkMode ? Images.new_splash : Images.new_splash,
          //   fit: BoxFit.cover,
          //   width: Get.width,
          //   height: Get.height,
          // ),
        ),
        // Stack(
        //   children: [
        //     Image.asset(
        //       Get.isDarkMode ? Images.new_splash : Images.new_splash,
        //       fit: BoxFit.cover,
        //       width: Get.width,
        //       height: Get.height,
        //     ),
        //     Container(
        //       height: Get.height,
        //       width: Get.width,
        //       decoration: BoxDecoration(
        //         color: Color(0xff20273C).withOpacity(0.8),
        //       ),
        //       child: Image.asset(Images.new_logo, color: Colors.white),
        //     ),
        //   ],
        // ),
      );
    });
  }

  selectLangBottomSheet() {
    int langSelect;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Country',
                    style: TextStyle(
                        color: Color(0xFF322F27),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: language.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            langSelect = index;
                          });

                          // #212E4F
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                              color: langSelect == index
                                  ? Color(0xFF212E4F)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Color(0xFFE4E4E4))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  language[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: langSelect == index
                                          ? Colors.white
                                          : Color(0xFF322F27)),
                                ),
                                langSelect == index
                                    ? CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            Colors.green.withOpacity(0.8),
                                        child: Icon(
                                          Icons.check,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      if (langSelect == null) {
                        Get.snackbar('error', 'Please select language');
                      } else {
                        LocalizationController localizationController =
                            Get.find();
                        // localizationController.setSelectIndex(langSelect + 1);

                        // localizationController.setLanguage(Locale(
                        //   AppConstants
                        //       .languages[localizationController.selectedIndex]
                        //       .languageCode,
                        //   AppConstants
                        //       .languages[localizationController.selectedIndex]
                        //       .countryCode,
                        // ));
                        _route();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Color(0xFF3B62FF),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Center(
                        child: Text(
                          'Start',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
