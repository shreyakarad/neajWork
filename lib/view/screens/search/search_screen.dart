import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter_woocommerce/view/screens/search/widgets/item_view.dart';
import 'package:flutter_woocommerce/view/screens/search/widgets/search_field.dart';
import 'package:get/get.dart';
import 'controller/search_controller.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        child: GetBuilder<SearchController>(builder: (searchController) {
          _searchController.text = searchController.searchText;
          return Column(children: [
            Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: Row(children: [
                  InkWell(
                    onTap: ()=> Get.back(),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB( Get.find<LocalizationController>().isLtr ? 0 : Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL,
                      Get.find<LocalizationController>().isLtr ? Dimensions.PADDING_SIZE_SMALL : 0, Dimensions.PADDING_SIZE_DEFAULT),
                      child: SizedBox(width: Dimensions.ICON_SIZE_LARGE,
                      child: Icon( Icons.arrow_back_ios)),
                      // Get.find<LocalizationController>().isLtr ? Icons.arrow_back_ios_new_rounded :
                    ),
                  ),

                  Expanded(child: SearchField(
                    controller: _searchController,
                    hint: 'search_product'.tr,
                    suffixIcon: !searchController.isSearchMode ? Images.clear_icon : Images.search_icon,
                    iconPressed: () => !searchController.isSearchMode ? searchController.setSearchMode(true) : _actionSearch(searchController, false),
                    onSubmit: (text) => _actionSearch(searchController, true),
                  )),
                ]),
            ))),

            Expanded(child: searchController.isSearchMode ? SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
              child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                searchController.historyList.length > 0 ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('history'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                  InkWell(
                    onTap: () => searchController.clearSearchAddress(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: 4),
                      child: Text('clear_all'.tr, style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor,
                      )),
                    ),
                  ),
                ]) :
                SizedBox(
                  height: Get.context.height-150,
                  width: Get.context.width,
                  child: Center(child: NoDataScreen(text: 'no_search_history_found'.tr, type: NoDataType.SEARCH))),

                searchController.historyList.isNotEmpty?
                Wrap(
                  direction: Axis.horizontal,
                  alignment:WrapAlignment.start,
                  children: [
                  for (int index = 0; index<searchController.historyList.length; index++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Get.isDarkMode ? Colors.grey.withOpacity(0.2): Theme.of(context).primaryColorLight.withOpacity(0.3)
                        ),
                        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL-3, horizontal: Dimensions.PADDING_SIZE_SMALL,),
                        margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () => searchController.searchData(searchController.historyList[index], 1),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: Text(searchController.historyList[index],
                                    style: robotoRegular.copyWith(color: Theme.of(context).primaryColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                            InkWell(
                              onTap: () => searchController.removeHistory(index),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Icon(Icons.close, color: Theme.of(context).primaryColor.withOpacity(.75), size: 10),
                              ),
                            )
                          ],
                        )),
                    )
                  ],
                ):SizedBox(),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              ]))),
            ) : ItemView()),
          ]);
        }),
      )),
    );
  }

  void _actionSearch(SearchController searchController, bool isSubmit) {
    if(searchController.isSearchMode || isSubmit) {
      if(_searchController.text.trim().isNotEmpty) {
        searchController.searchData(_searchController.text.trim(), 1);
      }else {
        showCustomSnackBar('please_write_something'.tr);
      }
    }else {
    }
  }
}
