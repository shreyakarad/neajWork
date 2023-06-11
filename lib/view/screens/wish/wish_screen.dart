import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/view/base/confirmation_dialog.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:flutter_woocommerce/view/screens/wish/widgets/wished_product_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/util/styles.dart';

class WishPage extends StatefulWidget {
  const WishPage({Key key}) : super(key: key);
  @override
  State<WishPage> createState() => _WishPageState();
}

class _WishPageState extends State<WishPage> {
  initState(){
    super.initState();
    Get.find<WishListController>().getWishList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'wishList'.tr, isBackButtonExist: false),
      body: GetBuilder<WishListController>(
        builder: (wishController){
          return Column(
            mainAxisAlignment:  MainAxisAlignment.start ,
            children:[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    wishController.wishProductList.length != 0 ?
                    Text('loved'.tr+' '+wishController.wishProductList.length.toString()+' '+'items'.tr,
                    style: DMSansRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.headlineSmall.color)) : SizedBox(),

                    wishController.removedSelectedId.length !=0 ?
                    InkWell(
                      onTap: () {
                        Get.dialog(ConfirmationDialog(icon: Images.clear_wishlist, description: 'are_you_sure_to_clear_wish_list'.tr, isLogOut: true, onYesPressed: () {
                          wishController.removeProductWishlist(-1, clearList: true);
                          Get.back();
                        }), useSafeArea: false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('clear_list'.tr, style: DMSansRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Color(0xFFF26F3F))),
                    )) : SizedBox(),
                  ]),
              ),

              wishController.wishProductList !=null ? wishController.wishProductList.length >0 ?
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: wishController.wishProductList.length,
                  itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    child: WishedProductWidget( productModel: wishController.wishProductList[index], index: index ),
                    onDismissed: (direction) {
                      wishController.removeProductWishlist(index);
                    },
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(Images.wish_list_delete, height: 20, width: 20),
                            Image.asset(Images.wish_list_delete, height: 20, width: 20)
                          ]))),
                        );
                      }
                 ),
              ) :
              Expanded(child: NoDataScreen(text: 'your_wish_list_is_empty'.tr, type: NoDataType.WISH)) : Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          );
        }
      ),
    );
  }
}
