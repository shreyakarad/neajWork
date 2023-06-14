import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_woocommerce/helper/product_type.dart';
import 'package:flutter_woocommerce/view/base/product_card.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/populaar_food_shimmer.dart';
import 'package:flutter_woocommerce/view/screens/product/all_product_screen.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/product_details_screen.dart';
import 'package:get/get.dart';

class PopularProductView extends StatelessWidget {
  final bool isPopular;
  final bool newArrival;
  PopularProductView({@required this.isPopular, this.newArrival = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      List<ProductModel> _productList = [];
      _productList = isPopular
          ? productController.popularProductList
          : newArrival
              ? productController.productList
              : productController.reviewedProductList;
      ScrollController _scrollController = ScrollController();

      return (_productList != null && _productList.length == 0)
          ? SizedBox()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,
                      15, Dimensions.PADDING_SIZE_DEFAULT, 10),
                  child: TitleWidget(
                    title: isPopular
                        ? 'popular_products'.tr
                        : newArrival
                            ? 'new_arrival'.tr
                            : 'most_reviewed_products'.tr,
                    onTap: () {
                      Get.to(() => AllProductScreen(
                          productType: isPopular
                              ? ProductType.POPULAR_PRODUCT
                              : newArrival
                                  ? ProductType.LATEST_PRODUCT
                                  : ProductType.REVIEWED_PRODUCT));
                    },
                  ),
                ),
                SizedBox(
                  height: 235,
                  child: _productList != null
                      ?
                      // CarouselSlider(
                      // options: CarouselOptions(
                      // autoPlay: false,
                      // aspectRatio: 1.4,
                      // reverse: false,
                      // height: 300,
                      // enlargeCenterPage: true,
                      // ),
                      // items: _productList
                      //     .map((item) =>
                      // Padding(
                      // padding: const EdgeInsets.all(0.0),
                      // child: Container(
                      // child: ClipRRect(
                      // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      // child: Stack(
                      // children: <Widget>[
                      // Image.network(
                      // item,
                      // fit: BoxFit.cover,
                      // ),
                      // Positioned(
                      // bottom: 0.0,
                      // left: 0.0,
                      // right: 0.0,
                      // child: Container(
                      // decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      // colors: [
                      // Color.fromARGB(200, 0, 0, 0),
                      // Color.fromARGB(0, 0, 0, 0)
                      // ],
                      // begin: Alignment.bottomCenter,
                      // end: Alignment.topCenter,
                      // ),
                      // ),
                      // padding: EdgeInsets.symmetric(
                      // vertical: 10.0, horizontal: 20.0),
                      // child: Text(
                      // 'No. ${_productList.indexOf(item)} image',
                      // style: TextStyle(
                      // color: Colors.white,
                      // fontSize: 20.0,
                      // fontWeight: FontWeight.bold,
                      // ),
                      // ),
                      // ),
                      // ),
                      // ],
                      // )),
                      // ),
                      // ))
                      //     .toList(),
                      // )
                      ListView.builder(
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_SMALL),
                          itemCount: _productList.length > 10
                              ? 10
                              : _productList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  2, 2, Dimensions.PADDING_SIZE_SMALL, 2),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    RouteHelper.getProductDetailsRoute(
                                        _productList[index].id, '', false),
                                    arguments: ProductDetailsScreen(
                                      product: _productList[index],
                                      url: '',
                                    ),
                                  );
                                },
                                child: ProductCard(
                                    productModel: _productList[index],
                                    index: index,
                                    productList: _productList),
                              ),
                            );
                          },
                        )
                      : PopularFoodShimmer(enabled: _productList == null),
                ),
              ],
            );
    });
  }
}
