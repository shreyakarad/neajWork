import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/color_utils.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/discount_tag.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter_woocommerce/view/base/product_shimmer.dart';
import 'package:flutter_woocommerce/view/screens/Shop/model/shop_model.dart';
import 'package:flutter_woocommerce/view/screens/category/controller/category_controller.dart';
import 'package:flutter_woocommerce/view/screens/category/model/category_model.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/poroduct_category_view.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:get/get.dart';

class HomeCategoryScreen extends StatefulWidget {
  final List<CategoryModel> categoryList;
  HomeCategoryScreen({this.categoryList});
  @override
  _HomeCategoryScreenState createState() => _HomeCategoryScreenState();
}

class _HomeCategoryScreenState extends State<HomeCategoryScreen> {
  final ScrollController scrollController = ScrollController();
  final ScrollController restaurantScrollController = ScrollController();
  List<Map<String, dynamic>> tempMap = [];
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    tempMap.clear();
    for (int i = 0; i < widget.categoryList.length; i++) {
      await Get.find<CategoryController>().getCategoryProductList(
          widget.categoryList[i].id.toString(), 1, false);
      tempMap.add({
        "category_name": "${widget.categoryList[i].name}",
        "category": Get.find<CategoryController>().categoryProductList.length >
                6
            ? Get.find<CategoryController>().categoryProductList.sublist(0, 6)
            : Get.find<CategoryController>().categoryProductList
      });
    }
    print("tempMap===$tempMap");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (catController) {
      List<ProductModel> _products;
      // if (tempMap != null && catController.searchProductList != null) {
      //   _products = [];
      //   if (catController.isSearching) {
      //     _products.addAll(catController.searchProductList);
      //   } else {
      //     _products.addAll(tempList);
      //   }
      // }
      return WillPopScope(
          onWillPop: () async {
            if (catController.isSearching) {
              catController.toggleSearch();
              return false;
            } else {
              return true;
            }
          },
          child: tempMap.length == 0 || tempMap.isEmpty
              ? SizedBox()
              : Column(
                  children: List.generate(tempMap.length, (index) {
                  return tempMap[index]['category'].isEmpty
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${tempMap[index]['category_name'] == "Electronics" ? "Electronic Wonders" : tempMap[index]['category_name'] == "Kids" ? "Kids Corner" : tempMap[index]['category_name'] == "Women" ? "Trending for Her" : tempMap[index]['category_name'] == "Men" ? "Fresh Finds for Him" : ""} ',
                                  style: poppinsMedium.copyWith(
                                      fontSize: 20, color: Colors.black)),
                              SizedBox(height: 10),
                              ProductCatView(
                                  //products: _products,
                                  products: tempMap[index]['category']
                                      as List<ProductModel>,
                                  isShop: false,
                                  noDataText: 'no_category_food_found'.tr),
                            ],
                          ),
                        );
                })));
    });
  }
}
