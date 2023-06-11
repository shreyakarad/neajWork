import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/product_view.dart';
import 'package:flutter_woocommerce/view/screens/Shop/controller/shop_controller.dart';
import 'package:flutter_woocommerce/view/screens/Shop/widgets/shop_information_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/Shop/model/shop_model.dart';
import '../../base/paginated_list_view.dart';

class ShopScreen extends StatefulWidget {
  final ShopModel shop;
  ShopScreen({@required this.shop});
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print('Shop_Screen');
    Get.find<ShopController>().getShopProduct(widget.shop.id, 1);
  }


  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ShopController>(builder: (shopController) {
        ShopModel shop = widget.shop;
        return CustomScrollView(
          clipBehavior: Clip.none,
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              centerTitle: true,
              title: Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Text(widget.shop.storeName)
              ),
              expandedHeight: 120, toolbarHeight: 50,
              pinned: true, floating: false,
              backgroundColor: Get.isDarkMode ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).primaryColor,
              leading: IconButton(
                icon: Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                  alignment: Alignment.center,
                  child: Icon(Icons.chevron_left, color: Theme.of(context).cardColor),
                ),
                onPressed: () => Get.back(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    shop.id == 1 ?
                    Image.asset(
                      Images.logo,
                      width: Dimensions.WEB_MAX_WIDTH,
                      fit: BoxFit.cover,
                    ) :
                    CustomImage(
                      height: 160,
                      width: 500,
                      //width: Dimensions.WEB_MAX_WIDTH,
                      fit: BoxFit.cover,
                      image: shop.banner,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.50),
                    ),
                  ],
                )
              ),
              actions: [IconButton(
                onPressed: () {
                  Get.toNamed(RouteHelper.getSearchShopProductRoute(shop.id));
                },
                icon: Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                  alignment: Alignment.center,
                  child: Icon(Icons.search, size: 20, color: Theme.of(context).cardColor),
                ),
              )],
            ),

            SliverToBoxAdapter(child: Center(child: Container(
              width: Dimensions.WEB_MAX_WIDTH,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              color: Theme.of(context).cardColor,
              child: Column(children: [
                // ShopDescriptionView(shop: shop),
                ShopInformationWidget(shop: shop,shopController: shopController)
              ]),
              )
            )),



            (shopController.dokanProductList !=null && shopController.dokanProductList.length  > 0 ) ? SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                height: 40, width: Dimensions.WEB_MAX_WIDTH,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('our_products'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge )),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  border: Border.all(color: Theme.of(context).cardColor)
                ),
              ),
            ) : SliverToBoxAdapter(child: SizedBox()),


            SliverToBoxAdapter(
              child: PaginatedListView(
                scrollController: _scrollController,
                dataList: shopController.dokanProductList,
                perPage: 10,
                onPaginate: (int offset) async => await shopController.getShopProduct(widget.shop.id, offset),
                itemView: ProductView(
                isShop: false,
                products: shopController.dokanProductList !=null ? shopController.dokanProductList.length > 0 ? shopController.dokanProductList : [] : null,
                shops: null,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_SMALL : 0,
                ),
               ),
              )
            ),
          ],
        ); //: Center(child: CircularProgressIndicator());
      }),
    );
  }
}



class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}




