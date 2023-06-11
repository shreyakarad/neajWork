import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/data/model/language_model.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
  WidgetBuilder builder = buildProgressIndicator;

  @override
  void initState() {
    super.initState();
    if(_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( title: 'settings'.tr, isBackButtonExist: true),
      body: RateMyAppBuilder(
          builder: builder,
          onInitialized: (context, rateMyApp) {
            setState(() => builder = (context) => SingleChildScrollView(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              physics: BouncingScrollPhysics(),
              child: GetBuilder<ProfileController>(builder: (profileController) {


                return Column( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  InkWell(
                    onTap: (){
                      Get.find<ThemeController>().toggleTheme();
                    },
                    child: Padding (
                      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(Images.theme, height: 25, width: 25),
                              SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                              Text("theme".tr ,style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                            ],
                          ),

                          GetBuilder<ThemeController>(builder: (themeController) {
                            return SizedBox(
                              height: 20,
                              child: CupertinoSwitch(
                                //trackColor: Colors.red,
                                //thumbColor: Colors.red,
                                activeColor: Theme.of(context).primaryColorDark,
                                value: themeController.darkTheme,
                                onChanged: (value){
                                  themeController.toggleTheme();
                              }),
                            );
                          }),
                      ]),
                    ),
                  ),
                  
                  
                  SizedBox(height: 5),


                  GetBuilder<LocalizationController>(
                    builder: (localizationController) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(Images.language_settings, height: 25, width: 25),
                                SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                                Text("language".tr ,style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                              ],
                            ),

                            SizedBox(
                              height: 50,
                              width : 120,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: AppConstants.languages[localizationController.selectedIndex],
                                  icon: const Icon(Icons.arrow_drop_down),
                                  items: AppConstants.languages.map<DropdownMenuItem<LanguageModel>>((LanguageModel value) {
                                    return DropdownMenuItem<LanguageModel>(
                                      value: value,
                                      child: Text(
                                        value.languageName,
                                        style: TextStyle(
                                          color: AppConstants.languages[localizationController.selectedIndex].languageName == value.languageName ? Theme.of(context).primaryColor :
                                          Theme.of(context).textTheme.headlineMedium.color,
                                        ),
                                      ),
                                    );
                                  }).toList(),

                                  onChanged: (newValue) {
                                    localizationController.setSelectIndex(AppConstants.languages.indexOf(newValue));
                                    localizationController.setLanguage(Locale(
                                      AppConstants.languages[localizationController.selectedIndex].languageCode,
                                      AppConstants.languages[localizationController.selectedIndex].countryCode,
                                    ));
                                  })),
                            )

                          ]);
                    }
                  ),
                ]);
              }),
            ));
          }
      ),
    );
  }
}


Widget buildProgressIndicator(BuildContext context) =>const Center(child: CircularProgressIndicator());



