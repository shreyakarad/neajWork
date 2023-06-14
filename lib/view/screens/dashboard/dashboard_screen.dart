import 'dart:async';
import 'dart:io';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/util/color_utils.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/screens/cart/cart_screen.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/home/home_screen.dart';
import 'package:flutter_woocommerce/view/screens/more/more_screen.dart';
import 'package:flutter_woocommerce/view/screens/order/order_screen.dart';
import 'package:flutter_woocommerce/view/screens/wish/wish_screen.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      WishPage(),
      CartScreen(fromNav: true),
      OrderScreen(
        formMenu: false,
      ),
      MoreScreen(),
    ];

    Future.delayed(Duration(seconds: 0), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
              exit(0);
            } else if (GetPlatform.isIOS) {
              exit(0);
            }
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr,
                  style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartController) {
          return GNav(
              rippleColor: ColorUtils.primaryColor
                  .withOpacity(0.1), // tab button ripple color when pressed
              backgroundColor: Color(0xFFf7f8f7),
              tabMargin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              hoverColor: ColorUtils.primaryColor
                  .withOpacity(0.1), // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 18,
              tabActiveBorder: Border.all(
                  color: Colors.white, width: 1), // tab button border
              tabBorder: Border.all(color: Colors.white, width: 1),
              onTabChange: (value) {
                _setPage(value);
                print("valyee== $value");
              }, // tab button border
              // tabShadow: [
              //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              // ], // tab button shadow
              curve: Curves.easeOutExpo, // tab animation curves
              duration: Duration(milliseconds: 900), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: ColorUtils.grey, // unselected icon color
              activeColor:
                  ColorUtils.primaryColor, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor: ColorUtils.primaryColor
                  .withOpacity(0.2), // selected tab background color
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5), // navigation bar padding
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.shopping_cart,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.shopping_bag,
                  text: 'Profile',
                ),
                GButton(
                  icon: Icons.dashboard_customize_outlined,
                  text: 'Profile',
                )
              ]);
          //   ConvexAppBar.badge(
          //   cartController.cartList.length == 0 ? {} : { 2 : '${cartController.cartList.length}'},
          //   badgeMargin : EdgeInsets.only(bottom: 30, left: Get.find<LocalizationController>().isLtr ? 15 : 0, right: Get.find<LocalizationController>().isLtr ? 0 : 15 ),
          //   style: TabStyle.react,
          //   color: Theme.of(context).primaryColor,
          //   elevation: 5,
          //   activeColor: Theme.of(context).primaryColor,
          //   backgroundColor: Theme.of(context).cardColor,
          //   initialActiveIndex: _pageIndex,
          //   controller: _tabController,
          //   items: [
          //     TabItem(icon: Icons.home, title: 'home'.tr),
          //     TabItem(icon: Icons.favorite, title: 'favourite'.tr),
          //     TabItem(icon: Icons.shopping_cart, title: 'cart'.tr),
          //     TabItem(icon: Icons.shopping_bag, title: 'order'.tr),
          //     TabItem(icon: Icons.dashboard_customize_outlined, title: 'more'.tr),
          //   ],
          //   onTap: (int index) => _setPage(index),
          // );
        }),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
      _tabController.animateTo(_pageIndex);
    });
  }
}
