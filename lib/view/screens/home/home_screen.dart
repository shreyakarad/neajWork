import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/color_utils.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/custom_sliver.dart';
import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/view/base/product_view.dart';
import 'package:flutter_woocommerce/view/screens/Shop/controller/shop_controller.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/category/controller/category_controller.dart';
import 'package:flutter_woocommerce/view/screens/grouped_product/grouped_product_view.dart';
import 'package:flutter_woocommerce/view/screens/home/controller/banner_controller.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/banner_view.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/sale_product_view.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/search_widget.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/shop_view.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/top_rated_products.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/category_view.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/popular_product_view.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/search/search_screen.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:get/get.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

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

  final List<Widget> imageSliders = imgList
      .map((item) => Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

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
                      (bannerController.bannerList.length != 0)
                          ? Container(
                              height: 170,
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
                      AppConstants.vendorType != VendorType.singleVendor
                          ? ShopView()
                          : SizedBox(),
                      GroupedProductView(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                        child: Text(
                          'all_product'.tr,
                          style: poppinsMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color: Theme.of(context).primaryColor),
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
                          itemView: ProductView(
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
