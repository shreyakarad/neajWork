import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/view/screens/Shop/controller/shop_controller.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/category/controller/category_controller.dart';
import 'package:flutter_woocommerce/view/screens/home/controller/banner_controller.dart';
import 'package:flutter_woocommerce/view/screens/home/home_category_screen.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/poroduct_category_view.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/sale_product_view.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/search_widget.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/top_rated_products.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/category_view.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static void loadData(bool reload) {
    Get.find<WishListController>().getWishList();
    Get.find<CategoryController>().getCategoryList(reload, 1);
    Get.find<ProductController>().getProductList(1, reload);
    Get.find<ProductController>().getPopularProductList(reload, false, 1);
    Get.find<ProductController>().getSaleProductList(reload, false, 1);
    Get.find<ProductController>().getReviewedProductList(reload, false);
    Get.find<ProductController>().getGroupedProductList(reload, false, 1);
    Get.find<BannerController>().getBannerList();
    if (AppConstants.vendorType != VendorType.singleVendor) {
      Get.find<ShopController>().getShopList(1);
    }
    FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getUserInfo();
    }
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  CategoryController categoryController = Get.find<CategoryController>();
  @override
  void initState() {
    super.initState();
    HomeScreen.loadData(false);
    Get.find<BannerController>().setSafeAreaFalse();
    Get.find<BannerController>().isScroll = false;
  }

  double _scrollOffset = 0.0;
  bool isSafeArea = false;
  bool isTapOnSearch = false;

  Future<void> loadDataRefresh(bool reload) async {
    await Get.find<WishListController>().getWishList();
    await Get.find<CategoryController>().getCategoryList(reload, 1);
    await Get.find<ProductController>().getProductList(1, reload);
    await Get.find<ProductController>().getPopularProductList(reload, false, 1);
    await Get.find<ProductController>().getSaleProductList(reload, false, 1);
    await Get.find<ProductController>().getReviewedProductList(reload, false);
    await Get.find<ProductController>().getGroupedProductList(reload, false, 1);
    await Get.find<BannerController>().getBannerList();
    if (AppConstants.vendorType != VendorType.singleVendor) {
      await Get.find<ShopController>().getShopList(1);
    }
    FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
      await Get.find<ProfileController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(builder: (bannerController) {
      _scrollController.addListener(() {
        _scrollOffset = _scrollController.offset;
        if (_scrollOffset > 0) {
          bannerController.isScroll = true;
        }
        if (bannerController.bannerList.length == 0 && _scrollOffset > 61) {
          if (!bannerController.isSafeArea) {
            bannerController.setSafeAreaTrue();
          }
        } else if (_scrollOffset > 220) {
          if (!bannerController.isSafeArea) {
            bannerController.setSafeAreaTrue();
          }
        } else {
          if (bannerController.isSafeArea) {
            bannerController.setSafeAreaFalse();
          }
        }
      });
      print(
          "bannerController.bannerList.length === ${bannerController.bannerList.length}");
      return Scaffold(
          body: RefreshIndicator(
        onRefresh: () async {
          await loadDataRefresh(true);
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              title: bannerController.isScroll == false
                  ? Image.asset(
                      Images.new_logo,
                      color: Color(0xFF132784),
                      fit: BoxFit.cover,
                      height: 50,
                      width: 150,
                    )
                  : SearchWidget(),
              actions: [
                if (bannerController.isScroll == false)
                  InkWell(
                    onTap: () {
                      bannerController.isScroll = true;
                    },
                    child: Image.asset(Images.search,
                        height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                        width: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  ),
                if (bannerController.isScroll == false) SizedBox(width: 10),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1BwYl1Svb2h_YRhj9tcnZk0yAuIHh3oBM03dzDa8f&s'),
                ),
                SizedBox(width: 10),
              ],
            ),
            // bannerController.isSafeArea
            //     ? SliverPersistentHeader(
            //         pinned: true,
            //         delegate: SliverDelegate(
            //           height: MediaQuery.of(context).padding.top,
            //           child: Container(
            //             color: Theme.of(context).primaryColorLight,
            //             height: MediaQuery.of(context).padding.top,
            //           ),
            //         ),
            //       )
            //     : SliverPersistentHeader(
            //         pinned: true,
            //         delegate: SliverDelegate(
            //           height: 0,
            //           child: SizedBox(height: 0),
            //         ),
            //       ),
            // SliverPersistentHeader(
            //     pinned: true,
            //     delegate: SliverDelegate(
            //         height: 85,
            //         child: InkWell(
            //             onTap: () => Get.to(() => SearchScreen()),
            //             child: SearchWidget()))),
            SliverToBoxAdapter(
              child: Center(
                  child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Banner 1
                      (bannerController.bannerList.length != 0)
                          ? Container(
                              height: 170,
                              width: Get.width,
                              padding: EdgeInsets.fromLTRB(
                                  Dimensions.PADDING_SIZE_DEFAULT,
                                  10,
                                  Dimensions.PADDING_SIZE_DEFAULT,
                                  0),
                              // child: BannerView(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomImage(
                                  image:
                                      '${bannerController.bannerList[0].image}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : SizedBox(),
                      CategoryView(),
                      //PopularProductView(isPopular: true),
                      //SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      TopRatedProduct(),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      SaleProductView(),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                      ///Banner 2
                      (bannerController.bannerList.length > 1)
                          ? Container(
                              height: 170,
                              width: Get.width,
                              padding: EdgeInsets.fromLTRB(
                                  Dimensions.PADDING_SIZE_DEFAULT,
                                  10,
                                  Dimensions.PADDING_SIZE_DEFAULT,
                                  0),
                              // child: BannerView(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomImage(
                                  image:
                                      '${bannerController.bannerList[1].image}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : SizedBox(),

                      ///OLD Code Shop view
                      // AppConstants.vendorType != VendorType.singleVendor
                      //     ?
                      // ShopView()
                      //     : SizedBox(),
                      // StaggeredGridView.countBuilder(
                      //   physics: ClampingScrollPhysics(),
                      //   crossAxisCount: 4,
                      //   padding: EdgeInsets.zero,
                      //   shrinkWrap: true,
                      //   itemCount: 8,
                      //   mainAxisSpacing: 10,
                      //   crossAxisSpacing: 10,
                      //   itemBuilder: (BuildContext context, int index) =>
                      //       Container(
                      //           height: 200,
                      //           margin: index.isOdd
                      //               ? EdgeInsets.only(top: 20)
                      //               : null,
                      //           color: Colors.green,
                      //           child: new Center(
                      //             child: new CircleAvatar(
                      //               backgroundColor: Colors.white,
                      //               child: new Text('$index'),
                      //             ),
                      //           )),
                      //   staggeredTileBuilder: (int index) =>
                      //       new StaggeredTile.fit(2),
                      // ),
                      // Text("HomeCategoryProductsView"),
                      //
                      // HomeCategoryProductsView(),
                      // Text("HomeCategoryScreen"),
                      // HomeCategoryScreen(
                      //   categoryId: 548,
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      GetBuilder<CategoryController>(
                          builder: (categoryController) {
                        return (categoryController.categoryList != null &&
                                categoryController.categoryList.length != 0)
                            ? HomeCategoryScreen(
                                categoryList: categoryController.categoryList)
                            : SizedBox();
                      }),

                      ///Banner 2
                      (bannerController.bannerList.length > 2)
                          ? Container(
                              height: 170,
                              width: Get.width,
                              padding: EdgeInsets.fromLTRB(
                                  Dimensions.PADDING_SIZE_DEFAULT,
                                  10,
                                  Dimensions.PADDING_SIZE_DEFAULT,
                                  0),
                              // child: BannerView(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomImage(
                                  image:
                                      '${bannerController.bannerList[2].image}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : SizedBox(),
                      // GroupedProductView(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                        child: Text(
                          'all_product'.tr,
                          style: poppinsMedium.copyWith(
                              fontSize: 20, color: Colors.black),
                        ),
                      ),
                      GetBuilder<ProductController>(
                          builder: (productController) {
                        return PaginatedListView(
                          scrollController: _scrollController,
                          dataList: productController.productList,
                          perPage: int.parse(AppConstants.PAGINATION_LIMIT),
                          onPaginate: (int offset) async =>
                              await productController.getProductList(
                                  offset, false),
                          itemView: ProductCatView(
                              products: productController.productList,
                              isShop: false),
                        );
                      }),
                    ]),
              )),
            ),
          ],
        ),
      ));
    });
  }
}
