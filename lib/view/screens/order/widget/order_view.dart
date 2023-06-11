import 'package:flutter_woocommerce/helper/date_converter.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/view/screens/order/controller/order_controller.dart';
import 'package:flutter_woocommerce/view/screens/order/model/order_model.dart';
import 'package:flutter_woocommerce/view/screens/order/order_details_screen.dart';
import 'package:flutter_woocommerce/view/screens/order/widget/order_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OrderView extends StatelessWidget {
  final bool isRunning;
  OrderView({@required this.isRunning});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController)
    {
      List<OrderModel> orderList;
      if (orderController.historyOrderModel != null &&
          orderController.historyOrderModel != null) {
        orderList = isRunning ? orderController.historyOrderModel : orderController.historyOrderModel;
      }

      return orderList != null ? orderList.length > 0 ? RefreshIndicator(
        onRefresh: () async {
          await orderController.getHistoryOrders(1);
        },
        // child:
        //
        // Column(
        //   children: [
        //     OrderWidget(),
        //   ],
        // )) : SizedBox() : SizedBox();

          child: Scrollbar(child: SingleChildScrollView(
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: PaginatedListView(
                scrollController: scrollController,
                dataList: orderList,
                onPaginate: (int offset) {
                  if(isRunning) {
                    // Get.find<OrderController>().getRunningOrders(offset);
                  }else {
                    Get.find<OrderController>().getHistoryOrders(offset);
                  }
                },
                itemView: ListView.builder(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  itemCount: orderList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          RouteHelper.getOrderDetailsRoute(orderList[index].id),
                          arguments: OrderDetailsScreen(orderModel: orderList[index]),
                        );
                      },
                      child: Container(
                        padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL) : null,
                        margin: ResponsiveHelper.isDesktop(context) ? EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL) : null,
                        decoration: ResponsiveHelper.isDesktop(context) ? BoxDecoration(
                          color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], blurRadius: 5, spreadRadius: 1)],
                        ) : null,
                        child: Column(children: [

                          Row(children: [

                            Stack(children: [
                              Container(
                                height: 60, width: 60, alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                  child: CustomImage(
                                    image: '',
                                    height: 60, width: 60, fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ]),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(children: [
                                  Text(
                                    '${'order_id'.tr}:',
                                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  ),
                                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  Text('#${orderList[index].id}', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                ]),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                Text(
                                  DateConverter.isoStringToLocalDateOnly(orderList[index].dateCreated),
                                  style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
                                ),
                              ]),
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Text(orderList[index].status.tr, style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor,
                                )),
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                              isRunning ? InkWell(
                                onTap: () => Get.toNamed(RouteHelper.getOrderTrackingRoute(orderList[index])),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                    border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                  ),
                                  child: Row(children: [
                                    Image.asset(Images.tracking, height: 15, width: 15, color: Theme.of(context).primaryColor),
                                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    Text('track_order'.tr, style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor,
                                    )),
                                  ]),
                                ),
                              ) : Text(
                                '${orderList[index].lineItems.length} ${orderList[index].lineItems.length > 1 ? 'items'.tr : 'item'.tr}',
                                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
                              ),
                            ]),

                          ]),

                          (index == orderList.length-1 || ResponsiveHelper.isDesktop(context)) ? SizedBox() : Padding(
                            padding: EdgeInsets.only(left: 70),
                            child: Divider(
                              color: Theme.of(context).disabledColor, height: Dimensions.PADDING_SIZE_LARGE,
                            ),
                          ),

                        ]),
                      ),
                    );
                  },
                ),
              ),
            ),
          )),
        ) : NoDataScreen(text: 'no_order_found'.tr) : OrderShimmer(orderController: orderController);
  }));
  }
}






























//Scrollbar(child: SingleChildScrollView(
//     controller: scrollController,
//     physics: AlwaysScrollableScrollPhysics(),
//     child: SizedBox(
//       width: Dimensions.WEB_MAX_WIDTH,
//       child: PaginatedListView(
//         scrollController: scrollController,
//         dataList: orderList,
//         onPaginate: (int offset) {
//           if(isRunning) {
//             Get.find<OrderController>().getRunningOrders(offset);
//           }else {
//             Get.find<OrderController>().getHistoryOrders(offset);
//           }
//         },
//         itemView: ListView.builder(
//           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//           itemCount: orderList.length,
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 Get.toNamed(
//                   RouteHelper.getOrderDetailsRoute(orderList[index].id),
//                   arguments: OrderDetailsScreen(orderModel: orderList[index]),
//                 );
//               },
//               child: Container(
//                 padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL) : null,
//                 margin: ResponsiveHelper.isDesktop(context) ? EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL) : null,
//                 decoration: ResponsiveHelper.isDesktop(context) ? BoxDecoration(
//                   color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                   boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], blurRadius: 5, spreadRadius: 1)],
//                 ) : null,
//                 child: Column(children: [
//
//                   Row(children: [
//
//                     Stack(children: [
//                       Container(
//                         height: 60, width: 60, alignment: Alignment.center,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                           child: CustomImage(
//                             image: '',
//                             height: 60, width: 60, fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ]),
//                     SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//
//                     Expanded(
//                       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                         Row(children: [
//                           Text(
//                             '${'order_id'.tr}:',
//                             style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
//                           ),
//                           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                           Text('#${orderList[index].id}', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
//                         ]),
//                         SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                         Text(
//                           DateConverter.isoStringToLocalDateOnly(orderList[index].dateCreated),
//                           style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
//                         ),
//                       ]),
//                     ),
//                     SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//
//                     Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         child: Text(orderList[index].status.tr, style: robotoMedium.copyWith(
//                           fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor,
//                         )),
//                       ),
//                       SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                       isRunning ? InkWell(
//                         onTap: () => Get.toNamed(RouteHelper.getOrderTrackingRoute(orderList[index])),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                             border: Border.all(width: 1, color: Theme.of(context).primaryColor),
//                           ),
//                           child: Row(children: [
//                             Image.asset(Images.tracking, height: 15, width: 15, color: Theme.of(context).primaryColor),
//                             SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                             Text('track_order'.tr, style: robotoMedium.copyWith(
//                               fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor,
//                             )),
//                           ]),
//                         ),
//                       ) : Text(
//                         '${orderList[index].lineItems.length} ${orderList[index].lineItems.length > 1 ? 'items'.tr : 'item'.tr}',
//                         style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
//                       ),
//                     ]),
//
//                   ]),
//
//                   (index == orderList.length-1 || ResponsiveHelper.isDesktop(context)) ? SizedBox() : Padding(
//                     padding: EdgeInsets.only(left: 70),
//                     child: Divider(
//                       color: Theme.of(context).disabledColor, height: Dimensions.PADDING_SIZE_LARGE,
//                     ),
//                   ),
//
//                 ]),
//               ),
//             );
//           },
//         ),
//       ),
//     ),
//   )),
// ) : NoDataScreen(text: 'no_order_found'.tr) : OrderShimmer(orderController: orderController);