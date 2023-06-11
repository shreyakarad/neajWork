import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/product_view.dart';
import 'package:flutter_woocommerce/view/screens/search/controller/search_controller.dart';
import 'package:get/get.dart';
import '../../../base/paginated_list_view.dart';

class ItemView extends StatefulWidget {
  ItemView();

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchController>(builder: (searchController) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child:
          PaginatedListView (
            scrollController: _scrollController,
            dataList: searchController.searchProductList,
            perPage: 6,
            onPaginate: (int offset) async => searchController.searchData(searchController.prodResultText, offset),
            itemView: ProductView (
              isShop: false, products: searchController.searchProductList,
            ),
          ))),
        );
      }),
    );
  }
}
