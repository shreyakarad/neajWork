import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:get/get.dart';

class GroupedScreen extends StatefulWidget {
  @override
  State<GroupedScreen> createState() => _GroupedScreenState();
}

class _GroupedScreenState extends State<GroupedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Get.find<CategoryController>().getCategoryList(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'grouped_product'.tr),
      body: SafeArea(child: Scrollbar(child: SingleChildScrollView(controller: _scrollController, child: Center(child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: GetBuilder<ProductController>(builder: (productController) {
          return productController.groupedProduct != null ? productController.groupedProduct.length > 0 ?
          PaginatedListView(
              scrollController: _scrollController,
              dataList: productController.groupedProduct,
              perPage: 10,
              onPaginate: (int offset) async => productController.getGroupedProductList(false, false, offset),
              itemView: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:  ResponsiveHelper.isTab(context) ? 3 : 3,
                childAspectRatio: .75,
                mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
              ),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_SMALL),
              itemCount: productController.groupedProduct.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Get.toNamed(RouteHelper.getGroupedProductRoute(productController.groupedProduct[index])),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                    child: SizedBox(
                      height: 150,
                      width: 110,
                      child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                              child: Container(
                                color: Theme.of(context).cardColor,
                                height: 150, width: Dimensions.WEB_MAX_WIDTH,
                                margin: EdgeInsets.all(1),
                                child: CustomImage(
                                  image: productController.getImageUrl(productController.groupedProduct[index].images),
                                  //height: 57, width: 57,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container (
                                margin: EdgeInsets.all(1),
                                height: 30,
                                //width : 110,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.70),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL), bottomRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
                                ),
                                child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                      child: Text(productController.groupedProduct[index].name, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor, overflow: TextOverflow.ellipsis))
                                  ),
                                ),
                              ),
                            ),
                            //SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        ]
                      ),
                    ),
                  ),
                );
              },
            ),
          ) : NoDataScreen( text: 'no_product_found'.tr ) : Center(child: CircularProgressIndicator());
        }),
      ))))),
    );
  }
}
