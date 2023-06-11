import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/helper/product_type.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/paginated_list_view.dart';

class AllProductScreen extends StatefulWidget {
  final ProductType productType;
  AllProductScreen({@required this.productType});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if(widget.productType == ProductType.POPULAR_PRODUCT) {
      Get.find<ProductController>().getPopularProductList(true, false, 1);
    }else if(widget.productType == ProductType.REVIEWED_PRODUCT) {
      Get.find<ProductController>().getReviewedProductList(true, false);
    }else if(widget.productType == ProductType.SALE_PRODUCT) {
      Get.find<ProductController>().getSaleProductList(true, false, 1);
    }else if(widget.productType == ProductType.LATEST_PRODUCT) {
      Get.find<ProductController>().getProductList(1, false);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.productType == ProductType.POPULAR_PRODUCT ? 'popular_products'.tr : widget.productType
            == ProductType.REVIEWED_PRODUCT ? 'best_reviewed_products'.tr : widget.productType == ProductType.LATEST_PRODUCT ? 'new_arrival'.tr : 'on_sale_products'.tr,
        //showCart: true,
      ),
      body: GetBuilder <ProductController>(
        builder: (productController) {
          return SingleChildScrollView(
           controller: _scrollController,
            child: Center(child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child:  PaginatedListView (
                scrollController: _scrollController,
                dataList: widget.productType == ProductType.POPULAR_PRODUCT ? productController.popularProductList : productController.saleProductList,
                perPage: 10,
                onPaginate: (int offset) async => widget.productType == ProductType.POPULAR_PRODUCT ? productController.getPopularProductList(false, false, offset) : productController.getSaleProductList(false, false, offset),
                itemView: ProductView(
                  products: widget.productType == ProductType.POPULAR_PRODUCT ? productController.popularProductList : widget.productType
                    == ProductType.REVIEWED_PRODUCT ? productController.reviewedProductList : widget.productType == ProductType.LATEST_PRODUCT ? productController.productList : productController.saleProductList,
              ),
            ),
          )));
        }
      ),
    );
  }
}
