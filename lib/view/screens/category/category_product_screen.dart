import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/view/screens/category/controller/category_controller.dart';
import 'package:flutter_woocommerce/view/screens/category/model/category_model.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryProductScreen extends StatefulWidget {
  final CategoryModel category;
  CategoryProductScreen({@required this.category});

  @override
  _CategoryProductScreenState createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  final ScrollController scrollController = ScrollController();
  final ScrollController restaurantScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print("Category_product_screen");
    print(widget.category.id.toString());

    //Get.find<CategoryController>().getSubCategoryList(widget.category.id.toString());
    Get.find<CategoryController>().getCategoryProductList(widget.category.id.toString(), 1, false);

    // scrollController?.addListener(() {
    //   if (scrollController.position.pixels == scrollController.position.maxScrollExtent
    //       && Get.find<CategoryController>().categoryProductList != null
    //       && !Get.find<CategoryController>().isLoading) {
    //     // int pageSize = (Get.find<CategoryController>().pageSize / 10).ceil();
    //     if (Get.find<CategoryController>().offset < 5) {
    //       print('end of the page');
    //       Get.find<CategoryController>().showBottomLoader();
    //       Get.find<CategoryController>().getCategoryProductList(
    //         Get.find<CategoryController>().subCategoryIndex == 0 ? widget.category.id.toString()
    //             : Get.find<CategoryController>().subCategoryList[Get.find<CategoryController>().subCategoryIndex].id.toString(),
    //         Get.find<CategoryController>().offset+1, false,
    //       );
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (catController) {
      List<ProductModel> _products;
      if(catController.categoryProductList != null && catController.searchProductList != null) {
        _products = [];
        if (catController.isSearching) {
          _products.addAll(catController.searchProductList);
        } else {
          _products.addAll(catController.categoryProductList);
        }
      }

      return WillPopScope(
        onWillPop: () async {
          if(catController.isSearching) {
            catController.toggleSearch();
            return false;
          }else {
            return true;
          }
        },
        child: Scaffold(
          appBar:  AppBar(
            title: catController.isSearching ? TextField(
              autofocus: true,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search...'.tr,
                border: InputBorder.none,
              ),
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
              onSubmitted: (String query) => catController.searchData(
                query, catController.subCategoryIndex == 0 ? widget.category.id.toString()
                  : catController.subCategoryList[catController.subCategoryIndex].id.toString(), 1,
              ),
            ) : Text(widget.category.name, style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge.color,
            )),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Theme.of(context).textTheme.bodyLarge.color,
              onPressed: () {
                if(catController.isSearching) {
                  catController.toggleSearch();
                }else {
                  Get.back();
                }
              },
            ),
            backgroundColor: Theme.of(context).cardColor,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () => catController.toggleSearch(),
                icon: Icon( catController.isSearching ? Icons.close_sharp : Icons.search, color: Theme.of(context).textTheme.bodyLarge.color),
              ),
            ],
          ),

          body: SingleChildScrollView (
            controller: _scrollController,
            child: PaginatedListView(
              scrollController: _scrollController,
              dataList: _products,
              perPage: 10,
              onPaginate: (int offset) async => catController.isSearching ?  catController.searchData(
              catController.prodResultText,  widget.category.id.toString(), offset) :
              catController.getCategoryProductList(widget.category.id.toString(), offset, false),
              itemView: ProductView( products: _products, isShop: false, noDataText: 'no_category_food_found'.tr ),
            ),
          )

          /*Column(children: [
            // SizedBox(
            //   width: Dimensions.WEB_MAX_WIDTH,
            //   height: context.height - 90,
            //   child: PaginatedListView(
            //       scrollController: _scrollController,
            //       dataList: catController.subCategoryList,
            //       perPage: int.parse(AppConstants.PAGINATION_LIMIT),
            //       onPaginate: (int offset) async => catController.getCategoryProductList(widget.category.id.toString(), offset, false),
            //       itemView :

            ProductView(isScrollable: true, products: _products, isShop: false, noDataText: 'no_category_food_found'.tr)
            //),
            // ),
          ]),*/


        ),
      );
    });
  }
}
