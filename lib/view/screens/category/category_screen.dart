import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/view/screens/category/controller/category_controller.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Get.find<CategoryController>().getCategoryList(false, 1);
  }

  @override
  Widget build(BuildContext context) {

    double imageSize = Get.width/4.5;
    return Scaffold(
      appBar: CustomAppBar(title: 'categories'.tr),
      body: SafeArea(child: Scrollbar(child: SingleChildScrollView(controller: _scrollController, child: Center(child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: GetBuilder<CategoryController>(builder: (categoryController) {
          return PaginatedListView(
              scrollController: _scrollController,
              dataList: categoryController.categoryList,
              perPage: 24,
              onPaginate: (int offset) async => await categoryController.getCategoryList(false, offset),
              itemView: categoryController.categoryList != null ? categoryController.categoryList.length > 0 ?
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:  ResponsiveHelper.isTab(context) ? 4 : 4,
                childAspectRatio: .7,
                mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
              ),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 0),
              itemCount: categoryController.categoryList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if(!categoryController.isLoading){
                      Get.toNamed(RouteHelper.getCategoryProductRoute(categoryController.categoryList[index]));
                    }
                  },

                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      child: CustomImage(
                        height: imageSize, width: imageSize, fit: BoxFit.cover,
                        image: categoryController.categoryList[index].image != null ? categoryController.categoryList[index].image.src : '',
                      ),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Padding(
                      padding: EdgeInsets.only(right: index == 0 ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),
                      child: Text(
                        categoryController.categoryList[index].name,
                        style: robotoRegular.copyWith(fontSize: 11, color: Theme.of(context).primaryColor),
                        maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                );
              },
            ) : NoDataScreen(text: 'no_category_found'.tr) : Center(child: CircularProgressIndicator()),
          );
        }),
      ))))),
    );
  }
}
