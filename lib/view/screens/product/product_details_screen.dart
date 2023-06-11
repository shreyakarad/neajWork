import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/view/base/product_card.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/widget/product_specification.dart';
import 'package:flutter_woocommerce/view/screens/product/widget/product_details_bottom_view.dart';
import 'package:flutter_woocommerce/view/screens/product/widget/promise_screen.dart';
import 'package:flutter_woocommerce/view/screens/product/widget/related_product_widget.dart';
import 'package:flutter_woocommerce/view/screens/product/widget/review_widget.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/screens/product/widget/details_app_bar.dart';
import 'package:flutter_woocommerce/view/screens/product/widget/product_image_view.dart';
import 'package:flutter_woocommerce/view/screens/product/widget/product_title_view.dart';

class ProductDetailsScreen extends StatefulWidget {
  final bool formSplash;
  final String url;
  final ProductModel product;
  ProductDetailsScreen({@required this.product, this.formSplash = false,@required this.url});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with TickerProviderStateMixin {
  final Size size = Get.size;
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  final GlobalKey<DetailsAppBarState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    if(Get.find<AuthController>().isLoggedIn()){
      Get.find<ProfileController>().getUserInfo();
    }
    if(widget.formSplash){
      Get.find<ProductController>().getSlugProductDetails(widget.url,true);
    } else if(widget.product.id != -1) {
      Get.find<ProductController>().getProductDetails(widget.product);
    }
  }

  List<Tab> _getTabs() {
    List<Tab> _tabs = [];
    _tabs.add(Tab(text: 'description'.tr, ));
    _tabs.add(Tab(text: 'specification'.tr));
    if(Get.find<ConfigController>().isReviewEnabled()) {
      _tabs.add(Tab(text: 'review'.tr));
    }
    return _tabs;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (productController){
        if(productController.product != null && productController.variations == null && productController.variationIndex != null) {
          List<String> _variationList = [];
          for (int index = 0; index < productController.product.attributes.length; index++) {
            if(productController.product.attributes[index].options.isNotEmpty) {
              _variationList.add(productController.product.attributes[index].options[productController.variationIndex[index]].replaceAll(' ', ''));
            }
          }
          String variationType = '';
          bool isFirst = true;
          _variationList.forEach((variation){
            if (isFirst) {
              variationType = '$variationType$variation';
              isFirst = false;
            } else {
              variationType = '$variationType-$variation';
            }
          });

          List<Variation> _variations = [];
          for(int index=0; index<productController.product.attributes.length; index++) {
            if(productController.product.attributes[index].options.isNotEmpty) {
              _variations.add(Variation(
                attribute: productController.product.attributes[index].name,
                value: productController.product.attributes[index].options[productController.variationIndex[index]],
              ));
            }
          }
        }

        return WillPopScope (
          onWillPop: () async {
            if(widget.formSplash) {
              productController.resetImageIndex();
              return  Get.offNamed(RouteHelper.getInitialRoute());
            }else {
              //productController.resetImageIndex();
              productController.productDetailsBack();
              return true;
            }
          },
          child: Scaffold(
            key: _globalKey,
            appBar: DetailsAppBar(productSlug : widget.product.slug, key: _key, formSplash: widget.formSplash,  ),
            body: (productController.product != null) ?
            Column(children: [
              Expanded(child: Scrollbar(child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_DEFAULT),
                physics: BouncingScrollPhysics(),
                child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 300,
                      child: ProductImageView(product: productController.product)),
                    SizedBox(height: 20),
                    ProductTitleView(product: productController.product),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                    Get.find<ConfigController>().settings.productSettings != null ?
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).cardColor,
                        boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.2), blurRadius: 1, spreadRadius: 1,offset: Offset(0,0))]
                      ),
                      child: TabBar(
                        indicator:  BoxDecoration(
                          color: Theme.of(context).primaryColorLight.withOpacity(.5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        indicatorPadding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        indicatorColor: Colors.transparent,
                        labelColor: Theme.of(context).primaryColor,
                        labelStyle: robotoBold,
                        unselectedLabelStyle: robotoRegular,
                        controller: TabController(
                          length: Get.find<ConfigController>().isReviewEnabled() ? 3 : 2,
                          vsync: this, initialIndex: productController.tabIndex,
                        ),
                        onTap: (int index) => productController.setTabIndex(index, productController.product.id),
                        tabs: _getTabs(),
                      ),
                    ) : SizedBox(),

                    SizedBox(height: Get.find<ConfigController>().settings.productSettings != null ? Dimensions.PADDING_SIZE_SMALL : 0),

                    Get.find<ConfigController>().settings.productSettings != null ? productController.tabIndex == 0 ?
                    Column(
                      children: [
                        Html(data: productController.product.description, shrinkWrap: true),
                        PromiseScreen(),
                      ],
                    ) : productController.tabIndex == 1 ?  productController.product.attributes.length > 0 ? ProductSpecification(
                      product: productController.product,  //Spec
                    ) : Center(child: Text('no_specifications_found'.tr)) : Column(
                      children: [
                        //Get.find<AuthController>().isLoggedIn() ?  RatingReviewWidget(product: widget.product) : SizedBox(),
                        productController.reviewList != null ?
                        productController.reviewList.length > 0 ?
                        SizedBox(
                          width: Dimensions.WEB_MAX_WIDTH,
                          child: ListView.builder( //Review
                            itemCount: productController.reviewList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return ReviewWidget(
                                review: productController.reviewList[index],
                                hasDivider: index != productController.reviewList.length-1,
                              );
                            },
                          ),
                        ) : Container(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                          child: Center(child: Text('no_reviews_found'.tr, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
                        )
                        : Center(child: CircularProgressIndicator())
                      ],
                    ) : SizedBox(),
                    SizedBox(height: Get.find<ConfigController>().settings.productSettings != null ? Dimensions.PADDING_SIZE_LARGE : 0),

                    Text('related_products'.tr, style:robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    productController.product.relatedIds.length != 0 ? productController.relatedProductList != null ?
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .56,
                        mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                        crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      itemCount: productController.relatedProductList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(productModel: productController.relatedProductList[index], allProduct: true,index: index, productList: productController.relatedProductList);
                      },
                    ) : RelatedProductShimmer(productController: productController) :
                    Center(child: Text('no_related_product_found'.tr)),
                  ],
                )))),
              )),
            ]) : Center(child: CircularProgressIndicator()),
            bottomNavigationBar: productController.product != null? ProductDetailsBottomView(productModel: productController.product) : SizedBox(),
          ),
        );
      },
    );
  }
}


