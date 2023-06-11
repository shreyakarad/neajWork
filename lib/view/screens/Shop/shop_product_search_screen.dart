import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/view/base/product_view.dart';
import 'package:flutter_woocommerce/view/screens/Shop/controller/shop_controller.dart';
import 'package:get/get.dart';


class ShopProductSearchScreen extends StatefulWidget {
  final String storeID;
  const ShopProductSearchScreen({Key key, @required this.storeID}) : super(key: key);

  @override
  State<ShopProductSearchScreen> createState() => _ShopProductSearchScreenState();
}

class _ShopProductSearchScreenState extends State<ShopProductSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<ShopController>().initSearchData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        //Get.find<ShopController>().searchedListEmpty();
        Get.find<ShopController>().clearSearchList();
        return true;
      },

      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            height: 60 + context.mediaQueryPadding.top, width: Dimensions.WEB_MAX_WIDTH,
            padding: EdgeInsets.only(top: context.mediaQueryPadding.top),
            color: Theme.of(context).cardColor,
            alignment: Alignment.center,
            child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
              child: Row(children: [

                IconButton(
                  onPressed: () {
                    // Get.find<ShopController>().searchedListEmpty();
                    Get.find<ShopController>().clearSearchList();
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
                ),

                Expanded(child: TextField(
                  controller: _searchController,
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                  textInputAction: TextInputAction.search,
                  cursorColor: Theme.of(context).primaryColor,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'search_item_in_store'.tr,
                    hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor),
                    isDense: true,
                    contentPadding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.3), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.3), width: 1),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Theme.of(context).hintColor, size: 25),
                      onPressed: () => Get.find<ShopController>().getStoreSearchItemList(_searchController.text.trim(), int.parse(widget.storeID), 1),
                    ),
                  ),
                  onSubmitted: (text) => Get.find<ShopController>().getStoreSearchItemList(_searchController.text.trim(), int.parse(widget.storeID), 1),
                )),

              ]),
            )),
          ),
          preferredSize: Size(Dimensions.WEB_MAX_WIDTH, 60),
        ),

        body:  GetBuilder<ShopController> (builder: (shopController) {
          return (!shopController.isSearching && shopController.searchProductList == null) ? NoDataScreen(text: 'search_store_product'.tr, type: NoDataType.SEARCH) :
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Center(
              child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: PaginatedListView(
                scrollController: _scrollController,
                onPaginate: (int offset) => shopController.getStoreSearchItemList(shopController.searchText, int.parse(widget.storeID), offset),
                dataList: shopController.searchProductList,
                itemView: ProductView(
                  isShop: false,
                  products: shopController.searchProductList !=null ? shopController.searchProductList.length > 0 ? shopController.searchProductList : [] : null,
                  //products: shopController.searchProductList,
                  shops: null,
                  noDataText: 'no_product_found'.tr,
                ),
              )),
            ),
          );
        }),
      ),
    );
  }
}
