import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/images.dart';
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
    if(AppConstants.vendorType != VendorType.singleVendor) {
      Get.find<ShopController>().getShopList(1);
    }
    FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
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
  }
  double _scrollOffset = 0.0;
  bool isSafeArea = false;

  Future<void> loadDataRefresh(bool reload) async{
    await Get.find<WishListController>().getWishList();
    await Get.find<CategoryController>().getCategoryList(reload, 1);
    await Get.find<ProductController>().getProductList(1, reload);
    await Get.find<ProductController>().getPopularProductList(reload, false, 1);
    await Get.find<ProductController>().getSaleProductList(reload, false, 1);
    await Get.find<ProductController>().getReviewedProductList(reload, false);
    await Get.find<ProductController>().getGroupedProductList(reload, false, 1);
    await Get.find<BannerController>().getBannerList();
    if(AppConstants.vendorType != VendorType.singleVendor) {
      await Get.find<ShopController>().getShopList(1);
    }
    FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
      await Get.find<ProfileController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (bannerController) {
        _scrollController.addListener(() {
          _scrollOffset = _scrollController.offset;
          if (bannerController.bannerList.length == 0 && _scrollOffset > 61){
            if(!bannerController.isSafeArea) {
              bannerController.setSafeAreaTrue();
            }
          }
          else if (_scrollOffset > 220) {
            if(!bannerController.isSafeArea) {
              bannerController.setSafeAreaTrue();
            }
          } else {
            if(bannerController.isSafeArea){
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
                  if(GetPlatform.isIOS)
                    SliverAppBar(
                      elevation: 0,
                      pinned: true,
                      toolbarHeight: 70,
                      title: Text('welcome_back'.tr, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.displayMedium.color)),
                      centerTitle: false,
                      backgroundColor: Get.isDarkMode ? Colors.black54 : Theme.of(context).primaryColorLight,
                      actions: [
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            child: Image.asset(Images.notification, height: 20, width: 15),
                          ),
                          onTap: () {
                            Get.toNamed(RouteHelper.getNotificationRoute());
                          },
                        )
                      ],

                      flexibleSpace: Padding(
                        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,100,Dimensions.PADDING_SIZE_DEFAULT,0),
                        child: GetBuilder<ProfileController>(builder: (profileController) {
                          return Get.find<AuthController>().isLoggedIn() ? Text(
                            profileController.profileModel != null ?
                            ((profileController.profileModel.firstName ?? '')  +' '+ (profileController.profileModel.lastName ?? '')) : '',
                            style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
                          ) : Text('guest'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault));
                        }),
                      ),
                    ),

                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top:  MediaQuery.of(context).padding.top)),
                        if(GetPlatform.isAndroid)
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            border: Border.all(color: Theme.of(context).primaryColorLight)
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_SMALL,Dimensions.PADDING_SIZE_DEFAULT,0),
                            child: Row(children: [
                              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('welcome_back'.tr,
                                    style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.displayMedium.color)),
                                  GetBuilder<ProfileController>(
                                    builder: (profileController) {
                                      return Get.find<AuthController>().isLoggedIn() ?
                                      Text(profileController.profileModel != null?
                                      ((profileController.profileModel.firstName ?? '')  +' '+ (profileController.profileModel.lastName ?? '')) : '',
                                       style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)):
                                      Text('guest'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault));
                                    }
                                  )])
                              ),

                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_DEFAULT),
                                  child: Image.asset(Images.notification, height: 20, width: 15,),
                                ),
                                onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
                              )
                            ])),
                        ),

                        // bannerController.bannerList != null &&
                        ( bannerController.bannerList.length !=0 ) ?
                        Container(
                         height: 170,
                         padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 10, Dimensions.PADDING_SIZE_DEFAULT, 0),
                         child: BannerView(),
                         decoration: BoxDecoration(
                           gradient: LinearGradient(
                             begin: Alignment.topCenter,
                             end: Alignment.bottomCenter,
                             colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColorLight],
                           ),
                           border: Border.all(color: Theme.of(context).primaryColorLight)
                         )
                        ) : SizedBox(),
                      ],
                    ),
                  ),

                  bannerController.isSafeArea ?
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverDelegate(
                      height: MediaQuery.of(context).padding.top,
                      child:  Container(
                        color: Theme.of(context).primaryColorLight,
                        height: MediaQuery.of(context).padding.top,
                      ),
                    ),
                  ) : SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverDelegate(
                      height: 0,
                      child:  SizedBox(height: 0),
                    ),
                  ),

                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverDelegate(
                      height: 85,
                      child:  InkWell(
                        onTap: ()=> Get.to(()=> SearchScreen()),
                        child: SearchWidget()))
                ),

                SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      width: Dimensions.WEB_MAX_WIDTH,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        CategoryView(),

                        PopularProductView(isPopular: true),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                        TopRatedProduct(),

                        SaleProductView(),

                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        AppConstants.vendorType != VendorType.singleVendor ? ShopView() : SizedBox(),

                        GroupedProductView(),

                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                          child: Text('all_product'.tr,
                            style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                          ),
                        ),
                        GetBuilder<ProductController>( builder: (productController) {
                          return PaginatedListView(
                            scrollController: _scrollController,
                            dataList: productController.productList,
                            perPage: int.parse(AppConstants.PAGINATION_LIMIT),
                            onPaginate: (int offset) async => await productController.getProductList(offset, false),
                            itemView: ProductView(products: productController.productList,isShop: false),
                          );
                        }),

                      ]),
                    )),
                  ),
               ],
            ),
          ));
       }
    );
  }
}
