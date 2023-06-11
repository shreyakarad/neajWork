import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/view/base/product_view.dart';
import 'package:flutter_woocommerce/view/screens/Shop/controller/shop_controller.dart';
import 'package:get/get.dart';

class AllShopScreen extends StatefulWidget {
  @override
  State<AllShopScreen> createState() => _AllShopScreenState();
}

class _AllShopScreenState extends State<AllShopScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
      //Get.find<RestaurantController>().getPopularRestaurantList(false, 'all', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'shops'.tr),
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<ShopController>().getShopList(1);
        },
        child: SingleChildScrollView( controller: _scrollController, child: Center(child: SizedBox(
          width: Dimensions.WEB_MAX_WIDTH,
          child: GetBuilder<ShopController>(builder: (shopController) {
            return PaginatedListView(
              perPage: 10,
              scrollController: _scrollController,
              dataList: shopController.shopList,
              onPaginate: (int offset) async => await shopController.getShopList(offset),
              itemView : ProductView(
                isShop: true, shops:  shopController.shopList, products: null, noDataText: 'no_shop_available'.tr,
              ),
            );
          }),
        ))),
      ),
    );
  }
}
