import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupedProductScreen extends StatefulWidget {
  final GroupedProduct groupedProduct;
  GroupedProductScreen({@required this.groupedProduct});

  @override
  _GroupedProductScreenState createState() => _GroupedProductScreenState();
}

class _GroupedProductScreenState extends State<GroupedProductScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    List<int> _groupedIds = [];

    if(widget.groupedProduct.upsellIds.isNotEmpty) {
      for(int i =0; i< widget.groupedProduct.upsellIds.length; i++ ){
          if(!_groupedIds.contains(widget.groupedProduct.upsellIds[i])) {
            _groupedIds.add(widget.groupedProduct.upsellIds[i]);
          }
      }
    }

    if(widget.groupedProduct.groupedProducts.isNotEmpty) {
      for(int i =0; i< widget.groupedProduct.groupedProducts.length; i++ ){
          if(!_groupedIds.contains(widget.groupedProduct.groupedProducts[i])) {
            _groupedIds.add(widget.groupedProduct.groupedProducts[i]);
        }
      }
    }

    print(_groupedIds);
    if(_groupedIds.isNotEmpty) {
      Get.find<ProductController>().clearGroupedProducts(notify: false);
      Get.find<ProductController>().getGroupedProducts(_groupedIds);
    } else {
      Get.find<ProductController>().clearGroupedProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return Scaffold(
        appBar:  AppBar(
          title: Text(widget.groupedProduct.name, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge.color)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Theme.of(context).textTheme.bodyLarge.color,
            onPressed: () { Get.back();},
          ),
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
        ),
        body: SingleChildScrollView (
          controller: _scrollController,
          child: PaginatedListView(
            scrollController: _scrollController,
            dataList: productController.groupedProductList,
            perPage: 100,
            onPaginate: (int offset) async =>  await productController.getProductList(offset, false),
            itemView: ProductView( products: productController.groupedProductList, isShop: false, noDataText: 'no_category_food_found'.tr ),
          ),
        )


        // SingleChildScrollView(
        //   controller: scrollController,
        //   child: PaginatedListView(
        //     scrollController: scrollController,
        //     dataList: productController.groupedProductList,
        //     perPage: 100,
        //     onPaginate: (int offset) async => await productController.getProductList(offset, false),
        //     itemView: ProductView(isScrollable: true, products: productController.groupedProductList, isShop: false, noDataText: 'no_category_food_found'.tr),
        //   ),
        // ),

        // widget.groupedProduct.upsellIds.isNotEmpty ? Center(child: SizedBox(
        //   width: Dimensions.WEB_MAX_WIDTH,
        //   child: Column(children: [
        //     Expanded(child: ProductView(isScrollable: true, products: productController.groupedProductList, isShop: false, noDataText: 'no_category_food_found'.tr)),
        //     // productController.isLoading ? Center(child: Padding(
        //     //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        //     //   child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
        //     // )) : SizedBox(),
        //   ]),
        // )) : NoDataScreen(text: 'no_product_found'.tr, type: NoDataType.OTHERS),

      );
    });
  }
}
